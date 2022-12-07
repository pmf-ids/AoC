#!/usr/bin/env -S jq --raw-input --null-input --from-file

# AoC 2022/07 with jq 1.6

# Parse input
reduce (inputs | capture("^(\\$ cd (?<cd>.*)|(?<size>\\d+) (?<file>.*))$"))
  as {$cd, $file, $size} ({};
    if $file then setpath(."" + [$file]; $size | tonumber)
    else ."" |= if $cd == "/" then [] elif $cd == ".." then .[:-1] else . + [$cd] end
    end
  )
| [..|objects | [..|numbers] | add]

# Master part 1
| (map(select(. <= 100000)) | add)

# Master part 2
, ((max - 40000000) as $th | map(select(. >= $th)) | min)
