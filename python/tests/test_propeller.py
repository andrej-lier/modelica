"""Tests for the static propeller coefficient helpers."""

import numpy as np
import pytest

from multicopter_surrogates.propeller import (
    ISA_SEA_LEVEL_DENSITY,
    power_coefficient,
    thrust_coefficient,
)


def test_thrust_coefficient_roundtrip() -> None:
    c_t, d, rpm = 0.07, 0.33, 6000.0
    n = rpm / 60.0
    thrust = c_t * ISA_SEA_LEVEL_DENSITY * n**2 * d**4
    assert thrust_coefficient(thrust, rpm, d) == pytest.approx(c_t)


def test_power_coefficient_roundtrip() -> None:
    c_p, d, rpm = 0.03, 0.33, 6000.0
    n = rpm / 60.0
    power = c_p * ISA_SEA_LEVEL_DENSITY * n**3 * d**5
    assert power_coefficient(power, rpm, d) == pytest.approx(c_p)


def test_vectorised() -> None:
    c_t = thrust_coefficient([1.0, 4.0], [1000.0, 2000.0], 0.3)
    # Thrust x4 at speed x2 -> same coefficient
    assert np.allclose(c_t[0], c_t[1])
