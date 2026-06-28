# Mass-Spring-Damper System Simulation in Simulink

## Project Overview

This project demonstrates the simulation of a basic second-order dynamic system using Simulink.

The modeled system is a mass-spring-damper system, which is commonly used to understand vibration, damping, transient response, and system stability in engineering applications.

## System Equation

The system is described by the following differential equation:

```text
m*x'' + c*x' + k*x = F
```

Where:

* `m` = mass
* `c` = damping coefficient
* `k` = spring stiffness
* `F` = external force
* `x` = displacement / position
* `x'` = velocity
* `x''` = acceleration

The equation was rearranged for simulation as:

```text
x'' = (F - c*x' - k*x) / m
```

## Simulink Model Logic

The system was modeled using the following logic:

```text
Force input → Sum block → 1/m Gain → Integrator → Integrator → Scope
```

The first integrator gives velocity and the second integrator gives position.

Negative feedback was used for the damping and spring terms:

```text
velocity → c Gain → negative feedback
position → k Gain → negative feedback
```

## Tools Used

* MATLAB
* Simulink
* GitHub

## Model Parameters

| Parameter              | Value          |
| ---------------------- | -------------- |
| Mass, m                | 1 kg           |
| Damping coefficient, c | 0.5, 2, 8 Ns/m |
| Spring stiffness, k    | 20 N/m         |
| Input force, F         | Step input     |
| Simulation time        | 10 seconds     |

## Simulink Model

![Simulink Model](screenshots/01_simulink_model.png)

## Results

The model was simulated using different damping coefficient values to observe how damping affects the system response.

### Response for c = 0.5

![Position Response c05](screenshots/02_position_response_c05.png)

With a low damping coefficient, the system shows more oscillation and takes longer to settle.

### Response for c = 2

![Position Response c2](screenshots/03_position_response_c2.png)

With a moderate damping coefficient, the oscillations decrease and the system settles more smoothly.

### Response for c = 8

![Position Response c8](screenshots/04_position_response_c8.png)

With a higher damping coefficient, oscillations are reduced significantly. The response becomes smoother, but the system may react more slowly.

## Engineering Observation

The simulation results show that increasing the damping coefficient reduces oscillations in the system response.

For this system:

```text
F = 1
k = 20
```

The expected steady-state displacement is:

```text
x = F / k = 1 / 20 = 0.05 m
```

The simulation result approaches approximately `0.05 m`, which confirms that the model behaves consistently with the physical system.

## Aerospace Engineering Relevance

Mass-spring-damper systems are useful for understanding vibration and damping behavior in aerospace engineering.

This type of model can be related to:

* Aircraft landing gear damping
* Wing and fuselage vibration
* Control surface dynamics
* Mechanical subsystem response
* Basic flight dynamics and control system modeling

## What I Learned

* How to model a second-order dynamic system in Simulink
* How to use integrator blocks for acceleration, velocity, and position
* How to create negative feedback loops
* How damping affects transient response
* How to document a simulation project for an engineering portfolio

## Next Step

The next step is to build a simplified aircraft pitch control model using Simulink.
## Projects

- [Mass-Spring-Damper System Simulation](02-dynamic-system-simulation)