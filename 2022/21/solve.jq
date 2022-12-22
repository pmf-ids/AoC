#!/usr/bin/env -S jq --raw-input --null-input --from-file

# AoC 2022/21 with jq 1.6

def yell($m):
  .[$m] as [$_, $m1, $op, $m2] | [if $op then yell($m1, $m2) else $m1 | tonumber end]
  | if $op == "/" then first / last elif $op == "*" then first * last elif $op == "-" then first - last else add end;

# Parse input
[inputs / " "] | INDEX(first[:-1])

# Master part 1
| yell("root") as $root

# Master part 2
| .humn = [[$root | .*(-.,.)], 0] | .root[2] = "-" | .root[0] = yell("root")
| ([.humn[1] = .humn[0][] | yell("root")] | index(min)) as $side
| until(.root[0] == 0;
    .humn = [(.humn | .[0][1:0] = .[1:])[0][[.root[0] | -.,.] | (index(min) + $side) %2:][:2] | ., (add/2 | rint)]
    | .root[0] = yell("root")
  )

# Finalize outputs
| $root, .humn[1]
