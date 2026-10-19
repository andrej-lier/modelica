"""Static propeller coefficients from thrust-stand data.

Convention (n in rev/s, D in m):
    T = C_T * rho * n**2 * D**4
    P = C_P * rho * n**3 * D**5
"""

from __future__ import annotations

import numpy as np
from numpy.typing import ArrayLike, NDArray

ISA_SEA_LEVEL_DENSITY = 1.225  # kg/m^3, ISA standard atmosphere at sea level
G0 = 9.80665  # m/s^2, standard gravity
INCH = 0.0254  # m


def thrust_coefficient(
    thrust_N: ArrayLike, rpm: ArrayLike, diameter_m: float, rho: float = ISA_SEA_LEVEL_DENSITY
) -> NDArray[np.float64]:
    """Return C_T for measured thrust [N] at the given speed [rpm]."""
    n = np.asarray(rpm, dtype=float) / 60.0
    return np.asarray(thrust_N, dtype=float) / (rho * n**2 * diameter_m**4)


def power_coefficient(
    shaft_power_W: ArrayLike, rpm: ArrayLike, diameter_m: float, rho: float = ISA_SEA_LEVEL_DENSITY
) -> NDArray[np.float64]:
    """Return C_P for shaft power [W] at the given speed [rpm]."""
    n = np.asarray(rpm, dtype=float) / 60.0
    return np.asarray(shaft_power_W, dtype=float) / (rho * n**3 * diameter_m**5)
