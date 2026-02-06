#!/bin/sh

# enable opencode service
systemctl --user daemon-reload
systemctl --user enable --now opencode.service
