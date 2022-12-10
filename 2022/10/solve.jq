#!/usr/bin/env -S jq --raw-input --null-input --raw-output --from-file

# AoC 2022/10 with jq 1.6

# Parse input
reduce ((inputs / " ")[] | tonumber? // 0) as $p ([1]; . + [last + $p]) | to_entries

# Master part 1
| ([(20,60,100,140,180,220) as $p | $p * .[$p - 1].value] | add)

# Master part 2
, (map(if .key % 40 - .value | 1 >= fabs then "#" else " " end)[:-1] | _nwise(40) | add)
