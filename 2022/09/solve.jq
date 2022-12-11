#!/usr/bin/env -S jq --raw-input --null-input --from-file

# AoC 2022/09 with jq 1.6

# Parse input
[inputs / " " | map(tonumber? // (explode[] | .%19, drem(.-2; 7) | .%2))]  # origo top left

# Master parts 1 and 2
| [2, 10] as $obs
| reduce .[] as [$axis, $step, $dist] ([[range($obs | max) | [0,0]], ($obs | map({}))];
    reduce range($dist) as $_ (.;
      
      # Rope
      first |= ([(first | .[$axis] += $step), .[1:]] | until(last == [];
        (.[-2:] | last |= first | transpose) as $comp | .[-1:] |= map(
          if $comp | any(first - last | fabs > 1)
          then ($comp | map(first - ((first - last) / 2 | rint))), .[1:]
          else .[], [] end
        ))[:-1])
      
      # Observer
      | reduce ($obs | keys[]) as $ob (.; last[$ob][first[$obs[$ob]-1] | @text] = 1)
      
    )
  )

# Finalize outputs
| last[] | length
