#!/bin/sh

omarchy-install-tailscale

./scripts/install-stow.sh
./scripts/enable-ssh-agent-service.sh
