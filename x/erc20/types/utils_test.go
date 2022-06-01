package types

import (
	"testing"

	banktypes "github.com/cosmos/cosmos-sdk/x/bank/types"
	"github.com/stretchr/testify/require"
)

func TestSanitizeERC20Name(t *testing.T) {
	testCases := []struct {
		name         string
		erc20Name    string
		expErc20Name string
	}{
		{"name contains ' Token'", "Lucky Token", "lucky"},
		{"name contains ' Coin'", "Otter Coin", "otter"},
		{"name contains ' Token' and ' Coin'", "Lucky Token Coin", "lucky"},
		{"multiple words", "Hextris Early Access Demo", "hextris_early_access_demo"},
		{"single word name: Token", "Token", "token"},
		{"single word name: Coin", "Coin", "coin"},
	}

	for _, tc := range testCases {
		name := SanitizeERC20Name(tc.erc20Name)
		require.Equal(t, tc.expErc20Name, name, tc.name)
	}
}

func TestEqualMetadata(t *testing.T) {
	testCases := []struct {
		name      string
		metadataA banktypes.Metadata
		metadataB banktypes.Metadata
		expError  bool
	}{
		{
			"equal metadata",
			banktypes.Metadata{
				Base:        "aambinet",
				Display:     "ambinet",
				Name:        "Ambinet",
				Symbol:      "AMBINET",
				Description: "EVM, staking and governance denom of Ambinet",
				DenomUnits: []*banktypes.DenomUnit{
					{
						Denom:    "aambinet",
						Exponent: 0,
						Aliases:  []string{"atto ambinet"},
					},
					{
						Denom:    "ambinet",
						Exponent: 18,
					},
				},
			},
			banktypes.Metadata{
				Base:        "aambinet",
				Display:     "ambinet",
				Name:        "Ambinet",
				Symbol:      "AMBINET",
				Description: "EVM, staking and governance denom of Ambinet",
				DenomUnits: []*banktypes.DenomUnit{
					{
						Denom:    "aambinet",
						Exponent: 0,
						Aliases:  []string{"atto ambinet"},
					},
					{
						Denom:    "ambinet",
						Exponent: 18,
					},
				},
			},
			false,
		},
		{
			"different base field",
			banktypes.Metadata{
				Base: "aambinet",
			},
			banktypes.Metadata{
				Base: "taambinet",
			},
			true,
		},
		{
			"different denom units length",
			banktypes.Metadata{
				Base:        "aambinet",
				Display:     "ambinet",
				Name:        "Ambinet",
				Symbol:      "AMBINET",
				Description: "EVM, staking and governance denom of Ambinet",
				DenomUnits: []*banktypes.DenomUnit{
					{
						Denom:    "aambinet",
						Exponent: 0,
						Aliases:  []string{"atto ambinet"},
					},
					{
						Denom:    "ambinet",
						Exponent: 18,
					},
				},
			},
			banktypes.Metadata{
				Base:        "aambinet",
				Display:     "ambinet",
				Name:        "Ambinet",
				Symbol:      "AMBINET",
				Description: "EVM, staking and governance denom of Ambinet",
				DenomUnits: []*banktypes.DenomUnit{
					{
						Denom:    "aambinet",
						Exponent: 0,
						Aliases:  []string{"atto ambinet"},
					},
				},
			},
			true,
		},
		{
			"different denom units",
			banktypes.Metadata{
				Base:        "aambinet",
				Display:     "ambinet",
				Name:        "Ambinet",
				Symbol:      "AMBINET",
				Description: "EVM, staking and governance denom of Ambinet",
				DenomUnits: []*banktypes.DenomUnit{
					{
						Denom:    "aambinet",
						Exponent: 0,
						Aliases:  []string{"atto ambinet"},
					},
					{
						Denom:    "uambinet",
						Exponent: 12,
						Aliases:  []string{"micro ambinet"},
					},
					{
						Denom:    "ambinet",
						Exponent: 18,
					},
				},
			},
			banktypes.Metadata{
				Base:        "aambinet",
				Display:     "ambinet",
				Name:        "Ambinet",
				Symbol:      "AMBINET",
				Description: "EVM, staking and governance denom of Ambinet",
				DenomUnits: []*banktypes.DenomUnit{
					{
						Denom:    "aambinet",
						Exponent: 0,
						Aliases:  []string{"atto ambinet"},
					},
					{
						Denom:    "Uambinet",
						Exponent: 12,
						Aliases:  []string{"micro ambinet"},
					},
					{
						Denom:    "ambinet",
						Exponent: 18,
					},
				},
			},
			true,
		},
	}

	for _, tc := range testCases {
		err := EqualMetadata(tc.metadataA, tc.metadataB)
		if tc.expError {
			require.Error(t, err)
		} else {
			require.NoError(t, err)
		}
	}
}

func TestEqualAliases(t *testing.T) {
	testCases := []struct {
		name     string
		aliasesA []string
		aliasesB []string
		expEqual bool
	}{
		{
			"empty",
			[]string{},
			[]string{},
			true,
		},
		{
			"different lengths",
			[]string{},
			[]string{"atto ambinet"},
			false,
		},
		{
			"different values",
			[]string{"attoambinet"},
			[]string{"atto ambinet"},
			false,
		},
		{
			"same values, unsorted",
			[]string{"atto ambinet", "aambinet"},
			[]string{"aambinet", "atto ambinet"},
			false,
		},
		{
			"same values, sorted",
			[]string{"aambinet", "atto ambinet"},
			[]string{"aambinet", "atto ambinet"},
			true,
		},
	}

	for _, tc := range testCases {
		require.Equal(t, tc.expEqual, EqualStringSlice(tc.aliasesA, tc.aliasesB), tc.name)
	}
}
