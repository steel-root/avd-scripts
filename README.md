# Overview

This repository contains a collection of scripts used by C3 to maintain Azure Virtual Desktop (AVD) hosts. These scripts are used within Nerdio, a management plane for AVD.

## Secure Variables

Throughout the repository, Nerdio secure variables are defined. These may consist of client-specific values, or FQDNs that should not be public. In order for these scripts to function correctly, each of the Secure Variables listed below must be defined in Nerdio > Settings > Nerdio Environment > Secure variables.

### List of Secure Variables

#### Required Secure Variables

- `ClientName`
- `InstallersURL`
  - Defines a URL where all installers are available.
- `AirlockServer`
  - Defines the Airlock Server's FQDN.
- `AirlockPolicyId`
  - Defines the client's Airlock PolicyId.
- `CrowdstrikeID`
  - Defines the client's CrowdStrike identifier.
- `CsApiClientId`
  - CrowdStrike API Client ID. Used by uninstaller to remove from CS console.
- `CsApiClientSecret`
  - CrowdStrike API Client Secret. Used by uninstaller to remove from CS console.
- `msspClientId`
  - Defines the client's C3 MSSP Client ID.

#### Optional Secure Variables

- `AirlockCaptureAgentFilename`
  - Defines a filename used by the Airlock Capture Agent. This must contain the servername. See C3 Internal KBs for additional information.
- `AirlockBaselineBuilderFilename`
  - Defines a filename used by the Airlock Baseline Builder. This must contain the servername. See C3 Internal KBs for additional information.
- `NVidiaDriverVersion`
