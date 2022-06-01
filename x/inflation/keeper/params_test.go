package keeper_test

import (
	"github.com/hardiksa/ambinet/v4/x/inflation/types"
)

func (suite *KeeperTestSuite) TestParams() {
	params := suite.app.InflationKeeper.GetParams(suite.ctx)
	expParams := types.DefaultParams()

	suite.Require().Equal(expParams, params)

	suite.app.InflationKeeper.SetParams(suite.ctx, params)
	newParams := suite.app.InflationKeeper.GetParams(suite.ctx)
	suite.Require().Equal(newParams, params)
}
