within;
package MulticopterPowertrain "Electric multicopter powertrain: battery, ESC, BLDC motor, propeller"
  extends Modelica.Icons.Package;

  annotation (
    version="0.1.0",
    uses(Modelica(version="4.0.0")),
    Documentation(info="<html>
<p>Physical system model of an electric multicopter powertrain
(battery &rarr; ESC &rarr; BLDC motor &rarr; propeller), driven by a flight mission profile.
Serves as ground truth for comparing surrogate models (POD/DMD, neural networks).</p>
<p>License: MIT. Source: <a href=\"https://github.com/andrej-lier/modelica\">github.com/andrej-lier/modelica</a></p>
</html>"));
end MulticopterPowertrain;
