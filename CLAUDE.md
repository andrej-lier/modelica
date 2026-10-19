# CLAUDE.md – Project context

## Goal
**Physical system model of an electric multicopter powertrain + comparison of surrogate models.**
This is a public portfolio project: a reader should understand in < 2 minutes what is shown here.

1. A clean, parametrised Modelica model (OpenModelica, free → anyone can reproduce it):
   battery → ESC → BLDC motor → propeller, driven by a flight mission profile.
2. Python pipeline that runs the model as an FMU (FMPy) and generates parameter studies / training data.
3. Surrogate models compared head to head:
   - classical: model order reduction (POD, DMD)
   - data-driven: neural network (PyTorch), optionally physics-informed (PINN)
   - criteria: accuracy vs. runtime vs. extrapolation beyond the training data
4. Results in the README with plots, reproducible by script.

Target statement: "Full model X s, surrogate Y ms, error Z % – and here are the limits."

## Reference vehicle
2 kg inspection quadcopter: 4 × T-Motor MN3508 KV580, 13×4.4 in propellers, 4S LiPo.
Parameters and their sources: `docs/parameters.md`.

## Model scope (Phase 1 – start lean)
- **Battery:** equivalent circuit (OCV(SoC) + R0 + 1–2 RC elements), lumped thermal model (one heat capacity)
- **ESC:** averaged model (no switching), efficiency map or constant efficiency
- **BLDC motor:** DC equivalent model (Kv, R, L, inertia, friction)
- **Propeller:** thrust/torque from C_T, C_P (speed, diameter, air density)
- **Load/mission:** thrust demand from flight profile (hover, climb, cruise), mass as parameter
- **Control:** simple PI speed or thrust controller, extensible later
- Outputs: SoC, battery temperature, currents/voltages, speed, thrust, flight time until cut-off
- Parameters realistic, with source in a code comment (datasheets, literature).
  No invented values without marking them as **assumed**.

## Tech stack
- OpenModelica (omc, OMEdit), Modelica Standard Library 4.0.0
- Python ≥ 3.11: numpy, scipy, pandas, matplotlib, fmpy, torch, pytest, ruff
- Main development machine runs **Windows**: commands/scripts must work there
  (PowerShell or platform-independent Python).

## Repository layout
```
modelica/MulticopterPowertrain/   Modelica library (Components/, Examples/ with one test model per component)
python/src/multicopter_surrogates FMU execution, data generation, surrogates, evaluation
python/tests/                     pytest
scripts/                          entry points: build_fmu, generate_data, train, evaluate
results/figures/                  figures used in the README (keep small)
data/                             generated data – NOT committed (.gitignore)
docs/                             model description, equations, parameters, assumptions
```

## Conventions
- **Code, comments, README, commit messages in English.** Chat with the author in German.
- Small, traceable steps; something must run after every step. Minimal model first, then refine.
- Every physical component testable on its own (own test model in `Examples`).
- Plausibility checks as tests: energy balance, units (use Modelica `SI` types), edge cases.
- Python: type hints, docstrings, small functions; notebooks only for exploration, never the only source.
- GitHub Actions CI from Phase 2: pytest + ruff.
- Fixed seeds, configuration in files (YAML/TOML), results reproducible by script.
- When introducing a new tool (FMPy, PyTorch details, CI), explain it briefly to the author.
- No exaggeration in the README. State limits and assumptions openly.

## Roadmap
- [x] Phase 0: repository skeleton, .gitignore, LICENSE (MIT), README skeleton, Python environment
- [ ] Phase 1: Modelica components + system model, hover scenario, plausibility plots
- [ ] Phase 2: FMU export, Python wrapper, parameter study (mass, battery capacity, propeller), CI
- [ ] Phase 3: POD/DMD surrogate
- [ ] Phase 4: NN surrogate (PyTorch), optional PINN; accuracy/speed comparison table
- [ ] Phase 5: README with key result, plots, "How to reproduce", "Limitations"
