#!/usr/bin/env -S jq --raw-input --null-input --from-file

# AoC 2022/03 with jq 1.6

# Parse input
[inputs | [(explode[] - 38) % 58]]

# Master parts 1 and 2
| map([_nwise(length / 2)]), [_nwise(3)]

# Finalize outputs
| map(until(length < 2; .[:2] |= [first - (first - last)]) | first | first) | add
