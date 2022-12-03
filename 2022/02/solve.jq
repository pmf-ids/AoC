#!/usr/bin/env -S jq --raw-input --null-input --from-file

# AoC 2022/02 with jq 1.6

# Parse input
[inputs | [explode[0,2] % 4]]

# Master parts 1 and 2
| ., map(last = (add + 1) % 3)

# Finalize outputs
| map(last + 1 + (last - first + 5) % 3 * 3) | add
