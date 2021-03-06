#!/usr/bin/env bash

set -o errexit

function test() {
    local bin=$1
    local features=${2-,}
    
    cargo rb "$bin" --features "$features" | tee "src/bin/$bin.out.new" | diff "src/bin/$bin.out" -
    cargo rrb "$bin" --features "$features" | tee "src/bin/$bin.release.out.new" | diff "src/bin/$bin.release.out" -
}

test "log"
if rustc -V | grep nightly; then
    test "alloc" "alloc"
fi
