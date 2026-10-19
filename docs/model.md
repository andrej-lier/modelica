# Model description

Equations, parameters (with sources) and assumptions of the Modelica model.
Parameters without a datasheet or literature source are marked as **assumed**.

## Battery
_Equivalent circuit: OCV(SoC) + R0 + 1–2 RC elements; lumped thermal model (one heat capacity)._

## ESC
_Averaged model (no switching), constant efficiency or efficiency map._

## BLDC motor
_DC equivalent model: Kv, R, L, rotor inertia, friction._

## Propeller
`Components.Propeller`, test model `Examples.PropellerTest`.

- Thrust T = C_T ρ n|n| D⁴, shaft power P = C_P ρ n³ D⁵, torque τ = P/ω = C_P ρ n|n| D⁵ / (2π), with n in rev/s.
- Static coefficients (advance ratio J ≈ 0): valid for hover; climb and cruise inflow reduce thrust
  and are not yet modelled.
- No propeller inertia in the component; it belongs to the rotor inertia of the motor.
- Parameters: see [parameters.md](parameters.md).

## Mission / load
_Thrust demand from flight profile (hover, climb, cruise); vehicle mass as parameter._

## Control
_PI speed or thrust controller._

## Assumptions and limitations
_To be documented._
