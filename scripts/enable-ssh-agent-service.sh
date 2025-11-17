#!/bin/sh

# enable ssh-agent service
systemctl --user daemon-reload
systemctl --user enable --now ssh-agent.service

