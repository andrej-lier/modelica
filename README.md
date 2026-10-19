# Multicopter Powertrain: Physical Model vs. Surrogate Models

> **Status:** work in progress (Phase 0 – repository skeleton). Results below are placeholders.

A parametrised physical system model of an electric multicopter powertrain
(battery → ESC → BLDC motor → propeller) in **Modelica**, executed from **Python** as an FMU,
and used as ground truth to compare **surrogate models**:

| Approach | Method | Status |
|---|---|---|
| Full model | Modelica (OpenModelica), FMU via FMPy | planned |
| Model order reduction | POD, DMD | planned |
| Data-driven | Neural network (PyTorch), optionally physics-informed | planned |

Comparison criteria: **accuracy vs. runtime vs. extrapolation** beyond the training data.

## Key result

_To be filled in: "Full model X s, surrogate Y ms, error Z % – and here are the limits."_

## Repository layout

```
modelica/MulticopterPowertrain/   Modelica library (components, examples / test models)
python/src/multicopter_surrogates FMU execution, data generation, surrogates, evaluation
python/tests/                     pytest
scripts/                          entry points: build_fmu, generate_data, train, evaluate
results/figures/                  figures used in this README
docs/                             model description, equations, assumptions
data/                             generated data (not committed)
```

## How to reproduce

Requirements: [OpenModelica](https://openmodelica.org) ≥ 1.22 (Modelica Standard Library 4.0.0), Python ≥ 3.11.

```bash
python -m venv .venv
# Windows (PowerShell): .venv\Scripts\Activate.ps1   |   Linux/macOS: source .venv/bin/activate
pip install -e ".[dev]"
pytest
```

Further steps (FMU build, data generation, training, evaluation) will be added per phase.

## Roadmap

- [x] Phase 0: repository skeleton, Python environment
- [ ] Phase 1: Modelica components + system model, hover scenario, plausibility plots
- [ ] Phase 2: FMU export, Python wrapper, parameter study, CI (pytest + ruff)
- [ ] Phase 3: POD/DMD reduced-order model
- [ ] Phase 4: neural-network surrogate (PyTorch), optional PINN; comparison table
- [ ] Phase 5: final results, reproduction guide, limitations

## Limitations

_To be documented as the model evolves. Assumptions are listed in [docs/model.md](docs/model.md)._

## License

[MIT](LICENSE)
