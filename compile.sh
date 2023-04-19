#!/bin/bash
# compile/prove/verify

power=7

if [ "x" != "x$2" ]; then
    echo "replace input.json..."
    sed -e "s/INPUT1/$2/g" -e "s/INPUT2/$3/g" input.template > input.json
fi

snarkjs="/Users/chao/opensource/appliedzkp/snarkjs/cli.cjs"

echo "removing old folder..."
rm -rf $1_js
echo "compiling..."
circom $1.circom --r1cs --wasm --sym 
echo "gen witness..."
node $1_js/generate_witness.js $1_js/$1.wasm input.json witness.wtns

echo "setup zkeys..."
$snarkjs groth16 setup $1.r1cs "pot"$power".ptau" $1.zkey
echo "export vkeys..."
$snarkjs zkey export verificationkey $1.zkey vkey.json

echo "prove..."
$snarkjs groth16 prove $1.zkey witness.wtns proof.json public.json

echo "verify..."
$snarkjs groth16 verify vkey.json public.json proof.json
