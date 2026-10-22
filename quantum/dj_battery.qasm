// ============================================================================
// ZQ-GATE — trivalent decision battery (Deutsch-Jozsa) in OpenQASM 3
// Quantum source of truth for the decision circuits the Python battery runs.
// One oracle call decides trivalently: constant-1 => 1, constant-0 => 0,
// balanced => REFUSED. Declared honestly: advantage is 1 oracle call vs
// 2^(n-1)+1 classical deterministic worst-case calls.
// ============================================================================
OPENQASM 3.0;
include "stdgates.inc";

// ---------------------------------------------------------------------------
// n = 4, oracle f constant = 1  ->  decision 1
// Phase kickback on the |-> ancilla is global for constant f: p(0^n) = 1
// ---------------------------------------------------------------------------
qubit[5] dj_c1;
bit[4] res_c1;
reset dj_c1;
x dj_c1[4];                 // ancilla |1>
h dj_c1[4];
h dj_c1[0]; h dj_c1[1]; h dj_c1[2]; h dj_c1[3];
x dj_c1[4];                 // oracle f(x)=1: flip ancilla (global phase)
h dj_c1[0]; h dj_c1[1]; h dj_c1[2]; h dj_c1[3];
measure dj_c1[0:4] -> res_c1;

// ---------------------------------------------------------------------------
// n = 4, oracle f constant = 0  ->  decision 0
// ---------------------------------------------------------------------------
qubit[5] dj_c0;
bit[4] res_c0;
reset dj_c0;
x dj_c0[4];
h dj_c0[4];
h dj_c0[0]; h dj_c0[1]; h dj_c0[2]; h dj_c0[3];
                            // oracle f(x)=0: identity
h dj_c0[0]; h dj_c0[1]; h dj_c0[2]; h dj_c0[3];
measure dj_c0[0:4] -> res_c0;

// ---------------------------------------------------------------------------
// n = 4, oracle f balanced f(x) = x0 xor x1  ->  decision REFUSED
// Interference cancels |0^n>: p(0^n) = 0 exactly
// ---------------------------------------------------------------------------
qubit[5] dj_bal;
bit[4] res_bal;
reset dj_bal;
x dj_bal[4];
h dj_bal[4];
h dj_bal[0]; h dj_bal[1]; h dj_bal[2]; h dj_bal[3];
cx dj_bal[0], dj_bal[4];    // oracle: x0 xor x1
cx dj_bal[1], dj_bal[4];
h dj_bal[0]; h dj_bal[1]; h dj_bal[2]; h dj_bal[3];
measure dj_bal[0:4] -> res_bal;

// ---------------------------------------------------------------------------
// n = 2 minimal case — the kernel's canonical battery (zyql_quantum_gate)
// constant-1 => 1, constant-0 => 0, balanced x0 xor x1 => REFUSED
// ---------------------------------------------------------------------------
qubit[3] dj2;
bit[2] res2;
reset dj2;
x dj2[2];
h dj2[2];
h dj2[0]; h dj2[1];
cx dj2[0], dj2[2];          // balanced oracle on n=2
cx dj2[1], dj2[2];
h dj2[0]; h dj2[1];
measure dj2[0:2] -> res2;

// ---------------------------------------------------------------------------
// n = 3, all three oracle cases — escalation of the trivalent decision
// constant-1 => 1, constant-0 => 0, balanced x0 xor x1 => REFUSED
// ---------------------------------------------------------------------------
qubit[4] dj3_c1;
bit[3] res3_c1;
reset dj3_c1;
x dj3_c1[3];
h dj3_c1[3];
h dj3_c1[0]; h dj3_c1[1]; h dj3_c1[2];
x dj3_c1[3];
h dj3_c1[0]; h dj3_c1[1]; h dj3_c1[2];
measure dj3_c1[0:3] -> res3_c1;

qubit[4] dj3_c0;
bit[3] res3_c0;
reset dj3_c0;
x dj3_c0[3];
h dj3_c0[3];
h dj3_c0[0]; h dj3_c0[1]; h dj3_c0[2];
h dj3_c0[0]; h dj3_c0[1]; h dj3_c0[2];
measure dj3_c0[0:3] -> res3_c0;

qubit[4] dj3_bal;
bit[3] res3_bal;
reset dj3_bal;
x dj3_bal[3];
h dj3_bal[3];
h dj3_bal[0]; h dj3_bal[1]; h dj3_bal[2];
cx dj3_bal[0], dj3_bal[3];
cx dj3_bal[1], dj3_bal[3];
h dj3_bal[0]; h dj3_bal[1]; h dj3_bal[2];
measure dj3_bal[0:3] -> res3_bal;

// ---------------------------------------------------------------------------
// Grover n = 2, target |11>, one iteration — amplification reference
// p(|11>) = 1.0 exactly in statevector arithmetic; the kernel battery uses
// it as the REFUSED-margin calibration anchor.
// ---------------------------------------------------------------------------
qubit[2] grover2;
bit[2] res_g2;
reset grover2;
h grover2[0]; h grover2[1];
cz grover2[0], grover2[1];
h grover2[0]; h grover2[1];
x grover2[0]; x grover2[1];
cz grover2[0], grover2[1];
x grover2[0]; x grover2[1];
h grover2[0]; h grover2[1];
measure grover2 -> res_g2;
