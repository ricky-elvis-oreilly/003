// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

interface ILayer {
  struct LayerCallbackData {
    address contractCallbackAddress;
    bytes4 startedCallbackFunctionSignature;
    bytes4 successCallbackFunctionSignature;
    bytes4 failureCallbackFunctionSignature;
  }
}
