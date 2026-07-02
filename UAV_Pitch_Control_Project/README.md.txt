# UAV Longitudinal Pitch Control Using MATLAB & Simulink

## Overview

This project presents a simplified **UAV longitudinal pitch control system** developed using **MATLAB** and **Simulink**. The main objective is to design, tune and validate a **PID controller** that enables a UAV to track a desired pitch angle command. The project includes mathematical modeling, open-loop analysis, PID controller design, gain tuning, command tracking, actuator saturation analysis and Simulink-based closed-loop verification.

---

## Project Objectives

- Model simplified UAV longitudinal pitch dynamics
- Analyze open-loop pitch response
- Design a PID controller for pitch angle tracking
- Tune PID gains and compare controller performance
- Evaluate command tracking for different pitch references
- Analyze actuator saturation effects
- Implement the final controller in Simulink
- Compare MATLAB and Simulink-based results
- Document the project in a professional engineering format

---

## System Model

The UAV pitch dynamics are represented using a simplified second-order longitudinal motion model.

```text
theta_ddot + 2*zeta*omega_n*theta_dot + omega_n^2*theta = K_theta*delta_e
```

Where:

| Symbol | Description |
|---|---|
| `theta` | Pitch angle |
| `theta_dot` | Pitch rate |
| `delta_e` | Elevator deflection |
| `omega_n` | Natural frequency |
| `zeta` | Damping ratio |
| `K_theta` | Elevator-to-pitch gain |

The corresponding transfer function is:

```text
G(s) = K_theta / (s^2 + 2*zeta*omega_n*s + omega_n^2)
```

For this project, the numerical plant model is:

```text
G(s) = 3 / (s^2 + 1.62s + 3.24)
```

This simplified plant model represents the relationship between the elevator deflection input and the UAV pitch angle output.

---

## Control Architecture

The closed-loop pitch control system follows the structure below:

```text
Pitch Command → Tracking Error → PID Controller → Elevator Saturation → UAV Pitch Dynamics → Pitch Response
```

The feedback loop compares the desired pitch angle with the actual pitch response. The PID controller generates the required elevator command based on the tracking error. The elevator command is then limited using a saturation block to represent the physical actuator limit of the elevator surface.

---

## Final PID Controller

After the PID tuning study, the final PID gains were selected as:

| Gain | Value |
|---|---:|
| `Kp` | 4.0 |
| `Ki` | 1.2 |
| `Kd` | 1.8 |

These gains were selected because they provided a stable closed-loop response with zero overshoot, zero steady-state error and improved settling time.

---

## MATLAB Analysis

The MATLAB part of the project includes open-loop pitch response analysis, PID controller implementation, PID gain tuning, final controller performance evaluation, command tracking analysis and actuator saturation study.

| Analysis | Description |
|---|---|
| Open-loop response | Response of the UAV pitch dynamics without controller |
| PID control | Closed-loop pitch tracking using a PID controller |
| PID tuning | Comparison of different PID gain sets |
| Final controller | Detailed performance analysis of selected PID gains |
| Command tracking | Testing 5°, 10° and 15° pitch commands |
| Actuator limit study | Analysis of elevator saturation and control authority |

---

## Simulink Implementation

The final PID controller was implemented in Simulink using a block diagram model. The Simulink model verifies the MATLAB-based controller design in a visual closed-loop simulation environment.

The Simulink model includes:

- Step Input
- Sum Block
- PID Controller
- Saturation Block
- Transfer Function Block
- Scope
- To Workspace Blocks

The Simulink closed-loop structure is:

```text
theta_ref → error → PID Controller → Elevator Saturation → UAV Pitch Dynamics → theta
     ↑                                                                  |
     |__________________________________________________________________|
```

---

## Final Simulink Results
![UAV Pitch Simulink Results](03_Results/uav_pitch_simulink_full_analysis.png)

For a **10-degree pitch command**, the final Simulink model achieved the following performance results:

| Metric | Result |
|---|---:|
| Target pitch angle | 10.00 deg |
| Final pitch angle | 10.00 deg |
| Maximum pitch angle | 10.00 deg |
| Maximum elevator input | 15.00 deg |
| Steady-state error | 0.00 deg |
| Overshoot | 0.00 % |
| Settling time | 5.61 s |

---

## Simulink Response Plot

![UAV Pitch Simulink Results](03_Results/uav_pitch_simulink_full_analysis.png)

---

## Key Findings

The final PID controller successfully tracks the 10-degree pitch reference command with zero overshoot, zero steady-state error and a stable closed-loop response. The final Simulink model reached the desired pitch angle with a settling time of approximately **5.61 seconds**.

The command tracking analysis showed that the controller can successfully track 5-degree and 10-degree pitch commands with a 15-degree elevator limit. However, for a 15-degree pitch command, the system could not fully settle within the required tolerance band due to actuator saturation.

The actuator limit study showed that approximately **20 degrees of elevator authority** is required to successfully track a 15-degree pitch command. This result demonstrates the importance of actuator limits and control authority in UAV flight control system design.

---

## Engineering Interpretation

The results show that the selected PID controller provides stable and accurate pitch tracking performance for moderate pitch commands. The system is able to reach the desired pitch angle without overshoot and without steady-state error.

The actuator saturation analysis highlights an important engineering limitation. Even if a controller is properly tuned, the physical limits of the control surface can restrict the achievable pitch response. This makes the project more realistic because real UAV flight control systems must always consider actuator limits, control authority and closed-loop stability.

---

## Repository Structure

```text
02_UAV_Pitch_Control
│
├── 01_MATLAB
│   ├── uav_pitch_open_loop.m
│   ├── uav_pitch_pid_control.m
│   ├── uav_pitch_pid_tuning.m
│   ├── uav_pitch_final_controller.m
│   ├── uav_pitch_command_tracking.m
│   ├── uav_pitch_actuator_limit_study.m
│   ├── uav_pitch_simulink_params.m
│   └── run_uav_pitch_simulink_analysis.m
│
├── 02_Simulink
│   └── uav_pitch_pid_control.slx
│
├── 03_Results
│   ├── uav_pitch_simulink_full_analysis.png
│   └── uav_pitch_simulink_full_analysis_results.csv
│
├── 04_Report
│
└── README.md
```

---

## Tools and Technologies

- MATLAB
- Simulink
- PID Control
- Transfer Function Modeling
- Numerical Simulation
- Closed-loop Control Analysis
- Aerospace Flight Dynamics

---

## Skills Demonstrated

- UAV longitudinal dynamics modeling
- PID controller design and tuning
- MATLAB simulation workflow
- Simulink block diagram implementation
- Performance analysis using overshoot, settling time and steady-state error
- Actuator saturation and control authority evaluation
- Engineering result interpretation
- Technical documentation

---

## Project Category

**Aerospace Engineering**  
**UAV Flight Dynamics**  
**Longitudinal Control**  
**MATLAB / Simulink Simulation**  
**PID Controller Design**

---

## Author

**Emirhan Tevfik Yiğit**  
Aerospace Engineering Student  
MATLAB & Simulink | UAV Design | Flight Dynamics | Engineering Analysis