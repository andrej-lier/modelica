# Scripts

Entry points for the reproducible pipeline (added per phase):

| Script | Purpose | Phase |
|---|---|---|
| `build_fmu.py` | Export the Modelica system model as an FMU via OpenModelica | 2 |
| `generate_data.py` | Run parameter studies with FMPy, write training data to `data/` | 2 |
| `train.py` | Train surrogate models (POD/DMD, neural network) | 3–4 |
| `evaluate.py` | Compare accuracy / runtime / extrapolation, write `results/figures/` | 4–5 |
