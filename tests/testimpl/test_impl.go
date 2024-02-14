package common

import (
	"context"
	"os"
	"testing"

	"github.com/Azure/azure-sdk-for-go/sdk/azcore"
	"github.com/Azure/azure-sdk-for-go/sdk/azcore/arm"
	"github.com/Azure/azure-sdk-for-go/sdk/azcore/cloud"
	"github.com/Azure/azure-sdk-for-go/sdk/azidentity"
	"github.com/Azure/azure-sdk-for-go/sdk/resourcemanager/network/armnetwork/v5"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/nexient-llc/lcaf-component-terratest-common/types"
	"github.com/stretchr/testify/assert"
)

func TestVnetPeering(t *testing.T, testContext types.TestContext) {
	rgName := terraform.Output(t, testContext.TerratestTerraformOptions(), "resource_group_name")
	vnetNames := terraform.OutputMap(t, testContext.TerratestTerraformOptions(), "vnet_names")
	peeringNames := terraform.OutputMap(t, testContext.TerratestTerraformOptions(), "names")

	keys := make([]string, 0, len(peeringNames))

	for k := range peeringNames {
		keys = append(keys, k)
	}
	subscriptionId := os.Getenv("AZURE_SUBSCRIPTION_ID")
	credential, err := azidentity.NewDefaultAzureCredential(nil)
	if err != nil {
		t.Fatalf("Unable to get credentials: %e\n", err)
	}
	options := arm.ClientOptions{
		ClientOptions: azcore.ClientOptions{
			Cloud: cloud.AzurePublic,
		},
	}
	vnetPeeringClient, err := armnetwork.NewVirtualNetworkPeeringsClient(subscriptionId, credential, &options)
	if err != nil {
		t.Fatalf("Failed to get create client: %e\n", err)
	}
	ctx := context.Background()
	vnetPeering, err := vnetPeeringClient.Get(ctx, rgName, vnetNames[keys[0]], peeringNames[keys[0]], nil)
	if err != nil {
		t.Fatalf("Failed to get Peering connection: %e\n", err)
	}
	t.Run("TwoPeeringConnectionExists", func(t *testing.T) {
		assert.Equal(t, len(keys), 2, "Number of peerings must be 2")
	})

	t.Run("PeeringConnectionExists", func(t *testing.T) {
		assert.Equal(t, peeringNames[keys[0]], *vnetPeering.Name, "Peering name must match")
	})
	vnetPeering, err = vnetPeeringClient.Get(ctx, rgName, vnetNames[keys[1]], peeringNames[keys[1]], nil)
	if err != nil {
		t.Fatalf("Failed to get Reverse Peering connection: %e\n", err)
	}
	t.Run("ReversePeeringConnectionExists", func(t *testing.T) {
		assert.Equal(t, peeringNames[keys[1]], *vnetPeering.Name, "Peering name must match")
	})
	t.Run("PeeringStateIsConnected", func(t *testing.T) {
		assert.Equal(t, string(*vnetPeering.Properties.PeeringState), "Connected", "Peering must be in connected state")
	})

}

func TestComposableComplete(t *testing.T, testContext types.TestContext) {
	TestVnetPeering(t, testContext)
}
