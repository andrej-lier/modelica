# Reference vehicle and parameters

**2 kg inspection quadcopter**: 4 × T-Motor MN3508 KV580, T-Motor 13×4.4CF propellers, 4S LiPo.

Hover thrust per rotor: 2 kg · 9.81 m/s² / 4 = 4.9 N (≈ 500 g), which is about 50–55 % throttle
in the manufacturer table. Maximum thrust per rotor is 1230 g, so thrust-to-weight ≈ 2.5.

Legend: **DS** = datasheet / manufacturer value, **derived** = computed from DS values (script given),
**assumed** = engineering assumption without a specific source.

## Motor – T-Motor MN3508 KV580

| Parameter | Value | Status | Source |
|---|---|---|---|
| Kv | 580 rpm/V | DS | [T-Motor MN3508][tm] |
| Winding resistance R | 110 mΩ | DS | [T-Motor MN3508][tm] |
| Weight (with cables) | 103 g | DS | [T-Motor MN3508][tm] |
| Rated battery | 3–4S LiPo | DS | [T-Motor MN3508][tm] |
| Max. continuous current | 18 A | DS | [T-Motor MN3508][tm] |

## Propeller – T-Motor 13×4.4CF

| Parameter | Value | Status | Source |
|---|---|---|---|
| Diameter D | 13 in = 0.3302 m | DS | nominal size |
| Static thrust coefficient C_T | 0.068 | derived | `scripts/derive_propeller_coefficients.py` |
| Static power coefficient C_P | 0.024 | derived, upper estimate | `scripts/derive_propeller_coefficients.py` |
| Air density ρ | 1.225 kg/m³ | assumed | ISA sea level; test conditions not published |

Manufacturer test data used (14.8 V, 13×4.4CF, [T-Motor MN3508][tm]):

| Throttle | Current | Power | Thrust | Speed |
|---|---|---|---|---|
| 50 % | 2.6 A | 38.48 W | 450 g | 4000 rpm |
| 85 % | 9.3 A | 137.64 W | 1120 g | 6300 rpm |
| 100 % | 11.3 A | 167.24 W | 1230 g | 6600 rpm |

Derived coefficients (`python scripts/derive_propeller_coefficients.py`):

| Throttle | C_T | C_P |
|---|---|---|
| 50 % | 0.0682 | 0.0265 |
| 85 % | 0.0684 | 0.0230 |
| 100 % | 0.0685 | 0.0239 |

**Notes and limitations**
- C_T is nearly constant across the three operating points, which supports the
  quadratic thrust law in this range.
- The table gives *electrical* power. Shaft power is estimated as P_el − I²R. ESC losses and motor
  iron/friction losses are not subtracted, so C_P is an upper bound. The spread (0.023–0.027) reflects this:
  fixed losses weigh more at low load. The value 0.024 is the rounded mean of the two high-load points
  and the mean of all three.
- The data are vendor figures without independent verification or stated measurement uncertainty.

[tm]: https://store.tmotor.com/product/mn3508-motor-navigator-type.html
