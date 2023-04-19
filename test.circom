pragma circom 2.0.0;

template Test() {
    signal input a;
    signal input b;
    signal output c;
    signal output d;

    // babyjubjub Fr, r value
    // var r = 21888242871839275222246405745257275088548364400416034343698204186575808495617;
    // a = r - 2**n, b = 2, z= p -2 (n-th bit is zero for small n)
    var n = 3;
    var z = a + (1<<n) - b;
    var bit = (z >> n) & 1;

    // a > b we expect bit=0 (if a,b are less than n bits)
    log(a);
    log(b);
    log(bit);

    // need multiplication to avoid compiling error
    c <== a * b;
    d <== a * a;
 }

 component main = Test();
