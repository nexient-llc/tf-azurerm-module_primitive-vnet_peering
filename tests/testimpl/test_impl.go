package common

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/nexient-llc/lcaf-component-terratest-common/types"
	"github.com/stretchr/testify/assert"
)

func TestComposableComplete(t *testing.T, ctx types.TestContext) {
	t.Run("TestAlwaysSucceeds", func(t *testing.T) {
		assert.Equal(t, "foo", "foo", "Should always be the same!")
		assert.NotEqual(t, "foo", "bar", "Should never be the same!")
	})

	// When cloning the skeleton to a new module, you will need to change the below test
	// to meet your needs and add any new tests that apply to your situation.
	t.Run("TestVNetPeering", func(t *testing.T) {
		output := terraform.Output(t, ctx.TerratestTerraformOptions, "id")

		// Output contains only alphanumeric characters and 🍰
		assert.NotEmpty(t, output, "ID must not be empty")
	})
}
