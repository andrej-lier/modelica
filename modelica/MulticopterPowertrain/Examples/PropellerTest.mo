within MulticopterPowertrain.Examples;
model PropellerTest "Propeller driven by a speed ramp from 0 to 6600 rpm"
  extends Modelica.Icons.Example;

  Components.Propeller propeller
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Mechanics.Rotational.Sources.Speed speed(exact=true)
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Modelica.Blocks.Sources.Ramp speedRef(
    height=6600*2*Modelica.Constants.pi/60, duration=10) "Speed reference in rad/s"
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));

equation
  connect(speedRef.y, speed.w_ref)
    annotation (Line(points={{-39,0},{-22,0}}, color={0,0,127}));
  connect(speed.flange, propeller.flange)
    annotation (Line(points={{0,0},{20,0}}, color={0,0,0}));

  annotation (
    experiment(StopTime=10, Interval=0.01),
    Documentation(info="<html>
<p>Plausibility check against the manufacturer test data (T-Motor MN3508 KV580, 13x4.4CF, 14.8 V):</p>
<table border=\"1\" cellpadding=\"3\">
<tr><th>time</th><th>speed</th><th>expected thrust</th><th>measured thrust</th></tr>
<tr><td>6.06 s</td><td>4000 rpm</td><td>4.40 N</td><td>450 g = 4.41 N</td></tr>
<tr><td>10 s</td><td>6600 rpm</td><td>11.98 N</td><td>1230 g = 12.06 N</td></tr>
</table>
<p>Expected shaft power at 6600 rpm: about 154 W.</p>
</html>"));
end PropellerTest;
