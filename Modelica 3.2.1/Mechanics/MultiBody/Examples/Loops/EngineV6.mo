within Modelica.Mechanics.MultiBody.Examples.Loops;
model EngineV6
  "V6 engine with 6 cylinders, 6 planar loops and 1 degree-of-freedom"

  extends Modelica.Icons.Example;
  parameter Boolean animation=true "= true, if animation shall be enabled";
  output Modelica.SIunits.Conversions.NonSIunits.AngularVelocity_rpm
    engineSpeed_rpm=
         Modelica.SIunits.Conversions.to_rpm(load.w) "Engine speed";
  output Modelica.SIunits.Torque engineTorque = filter.u
    "Torque generated by engine";
  output Modelica.SIunits.Torque filteredEngineTorque = filter.y
    "Filtered torque generated by engine";

  Modelica.Mechanics.MultiBody.Joints.Revolute bearing(useAxisFlange=true,
    n={1,0,0},
    cylinderLength=0.02,
    cylinderDiameter=0.06,
    animation=animation) annotation (Placement(transformation(extent={{-90,20},
            {-70,0}}, rotation=0)));
  inner Modelica.Mechanics.MultiBody.World world(animateWorld=false,
      animateGravity =                                                              false)
    annotation (Placement(transformation(extent={{-120,20},{-100,40}}, rotation=
           0)));
  Utilities.Cylinder cylinder1(
    crankAngleOffset=Cv.from_deg(-30),
    cylinderInclination=Cv.from_deg(-30),
    animation=animation) annotation (Placement(transformation(extent={{-50,4},{
            -30,34}}, rotation=0)));
  Utilities.Cylinder cylinder2(
    crankAngleOffset=Cv.from_deg(90),
    cylinderInclination=Cv.from_deg(30),
    animation=animation) annotation (Placement(transformation(extent={{-20,4},{
            0,34}}, rotation=0)));
  Utilities.Cylinder cylinder3(
    cylinderInclination=Cv.from_deg(-30),
    animation=animation,
    crankAngleOffset=Cv.from_deg(210))
                         annotation (Placement(transformation(extent={{10,4},{
            30,34}}, rotation=0)));
  Utilities.Cylinder cylinder4(
    cylinderInclination=Cv.from_deg(30),
    animation=animation,
    crankAngleOffset=Cv.from_deg(210))
                         annotation (Placement(transformation(extent={{39,4},{
            59,34}}, rotation=0)));
  Utilities.Cylinder cylinder5(
    cylinderInclination=Cv.from_deg(-30),
    animation=animation,
    crankAngleOffset=Cv.from_deg(90))
                         annotation (Placement(transformation(extent={{70,4},{
            90,34}}, rotation=0)));
  Utilities.Cylinder cylinder6(
    cylinderInclination=Cv.from_deg(30),
    animation=animation,
    crankAngleOffset=Cv.from_deg(-30))
                         annotation (Placement(transformation(extent={{100,4},{
            120,34}}, rotation=0)));
  Modelica.Mechanics.Rotational.Components.Inertia load(
                          phi(
      start=0,
      fixed=true), w(
      start=10,
      fixed=true),
    stateSelect=StateSelect.always,
    J=1)                               annotation (Placement(transformation(
          extent={{-44,-30},{-24,-10}}, rotation=0)));
  Modelica.Mechanics.Rotational.Sources.QuadraticSpeedDependentTorque load2(
                                                 tau_nominal=-100, w_nominal=
        200,
    useSupport=false)
             annotation (Placement(transformation(extent={{6,-30},{-14,-10}},
          rotation=0)));
  Rotational.Sensors.TorqueSensor torqueSensor
    annotation (Placement(transformation(extent={{-72,-30},{-52,-10}}, rotation=
           0)));
  Blocks.Continuous.CriticalDamping filter(
    n=2,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    f=5) annotation (Placement(transformation(extent={{-54,-60},{-34,-40}},
          rotation=0)));
