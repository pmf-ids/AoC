#!/usr/bin/env -S jq --raw-input --null-input --from-file

# AoC 2022/01 with jq 1.6

# Parse input
[[inputs] | (join(",") / ",,")[] / "," | map(tonumber) | add]

# Master parts 1 and 2
| max, (sort[-3:] | add)
