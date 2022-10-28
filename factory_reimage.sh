#!/bin/bash
sudo NOPROMPT=1 POWEROFF=1 "${BASH_SOURCE[0]%/*}"/repair_device.sh sanitize
sudo NOPROMPT=1 POWEROFF=1 "${BASH_SOURCE[0]%/*}"/repair_device.sh all
