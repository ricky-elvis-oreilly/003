// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

import "./Settings.sol";

abstract contract SettingsClient {
  uint256 numSettingsToMakeATransfer;
  mapping (uint256 => Settings.SettingToMakeATransfer) SettingsToMakeATransfer;


  function settingToMakeATransfer() internal returns (Settings.SettingToMakeATransfer storage) {
    Settings.SettingToMakeATransfer storage created = SettingsToMakeATransfer[numSettingsToMakeATransfer];

    numSettingsToMakeATransfer++;

    return created;
  }
}
