# Overview

This repository contains a collection of scripts used by C3 to maintain Azure Virtual Desktop (AVD) hosts. These scripts are used within Nerdio, a management plane for AVD.

## Secure Variables

Throughout the repository, Nerdio secure variables are defined. These may consist of client-specific values, or FQDNs that should not be public. In order for these scripts to function correctly, each of the Secure Variables listed below must be defined in Nerdio > Settings > Nerdio Environment > Secure variables.

### List of Secure Variables

#### Required Secure Variables

- `ClientName`
- `AirlockAgent`
  - Defines a URL where the Airlock Agent is publicly available.
- `AirlockServer`
  - Defines the Airlock Server's FQDN.
- `AirlockPolicyId`
  - Defines the client's Airlock PolicyId.
- `CrowdstrikeID`
  - Defines the client's CrowdStrike identifier.
- `CrowdstrikeInstaller`
  - Defines a URL where the CrowdStrike Installer is publicly available.
- `CrowdstrikeUninstaller`
  - Defines a URL where the CrowdStrike Uninstaller is publicly available.
- `CsApiClientId`
  - CrowdStrike API Client ID. Used by uninstaller to remove from CS console.
- `CsApiClientSecret`
  - CrowdStrike API Client Secret. Used by uninstaller to remove from CS console.
- `msspLoggingAgent`
  - Defines a URL where the C3 MSSP Logging Agent is publicly available.
- `msspClientId`
  - Defines the client's C3 MSSP Client ID.

#### Optional Secure Variables

- `AirlockCaptureAgent`
  - Defines a URL where the Airlock Capture Agent is publicly available.
- `AirlockCaptureAgentFilename`
  - Defines a filename used by the Airlock Capture Agent. This must contain the servername. See C3 Internal KBs for additional information.
- `AirlockBaselineBuilder`
  - Defines a URL where the Airlock Baseline Builder is publicly available.
- `AirlockBaselineBuilderFilename`
  - Defines a filename used by the Airlock Baseline Builder. This must contain the servername. See C3 Internal KBs for additional information.
- `NVidiaDriverVersion`
