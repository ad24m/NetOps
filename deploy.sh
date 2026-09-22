#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")"
sudo containerlab deploy -t topology.clab.yml
