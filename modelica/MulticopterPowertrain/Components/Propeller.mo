within MulticopterPowertrain.Components;
model Propeller "Fixed-pitch propeller with static thrust and power coefficients"
  import Modelica.Units.SI;
  import Modelica.Constants.pi;

  // Default values: T-Motor 13x4.4CF on MN3508 KV580, derived from the manufacturer
  // test table with scripts/derive_propeller_coefficients.py (see docs/parameters.md).
  parameter SI.Diameter D = 13*0.0254 "Propeller diameter (13 in)";
  parameter Real C_T(unit="1") = 0.068
    "Static thrust coefficient, T = C_T*rho*n^2*D^4 (derived from manufacturer data)";
  parameter Real C_P(unit="1") = 0.024
    "Static power coefficient, P = C_P*rho*n^3*D^5 (upper estimate, ESC/iron losses neglected)";
  parameter SI.Density rho = 1.225 "Air density (ISA sea level)";

  Modelica.Mechanics.Rotational.Interfaces.Flange_a flange "Propeller shaft"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Blocks.Interfaces.RealOutput thrust(unit="N") "Thrust along rotor axis"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));

  SI.AngularVelocity w "Shaft angular velocity";
  Real n(unit="1/s") "Rotational speed in revolutions per second";
  SI.Torque tau "Aerodynamic drag torque";
  SI.Power P "Aerodynamic shaft power";

equation
  w = der(flange.phi);
  n = w/(2*pi);
  // n*abs(n) keeps the forces odd in n, so reverse rotation gives negative thrust/torque.
  thrust = C_T*rho*n*abs(n)*D^4;
  // P = tau*w = C_P*rho*n^3*D^5  =>  tau = C_P*rho*n^2*D^5/(2*pi)
  tau = C_P*rho*n*abs(n)*D^5/(2*pi);
  P = tau*w;
  // Positive flange.tau means torque into the component: the propeller absorbs power.
  flange.tau = tau;

  annotation (
    Icon(graphics={
      Rectangle(extent={{-90,6},{-10,-6}}, fillColor={160,160,164}, fillPattern=FillPattern.Solid),
      Ellipse(extent={{-14,90},{6,-90}}, fillColor={95,95,95}, fillPattern=FillPattern.Solid),
      Line(points={{20,0},{100,0}}, color={0,0,127}, arrow={Arrow.None,Arrow.Filled}),
      Text(extent={{-150,140},{150,100}}, textString="%name", textColor={0,0,255})}),
    Documentation(info="<html>
<p>Quasi-static propeller model for hover-dominated flight (advance ratio J &asymp; 0):</p>
<ul>
<li>Thrust: T = C<sub>T</sub> &rho; n<sup>2</sup> D<sup>4</sup></li>
<li>Torque: &tau; = C<sub>P</sub> &rho; n<sup>2</sup> D<sup>5</sup> / (2&pi;)</li>
</ul>
<p>n is the speed in rev/s. The coefficients are constant, so effects of axial inflow (climb, cruise)
and Reynolds number are not modelled. The propeller inertia is not included; add it to the rotor inertia.</p>
</html>"));
end Propeller;
