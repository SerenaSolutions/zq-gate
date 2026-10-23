# ZQ-GATE

![ZQ-GATE](https://img.shields.io/badge/decision-trivalent%201%2F0%2FREFUSED-blue) ![license](https://img.shields.io/badge/license-MIT-blue)

**Run the ZeptonQL trivalent decision battery in CI.** Decisions come from quantum interference (Deutsch-Jozsa, one oracle call): constant `1`, constant `0`, balanced `REFUSED`. All pass = green; anything else fails the job. *Nothing executes silently.*

Fully offline (noiseless kernel, no IBM account). Mode via input `battery`:

```yaml
- name: Trivalent decision battery
  uses: SerenaSolutions/zq-gate@v1
  with:
    battery: all          # all | battery | verify-receipts
```

## Semantics (declared honestly)

| Oracle promise | Measurement | Decision |
|---|---|---|
| f constant = 1 | `\|00..0>` | **1** |
| f constant = 0 | `\|00..0>` | **0** |
| f balanced | anything else | **REFUSED** |

Quantum advantage declared, never inflated: 1 oracle call vs 2^(n-1)+1
classical deterministic worst-case calls.

Free forever, MIT. Part of the ZEPHIRUM product line: [zqea-verify](https://github.com/marketplace/actions/z-qea-receipt-verifier), [z-anyon-lab](https://github.com/SerenaSolutions/z-anyon-lab), [zqea-seal](https://github.com/SerenaSolutions/zqea-seal).

## Prova de conceito (hardware real)

Bateria trivalente completa (1/0/RECUSADO) executada no silício da IBM, job `dbcnp4s24mrc73ck0v80` (ibm_marrakesh, 512 shots).

Recibo selado: [`poc/receipt_zqgate_hw.json`](poc/receipt_zqgate_hw.json) — verificável com `python3 zqea_verify.py poc/receipt_zqgate_hw.json --strict-pq`.

Bateria completa do confronto multilíngue (OpenQASM 3, Qiskit, Cirq, PennyLane, Braket, Q#): [SerenaSolutions/quantum-poc](https://github.com/SerenaSolutions/quantum-poc).

## Changelog

### v1.1.0 (2026-10-23)
- Kernel ZYQL v1.9.0: `ZYQL_EPSILON` (margem adaptativa) + porta GHZ do dispositivo.
- BUGFIX: oracle balanced `x ^ 1` → `x & 1` (interferência limpa, p0=0.0).
