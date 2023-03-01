// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "./interfaces/ILayer.sol";

import "./Layers.sol";

library Settings {
  using Layers for Layers.Layer;


  struct SettingToMakeATransfer {
    uint256 amountMin;
    uint256 amountMax;

    uint256 numLayers;
    mapping (uint256 => Layers.Layer) layers;
  }


  function setAmounts(
    SettingToMakeATransfer storage self,
    uint256 _amountMin,
    uint256 _amountMax
  ) internal {
    self.amountMin = _amountMin;
    self.amountMax = _amountMax;
  }

  function addLayer(
    SettingToMakeATransfer storage self,
    ILayer.LayerCallbackData memory _layerCallbackData
  ) internal returns (Layers.Layer storage) {
    Layers.Layer storage layer = self.layers[self.numLayers];

    layer.init(_layerCallbackData);

    self.numLayers++;

    return layer;
  }

  function execLayers(SettingToMakeATransfer storage self) internal {
    for (uint256 layerNum = 0; layerNum < self.numLayers; layerNum++) {
      self.layers[layerNum].exec();
    }
  }
}
