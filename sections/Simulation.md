---
title: Simulation
layout: default
nav_order: 4
---

# Simulation Documentation

Simulation is crucial for safe development and testing of drone systems before real-world deployment.

## Matlab / Simulink Simulations

Majority of testing has been done in Matlab/Simulink. The main simulation environments are the two below:

- **Multirotor Simulation**: A flexible Simulink model that allows for testing various multirotor configurations and control algorithms. This model origionally developed by Jeremie Bunworth and has been extended by DTRG members over time. It includes realistic physics, sensor models, and environmental effects including wind and turbulence models.This simulation also implements a slightly older version of the PX4 flight stack for control, allowing for testing of PX4 based flight algorithms in a safe environment.

- **Simscape Multibody Models**: Detailed 3D models of the Flamingo/Stacked Octocopter built in Simscape Multibody. This model build by Pedro Mendez utilizes CAD imports and simscape physics to provide high fidelity simulations of the vehicle dynamics and control.

For more information a getting started guide and documentation for these simulations is being developed.

## Resources

- [Gazebo Official Documentation](http://gazebosim.org/)
- [PX4 SITL Documentation](https://dev.px4.io/master/en/simulation/)
- [jMAVSim Documentation](https://dev.px4.io/master/en/simulation/jmavsim.html)
- [QGroundControl](http://qgroundcontrol.com/)
