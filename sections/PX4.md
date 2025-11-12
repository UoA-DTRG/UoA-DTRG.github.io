---
title: PX4
layout: default
nav_order: 3
has_children: true
---

# PX4 Documentation

PX4 is an open-source autopilot system used extensively in DTRG projects for autonomous drone control. The DTRG maintains a custom fork of PX4 to support specific research needs and vehicle configurations. This fork includes additional features, bug fixes, and optimizations tailored to our experimental platforms.

## Sections

PX4 is organized into the following sections:

- [Getting Started with PX4](PX4/PX4-GettingStarted)
- [Installation and Setup](PX4/PX4-Installation)
- [Configuration](PX4/PX4-Configuration)
- [Custom Features](PX4/custom-features/Custom-Features)
- [Troubleshooting](PX4/PX4-Troubleshooting)
- [Resources](#resources)

## Custom Features

DTRG has developed several custom modules and features for PX4 to enhance its capabilities for research applications. See the [Custom Features](PX4/custom-features/Custom-Features) section for details:

- [Custom Mixer Injection](PX4/custom-features/Custom-Mixer-Injection) - Custom mixer injection system
- [Horizontal Thrust](PX4/custom-features/Horizontal-Thrust) - Support for vehicles with horizontal thrust components

### Upcoming Features

- **Status Monitor** - Real-time system monitoring and status reporting for enhanced flight safety
- **Dynamixel Servo Control** - Easy configuration and control of Dynamixel servos
- **Wrench Estimator** - Advanced force and torque estimation capabilities
- **Admittance Controller** - Adaptive control system that adjusts vehicle response

## Resources

- [Official PX4 Documentation](https://px4.io/)
- [PX4 GitHub Repository](https://github.com/PX4/PX4-Autopilot)
- [QGroundControl](http://qgroundcontrol.com/)
