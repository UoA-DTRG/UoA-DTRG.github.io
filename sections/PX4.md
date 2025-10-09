# PX4 Documentation

PX4 is an open-source autopilot system used extensively in DTRG projects for autonomous drone control. The DTRG maintains a custom fork of PX4 to support specific research needs and vehicle configurations. This fork includes additional features, bug fixes, and optimizations tailored to our experimental platforms.

## Sections

Documentation for DTRG | PX4 is organized into the following sections:

- [Getting Started with PX4](PX4/PX4-GettingStarted.md)
- [Installation and Setup](PX4/PX4-Installation.md)
- [Configuration](PX4/PX4-Configuration.md)
- [Custom Features](#custom-features)
- [Troubleshooting](PX4/PX4-Troubleshooting.md)
- [Resources](#resources)

## Custom Features

DTRG has developed several custom modules and features for PX4 to enhance its capabilities for research applications. These include:

### [Custom Mixer Injection](#custom-mixer-injection)
DTRG has implemented a custom mixer injection system to allow for testing of specific control allocation mixers skipping the geometry setup and internal PX4 mixer generation system.

### [Horizontal Thrust](#horizontal-thrust)
Support for vehicles with horizontal thrust components, such as the stacked-octo UAVs, allowing the use of horizontal thrust in manual and position based flight modes including offboard.

*upcoming features:*

#### *[Status Monitor](#status-monitor)*
Real-time system monitoring and status reporting for enhanced flight safety and diagnostics.

#### *[Dynamixel Servo Control](#dynamixel-servo-control)*
Easy configuration and control of Dynamixel servos with simplified parameter setup for research applications.

#### *[Wrench Estimator](#wrench-estimator)*
Advanced force and torque estimation capabilities for improved control system performance.

#### *[Admittance Controller](#admittance-controller)*
Adaptive control system that adjusts vehicle response based on external forces and environmental conditions.

## Resources

- [Official PX4 Documentation](https://px4.io/)
- [PX4 GitHub Repository](https://github.com/PX4/PX4-Autopilot)
- [QGroundControl](http://qgroundcontrol.com/)

---
[Back to Home](../Home)
