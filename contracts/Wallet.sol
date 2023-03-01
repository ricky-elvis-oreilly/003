// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "./interfaces/ILayer.sol";

import "./SettingsClient.sol";

contract Wallet is SettingsClient {
  ILayer.LayerCallbackData private layerCallbackData;

  function setLayerCallbackData(
    address _contractCallbackAddress,
    bytes4 _startedCallbackFunctionSignature,
    bytes4 _successCallbackFunctionSignature,
    bytes4 _failureCallbackFunctionSignature
  ) private {
    layerCallbackData = ILayer.LayerCallbackData({
      contractCallbackAddress: _contractCallbackAddress,
      startedCallbackFunctionSignature: _startedCallbackFunctionSignature,
      successCallbackFunctionSignature: _successCallbackFunctionSignature,
      failureCallbackFunctionSignature: _failureCallbackFunctionSignature
    });
  }


  using Settings for Settings.SettingToMakeATransfer;

  using Layers for Layers.Layer;


  event HandleLayerStarted();
  event HandleLayerSuccess();
  event HandleLayerFailure();


  function handleLayerStarted() public {
    emit HandleLayerStarted();
  }

  function handleLayerSuccess() public {
    emit HandleLayerSuccess();
  }

  function handleLayerFailure() public {
    emit HandleLayerFailure();
  }


  event Foo(bool executed, bool started);

  function test() public {
    /**************************************************************************/
    setLayerCallbackData(
      address(this),
      this.handleLayerStarted.selector,
      this.handleLayerSuccess.selector,
      this.handleLayerFailure.selector
    );
    /**************************************************************************/

    Settings.SettingToMakeATransfer storage setting0 = settingToMakeATransfer();
    Settings.SettingToMakeATransfer storage setting1 = settingToMakeATransfer();

    Layers.Layer storage layerSet0Lay0 = setting0.addLayer(layerCallbackData);
    Layers.Layer storage layerSet0Lay1 = setting0.addLayer(layerCallbackData);

    setting0.execLayers();
  }
}
