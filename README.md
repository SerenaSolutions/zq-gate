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
