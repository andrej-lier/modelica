"""Smoke test: the package is importable and versioned."""

import multicopter_surrogates


def test_version() -> None:
    assert multicopter_surrogates.__version__ == "0.1.0"
