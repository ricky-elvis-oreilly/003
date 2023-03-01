// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "./interfaces/ILayer.sol";

library Layers {
  struct Layer {
    bool isSeqSep;

    bool executed;

    address contractCallbackAddress;

    bytes4 startedCallbackFunctionSignature;
    bool started;

    bytes4 successCallbackFunctionSignature;
    bool success;

    bytes4 failureCallbackFunctionSignature;
    bool failure;
  }


  function init(
    Layer storage self,
    ILayer.LayerCallbackData memory _layerCallbackData
  ) internal {
    self.contractCallbackAddress = _layerCallbackData.contractCallbackAddress;
    self.startedCallbackFunctionSignature = _layerCallbackData.startedCallbackFunctionSignature;
    self.successCallbackFunctionSignature = _layerCallbackData.successCallbackFunctionSignature;
    self.failureCallbackFunctionSignature = _layerCallbackData.failureCallbackFunctionSignature;
  }

  function exec(Layer storage self) internal {
    self.executed = true;

    execStarted(self);
  }

  function execStarted(Layer storage self) internal {
    self.started = true;

    self.contractCallbackAddress.delegatecall(abi.encode(self.startedCallbackFunctionSignature));
  }
}
