#!/usr/bin/env -S jq --raw-input --from-file

# AoC 2022/06 with jq 1.6

# Master parts 1 and 2
. / "" | (4, 14) as $n | reduce while(.[:$n] | any(indices(.[]); has(1)); .[1:]) as $_ ($n; .+1)
