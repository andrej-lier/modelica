"""Derive static C_T and C_P of the reference propeller from manufacturer test data.

Source: T-Motor MN3508 KV580 product page, test table at 14.8 V with T-Motor 13x4.4CF propeller
(https://store.tmotor.com/product/mn3508-motor-navigator-type.html, accessed 2026-10-19).

Assumptions (not stated by the manufacturer):
- Air density is ISA sea level (1.225 kg/m^3); test conditions are not given.
- Shaft power is estimated as electrical input power minus motor copper loss I^2 * R,
  with R = 0.110 Ohm (datasheet). ESC and iron losses are neglected, so C_P is an
  UPPER estimate.

Usage:  python scripts/derive_propeller_coefficients.py
"""

from __future__ import annotations

import numpy as np

from multicopter_surrogates.propeller import (
    G0,
    INCH,
    power_coefficient,
    thrust_coefficient,
)

DIAMETER_M = 13 * INCH
R_MOTOR_OHM = 0.110

# throttle [%], current [A], electrical power [W], thrust [g], speed [rpm]
TEST_DATA = np.array(
    [
        [50, 2.6, 38.48, 450, 4000],
        [85, 9.3, 137.64, 1120, 6300],
        [100, 11.3, 167.24, 1230, 6600],
    ]
)


def main() -> None:
    throttle, current, p_el, thrust_g, rpm = TEST_DATA.T
    thrust_n = thrust_g * 1e-3 * G0
    p_shaft = p_el - current**2 * R_MOTOR_OHM

    c_t = thrust_coefficient(thrust_n, rpm, DIAMETER_M)
    c_p = power_coefficient(p_shaft, rpm, DIAMETER_M)

    print(f"{'throttle %':>10} {'rpm':>6} {'thrust N':>9} {'P_shaft W':>10} {'C_T':>7} {'C_P':>7}")
    for row in zip(throttle, rpm, thrust_n, p_shaft, c_t, c_p, strict=True):
        print("{:10.0f} {:6.0f} {:9.2f} {:10.1f} {:7.4f} {:7.4f}".format(*row))
    print(f"\nmean C_T = {c_t.mean():.4f}   mean C_P = {c_p.mean():.4f}")


if __name__ == "__main__":
    main()
