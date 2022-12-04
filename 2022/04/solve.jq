#!/usr/bin/env -S jq --raw-input --null-input --from-file

# AoC 2022/04 with jq 1.6

# Parse input
[inputs | [scan("\\d+") | tonumber]]

# Master parts 1 and 2
| ., map([.[0,1,3,2]])

# Finalize outputs
| map(select((.[0] - .[2]) * (.[1] - .[3]) <= 0)) | length
