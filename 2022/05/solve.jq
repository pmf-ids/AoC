#!/usr/bin/env -S jq --raw-input --null-input --raw-output --from-file

# AoC 2022/05 with jq 1.6

# Parse input
[inputs] | index("") as $p | {
  stacks: .[:$p-1] | map([while(. != ""; .[4:])[1:2]]) | transpose | map(map(select(. != " "))),
  moves: .[$p+1:] | map([scan("\\d+") | tonumber] | .[1,2] -= 1)
}

# Master parts 1 and 2
| (false, true) as $cm9001

# Finalize outputs
| reduce .moves[] as [$count, $from, $to] (.stacks;
    .[$to] = (.[$from][:$count] | select($cm9001) // reverse) + .[$to] | .[$from] |= .[$count:]
  )
| map(first) | add
