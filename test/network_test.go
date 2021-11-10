package test

import (
	"fmt"
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
	"github.com/stretchr/testify/require"
)

func initTestCases() []NetworkingModuleTestCase {
	return []NetworkingModuleTestCase{
		{
			testName:         "Test1",
			expectApplyError: false,
			vars: map[string]interface{}{
				"vpc_cidr_block":                "172.38.0.0/20",
				"ingress_cidr_blocks":           []string{"0.0.0.0/0"},
				"data_subnet_cidr_blocks":       []string{"172.38.0.0/24", "172.38.1.0/24"},
				"application_subnet_cidr_block": "172.38.2.0/24",
				"compute_subnet_cidr_block":     "172.38.3.0/24",
				"public_subnets_cidr_blocks":    []string{"172.38.4.0/24"},
				"availability_zones":            make([]string, 2),
				"create_public_subnets":         false,
				"create_load_balancing_subnets": false,
				"enable_nat_gateway":            false,
				"tags":                          make(map[string]string),
			},
		},
		{
			testName:         "Test2",
			expectApplyError: true,
			vars: map[string]interface{}{
				"vpc_cidr_block":                "0.0.0.0/0",
				"ingress_cidr_blocks":           []string{"0.0.0.0/0"},
				"data_subnet_cidr_blocks":       []string{"172.38.0.0/24", "172.38.1.0/24"},
				"application_subnet_cidr_block": "172.38.2.0/24",
				"compute_subnet_cidr_block":     "172.38.3.0/24",
				"public_subnets_cidr_blocks":    []string{"172.38.4.0/24"},
				"availability_zones":            make([]string, 2),
				"create_public_subnets":         false,
				"create_load_balancing_subnets": false,
				"enable_nat_gateway":            false,
				"tags":                          make(map[string]string),
			},
		},
	}
}
func TestMinimalTamrNetwork(t *testing.T) {
	// For convenience - uncomment these as well as the "os" import
	// when doing local testing if you need to skip any sections.
	//
	// A common usage for this would be skipping teardown first (keeping infrastructure)
	// and then in your next run skip the setup* and create* steps. This way you can keep testing
	// your Go test against your infrastructure quicker. Be mindful of random-ids, as they would be updated
	// on each run, which would make some assertions fail.

	// os.Setenv("SKIP_", "true")
	// os.Setenv("TERRATEST_REGION", "us-east-1")

	// os.Setenv("SKIP_setup_options", "true")
	// os.Setenv("SKIP_create_network", "true")
	// os.Setenv("SKIP_validate_network", "true")

	// os.Setenv("SKIP_teardown", "true")

	// list of different buckets that will be created to be tested
	testCases := initTestCases()

	awsRegion := aws.GetRandomStableRegion(t, []string{"us-east-1", "us-east-2", "us-west-1", "us-west-2"}, nil)

	for _, testCase := range testCases {
		// The following is necessary to make sure testCase's values don't
		// get updated due to concurrency within the scope of t.Run(..) below
		testCase := testCase

		t.Run(testCase.testName, func(t *testing.T) {
			t.Parallel()

			// this creates a tempTestFolder for each testCase
			tempTestFolder := test_structure.CopyTerraformFolderToTemp(t, "..", "test_examples/minimal")

			expectedName := fmt.Sprintf("terratest-vpc-%s", strings.ToLower(random.UniqueId()))
			testCase.vars["tags"].(map[string]string)["Name"] = expectedName

			testCase.vars["availability_zones"] = []string{
				fmt.Sprintf("%sa", awsRegion),
				fmt.Sprintf("%sb", awsRegion),
			}

			test_structure.RunTestStage(t, "setup_options", func() {
				terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
					TerraformDir: tempTestFolder,
					Vars:         testCase.vars,
					EnvVars: map[string]string{
						"AWS_REGION": awsRegion,
					},
				})

				test_structure.SaveTerraformOptions(t, tempTestFolder, terraformOptions)
			})

			test_structure.RunTestStage(t, "create_network", func() {
				terraformOptions := test_structure.LoadTerraformOptions(t, tempTestFolder)

				_, err := terraform.InitAndApplyE(t, terraformOptions)

				if testCase.expectApplyError {
					require.Error(t, err)
					// If it failed as expected, we should skip the rest (validate function).
					t.SkipNow()
				}
			})

			defer test_structure.RunTestStage(t, "teardown", func() {
				teraformOptions := test_structure.LoadTerraformOptions(t, tempTestFolder)
				terraform.Destroy(t, teraformOptions)
			})

			test_structure.RunTestStage(t, "validate_network", func() {
				terraformOptions := test_structure.LoadTerraformOptions(t, tempTestFolder)
				validateNetwork(t,
					terraformOptions,
					awsRegion,
					expectedName,
					testCase.vars["availability_zones"].([]string),
				)
			})

		})
	}
}

//first test with new CA-50