equation

  connect(bearing.frame_b, cylinder1.crank_a)
    annotation (Line(
      points={{-70,10},{-50,10}},
      color={95,95,95},
      thickness=0.5));
  connect(cylinder1.crank_b, cylinder2.crank_a)
    annotation (Line(
      points={{-30,10},{-20,10}},
      color={95,95,95},
      thickness=0.5));
  connect(cylinder2.crank_b, cylinder3.crank_a)
    annotation (Line(
      points={{0,10},{10,10}},
      color={95,95,95},
      thickness=0.5));
  connect(cylinder3.crank_b, cylinder4.crank_a)
    annotation (Line(
      points={{30,10},{39,10}},
      color={95,95,95},
      thickness=0.5));
  connect(cylinder4.crank_b, cylinder5.crank_a)
    annotation (Line(
      points={{59,10},{70,10}},
      color={95,95,95},
      thickness=0.5));
  connect(cylinder5.crank_b, cylinder6.crank_a)
    annotation (Line(
      points={{90,10},{100,10}},
      color={95,95,95},
      thickness=0.5));
  connect(cylinder5.cylinder_b, cylinder6.cylinder_a)
    annotation (Line(
      points={{90,32},{100,32}},
      color={95,95,95},
      thickness=0.5));
  connect(cylinder4.cylinder_b, cylinder5.cylinder_a)
    annotation (Line(
      points={{59,32},{70,32}},
      color={95,95,95},
      thickness=0.5));
  connect(cylinder4.cylinder_a, cylinder3.cylinder_b)
    annotation (Line(
      points={{39,32},{30,32}},
      color={95,95,95},
      thickness=0.5));
  connect(cylinder3.cylinder_a, cylinder2.cylinder_b)
    annotation (Line(
      points={{10,32},{0,32}},
      color={95,95,95},
      thickness=0.5));
  connect(cylinder2.cylinder_a, cylinder1.cylinder_b)
    annotation (Line(
      points={{-20,32},{-30,32}},
      color={95,95,95},
      thickness=0.5));
  connect(world.frame_b, cylinder1.cylinder_a) annotation (Line(
      points={{-100,30},{-59,30},{-59,32},{-50,32}},
      color={95,95,95},
      thickness=0.5));
  connect(world.frame_b, bearing.frame_a) annotation (Line(
      points={{-100,30},{-96,30},{-96,10},{-90,10}},
      color={95,95,95},
      thickness=0.5));
  connect(load2.flange, load.flange_b)
    annotation (Line(points={{-14,-20},{-24,-20}}, color={0,0,0}));
  connect(torqueSensor.flange_b, load.flange_a)
    annotation (Line(points={{-52,-20},{-44,-20}}, color={0,0,0}));
  connect(torqueSensor.tau,filter. u) annotation (Line(points={{-70,-31},{-70,
          -50},{-56,-50}}, color={0,0,127}));
  connect(torqueSensor.flange_a, bearing.axis) annotation (Line(points={{-72,
          -20},{-80,-20},{-80,0}}, color={0,0,0}));
  annotation (
    Documentation(info="<HTML>
<p>
This is a V6 engine with 6 cylinders. It is hierarchically built
up by using instances of one cylinder. For more details on the
modeling of one cylinder, see example
<a href=\"modelica://Modelica.Mechanics.MultiBody.Examples.Loops.Engine1b\">Engine1b</a>.
An animation of the engine is shown in the figure below.
</p>

<p>
<IMG src=\"modelica://Modelica/Resources/Images/Mechanics/MultiBody/Examples/Loops/EngineV6.png\" ALT=\"model Examples.Loops.EngineV6\">
</p>

<p>
Simulate for 3 s with about 50000 output intervals, and plot the variables <b>engineSpeed_rpm</b>,
<b>engineTorque</b>, and <b>filteredEngineTorque</b>. Note, the result file has
a size of about 300 Mbyte in this case. The default setting of StopTime = 1.01 s (with the default setting of the tool for the number of output points), in order that (automatic) regression testing does not have to cope with a large result file.
</p>
</html>"), experiment(StopTime=1.01),Icon(coordinateSystem(extent={{-100,-100},{100, 100}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-140,-100},{140,
            100}})));
end EngineV6;
