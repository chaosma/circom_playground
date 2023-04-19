#!/bin/bash
# setup once 

snarkjs="/Users/chao/opensource/appliedzkp/snarkjs/cli.cjs"

if [ "x" = "x$1" ]; then
    echo "please specify setup power..."
    exit 1
fi

power=$1

echo "powers of tau ceremony..."
$snarkjs powersoftau new bn128 $power "pot"$power"_0.ptau" -v

# echo "phase2..."
$snarkjs powersoftau prepare phase2 "pot"$power"_0.ptau" "pot"$power".ptau" -v

rm "pot"$power"_0.ptau"
