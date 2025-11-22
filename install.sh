#!/bin/sh

omarchy-install-tailscale

./scripts/install-stow.sh
./scripts/enable-ssh-agent-service.sh
./scripts/install-xremap.sh
./scripts/install-yazi.sh
