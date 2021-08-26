package test

import (
	"fmt"
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
)

func TestTerraformTamrNetwork(t *testing.T) {
	t.Parallel()

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
	// os.Setenv("SKIP_create_bucket", "true")
	// os.Setenv("SKIP_validate_bucket", "true")
	// os.Setenv("SKIP_create_ro_objects", "true")
	// os.Setenv("SKIP_setup_role_options", "true")
	// os.Setenv("SKIP_create_role", "true")
	// os.Setenv("SKIP_validate_bucket_and_policies", "true")

	// os.Setenv("SKIP_teardown", "true")

	// list of different buckets that will be created to be tested
	var testCases = []NetworkingModuleTestCase{
		{
			testName:                   "Test1",
			vpcCIDRBlock:               "172.38.0.0/20",
			ingressCIDRBlocks:          []string{"0.0.0.0/0"},
			dataSubnetCIDRBlocks:       []string{"172.38.0.0/24", "172.38.1.0/24"},
			applicationSubnetCIDRBlock: "172.38.2.0/24",
			computeSubnetCIDRBlock:     "172.38.3.0/24",
			publicSubnetCIDRBlocks:     []string{"172.38.4.0/24"},
			availabilityZones:          make([]string, 2),
			tags:                       make(map[string]string),
		},
		// {
		// 	testName:                   "Test1",
		// 	vpcCIDRBlock:               "172.38.0.0/24",
		// 	ingressCIDRBlocks:          []string{"0.0.0.0/0"},
		// 	dataSubnetCIDRBlocks:       []string{"172.38.0.0/28", "172.38.1.0/28"},
		// 	applicationSubnetCIDRBlock: "172.38.2.0/28",
		// 	computeSubnetCIDRBlock:     "172.38.3.0/28",
		// 	publicSubnetCIDRBlocks:     []string{"172.38.4.0/28"},
		// 	availabilityZones:          make([]string, 2),
		// 	tags:                       make(map[string]string),
		// },
	}

	awsRegion := aws.GetRandomStableRegion(t, []string{"us-east-1", "us-east-2", "us-west-1", "us-west-2"}, nil)

	for _, testCase := range testCases {
		// The following is necessary to make sure testCase's values don't
		// get updated due to concurrency within the scope of t.Run(..) below
		testCase := testCase

		t.Run(testCase.testName, func(t *testing.T) {
			t.Parallel()

			// This is ugly - but attempt to stagger the test cases to
			// avoid a concurrency issue
			// time.Sleep(time.Duration(testCase.sleepDuration) * time.Second)

			// this creates a tempTestFolder for each testCase
			tempTestFolder := test_structure.CopyTerraformFolderToTemp(t, "..", "test_examples/minimal")

			expectedName := fmt.Sprintf("terratest-vpc-%s", strings.ToLower(random.UniqueId()))
			testCase.tags["Name"] = expectedName

			testCase.availabilityZones = []string{
				fmt.Sprintf("%sa", awsRegion),
				fmt.Sprintf("%sb", awsRegion),
			}

			defer test_structure.RunTestStage(t, "teardown", func() {
				teraformOptions := test_structure.LoadTerraformOptions(t, tempTestFolder)
				terraform.Destroy(t, teraformOptions)
			})

			test_structure.RunTestStage(t, "setup_options", func() {
				terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
					TerraformDir: tempTestFolder,
					Vars: map[string]interface{}{
						"vpc_cidr_block":                testCase.vpcCIDRBlock,
						"ingress_cidr_blocks":           testCase.ingressCIDRBlocks,
						"data_subnet_cidr_blocks":       testCase.dataSubnetCIDRBlocks,
						"application_subnet_cidr_block": testCase.applicationSubnetCIDRBlock,
						"compute_subnet_cidr_block":     testCase.computeSubnetCIDRBlock,
						"public_subnets_cidr_blocks":    testCase.publicSubnetCIDRBlocks,
						"availability_zones":            testCase.availabilityZones,
						"tags":                          testCase.tags,
					},
					EnvVars: map[string]string{
						"AWS_REGION": awsRegion,
					},
				})

				test_structure.SaveTerraformOptions(t, tempTestFolder, terraformOptions)
			})

			test_structure.RunTestStage(t, "create_network", func() {
				terraformOptions := test_structure.LoadTerraformOptions(t, tempTestFolder)
				terraform.InitAndApply(t, terraformOptions)
			})

			test_structure.RunTestStage(t, "validate_network", func() {
				terraformOptions := test_structure.LoadTerraformOptions(t, tempTestFolder)
				validateNetwork(t, terraformOptions, awsRegion, expectedName, testCase.availabilityZones)
			})

		})
	}
}
