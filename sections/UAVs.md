---
title: UAVs
layout: default
nav_order: 5
has_children: true
---

# UAV Hardware Documentation

This section covers the various unmanned aerial vehicle platforms used in DTRG research and development.


## Platform Overviews

DTRG utilizes diverse UAV platforms to support various research objectives and applications. Below is a list of UAV aircraft that are used within the group.

### Underactuated Multirotor
- **Quadcopter**: A quadcopter with fewer control inputs than degrees of freedom, often used for research in control strategies and system identification. These include the F450, crazyflies, and the training drones.
- **Modified Quadcopters**: Custom quadcopter designs with unique frame geometries or motor configurations to explore advanced control techniques. These include the Faintail with its additional tail fan.
- **Stacked Octocopter**: A stacked octocopter with two layers of four rotors each. These coaxial rotor designs provide increased thrust and redundancy while maintaining a compact vertical profile.

### Fully/Over Actuated Fixed-Tilt Multirotor

- **Planar Octocopter**: A planar octocopter with eight rotors arranged in a single plane, providing enhanced stability and payload capacity. Each rotor is tilted to provide both vertical and horizontal thrust components.
- **Stacked Octocopter**: A stacked octocopter with two layers of four rotors each. This design is similar to the planar octocopter but with a more compact vertical profile, allowing for a smaller footprint. These craft include the Flamingo, Bluebird, and Tōrea, along with the larger Shoebill.
- **Planetary Hexacopter**: A hexacopter with six rotors arranged in a single plane (planets) around two center (sun) rotors. Planets are rotated to provide both vertical and horizontal thrust components. Sun rotors are vertical only and significantly larger than the planets providing the majority of lift. These include the Ladybird and P#1.

### Variable Tilt Multirotor

- **Tiltrotor**: Quadcopter with four rotors that can be tilted in unison to allow for vectored thrust. This allows for vertical takeoff and landing as well as horizontal flight.

### Fixed-Wing

Fixed lifting surfaces provide the lift for flight. All current aircraft in the group are conventional, requiring hand-launch and positive forward airspeed.


## Craft List

This is the list of all aircraft currently used within DTRG. More detailed information on each platform can be found in their respective documentation pages.

| Name         | Type                |Description                                      |
|--------------|---------------------|--------------------------------------------------|
| [F450](uavs/F450)         | Underactuated Quadcopter | Standard quadcopter platform for basic research and training. |
| [Crown Cinewhoop](uavs/CrownCinewhoop)         | Underactuated Quadcopter | Standard quadcopter platform for basic research and training. |
| [Mobula8](uavs/Mobula8)         | Underactuated Quadcopter | Standard quadcopter platform for basic research and training. |
| [Crazyflie](uavs/Crazyflie)    | Underactuated Quadcopter | Small indoor quadcopter for swarm and formation flight experiments. |
| [Faintail](uavs/Faintail)     | Underactuated Quadcopter | Custom quadcopter with an additional tail fan for forward and backward thrust. |
| [Flamingo](uavs/Flamingo) | Fully Actuated Stacked Octocopter | - |
| [Bluebird](uavs/Bluebird) | Fully Actuated Stacked Octocopter | - |
| [Tōrea](uavs/Torea) | Fully Actuated Stacked Octocopter | - |
| [Kuaka](uavs/Kuaka) | Fully Actuated Stacked Octocopter | - |
| [Shoebill](uavs/Shoebill) | Fully Actuated Stacked Octocopter | Larger fixed tilt stacked octocopter for heavy payloads. |
| [Ladybird](uavs/Ladybird) | Smaller Fully Actuated Planetary Hexacopter | - |
| [P#1](uavs/P-1) | Larger Fully Actuated Planetary Hexacopter | - |
| [Tiltrotor](uavs/Tiltrotor) | Fixed-Wing | Large fixed-wing for outdoors flight. |
