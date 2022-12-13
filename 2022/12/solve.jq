#!/usr/bin/env -S jq --raw-input --null-input --from-file

# AoC 2022/12 with jq 1.6

# Parse input
[inputs]
| (map([indices("S","E","a")]) | transpose | map([keys[] as $k | "\(.[$k][]),\($k)"])) as [$S,$E,$a]

# Master parts 1 and 2
| ($S, $a) as $start

| [ keys[] as $y | .[$y] | sub("S";"a") | sub("E";"z") | explode
  | keys[] as $x | "\($x),\($y)" as $xy | {($xy): [$x, $y, .[$x], (IN($start[]; $xy) | not // 0)]}
  ] | [add, $start[]]

| until(index($E[0]); .[1] as $from | reduce ((-1,1) | [0,.], [.,0]) as [$x,$y] (.;
    (first[$from] | [$x+.[0], $y+.[1]] | join(",")) as $to
    | if all((index($to) | not), (first | .[$to], .[$from][2]+1 >= .[$to][2], .[$from][3] > .[$to][3]); .)
      then (first[$to][3] = first[$from][3] - 1) + [$to] else . end
  ) | .[1:] |= .[1:])

# Finalize outputs
| -first[$E[0]][3]
