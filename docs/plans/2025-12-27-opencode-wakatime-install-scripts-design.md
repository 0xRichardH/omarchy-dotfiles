# Design: Opencode Wakatime & Plugin Installer Scripts

## Context
The user wants to automate the installation of the Opencode Wakatime plugin and consolidate Opencode plugin installation into a single master script. Existing scripts live in `scripts/`.

## Goals
1.  Create `scripts/install-opencode-wakatime.sh` to install the Wakatime plugin via npm.
2.  Create `scripts/install-opencode-plugins.sh` to run both the existing Superpowers installer and the new Wakatime installer.

## Detailed Design

### 1. Wakatime Installer (`scripts/install-opencode-wakatime.sh`)
**Purpose:** Install `opencode-wakatime` globally and register it.

**Implementation Details:**
-   **Shebang:** `#!/bin/sh`
-   **Error Handling:** `set -eu` to fail on error or undefined variables.
-   **Prerequisites:** Check for `npm` availability.
-   **Commands:**
    -   `npm install -g opencode-wakatime`
    -   `opencode-wakatime --install`
-   **Output:** Informational messages for each step.

### 2. Master Installer (`scripts/install-opencode-plugins.sh`)
**Purpose:** centralized entry point for installing all Opencode plugins.

**Implementation Details:**
-   **Shebang:** `#!/bin/sh`
-   **Error Handling:** `set -eu`
-   **Path Resolution:** Use `SCRIPT_DIR="$(dirname "$0")"` to reliably locate sibling scripts.
-   **Orchestration:**
    -   Run `$SCRIPT_DIR/install-opencode-superpowers.sh`
    -   Run `$SCRIPT_DIR/install-opencode-wakatime.sh`

## Verification Plan
1.  Verify file creation.
2.  Verify execution permissions (`chmod +x`).
3.  (Optional) Dry-run verification if environment allows, or reliance on user to run.

## Open Questions
None. User approved the specific bash implementation.
