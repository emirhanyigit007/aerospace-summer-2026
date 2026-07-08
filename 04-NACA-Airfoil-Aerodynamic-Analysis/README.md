# 🛩️ NACA Airfoil Aerodynamic Analysis



<p align="center">

&#x20; <b>MATLAB-Based Aerodynamic Analysis of NACA 0012, NACA 2412 and NACA 4412 Airfoils</b>

</p>



<p align="center">

&#x20; Aerospace Engineering • Aerodynamics • MATLAB • Airfoil Analysis • Lift \& Drag

</p>



---



## 📌 Project Overview



This project presents a simplified aerodynamic analysis of different \*\*NACA airfoils\*\* using \*\*MATLAB\*\*.



The main objective is to analyze and compare the aerodynamic behavior of \*\*NACA 0012\*\*, \*\*NACA 2412\*\*, and \*\*NACA 4412\*\* airfoils under different flight conditions.



The project focuses on the relationship between \*\*angle of attack\*\*, \*\*lift coefficient\*\*, \*\*drag coefficient\*\*, \*\*lift-to-drag ratio\*\*, and aerodynamic forces.



---



## 🎯 Project Goals



\- Analyze the aerodynamic behavior of a NACA 0012 airfoil

\- Compare NACA 0012, NACA 2412 and NACA 4412 airfoils

\- Study the effect of angle of attack on lift and drag coefficients

\- Evaluate lift-to-drag ratio for aerodynamic efficiency

\- Analyze the effect of free-stream velocity on lift and drag forces

\- Compare different airfoils at the same angle of attack

\- Save simulation results as figures and CSV tables

\- Document the project in a clean engineering format



---



## 🧠 Engineering Background



Airfoils are one of the most important components in aircraft and UAV design. Their shape directly affects lift generation, drag production, aerodynamic efficiency and flight performance.



In this project, simplified aerodynamic models are used to understand the basic behavior of different airfoil types.



The aerodynamic force equations are:



```text

Lift = 0.5 \* rho \* V^2 \* S \* Cl

Drag = 0.5 \* rho \* V^2 \* S \* Cd

```



Where:



| Symbol | Description |

|---|---|

| `rho` | Air density |

| `V` | Free-stream velocity |

| `S` | Reference wing area |

| `Cl` | Lift coefficient |

| `Cd` | Drag coefficient |



\---



## 📐 Aerodynamic Model



The lift coefficient is estimated using a simplified thin airfoil theory approximation:



```text

Cl = 2 \* pi \* alpha

```



The drag coefficient is calculated using a parabolic drag polar:



```text

Cd = Cd0 + k \* Cl^2

```



The lift-to-drag ratio is calculated as:



```text

L/D = Cl / Cd

```



This ratio is used to evaluate aerodynamic efficiency.



---



## 🧪 MATLAB Studies



The project includes four main MATLAB analyses:



| Study | Description |

|---|---|

| Basic airfoil analysis | NACA 0012 lift, drag and L/D analysis |

| Airfoil comparison | Comparison of NACA 0012, NACA 2412 and NACA 4412 |

| Velocity effect analysis | Effect of velocity on lift and drag forces |

| Fixed angle comparison | Airfoil comparison at the same angle of attack |



---



## 📊 Airfoil Comparison Results



The airfoils were compared using simplified aerodynamic parameters.



| Airfoil | Max L/D | Best Alpha | Max Cl | Min Cd |

|---|---:|---:|---:|---:|

| NACA 0012 | 21.48 | 5.00 deg | 1.20 | 0.0120 |

| NACA 2412 | 18.89 | 3.00 deg | 1.40 | 0.0140 |

| NACA 4412 | 16.85 | 1.00 deg | 1.60 | 0.0160 |



### 📈 Lift-to-Drag Ratio Comparison



!\[L/D Ratio Comparison](Results/Figures/naca\_airfoil\_ld\_comparison.png)



---



## 🛩️ Fixed Angle of Attack Comparison



A fixed angle of attack of \*\*5 degrees\*\* was used to compare lift and drag forces for different airfoils.



| Airfoil | Cl | Cd | L/D | Lift \[N] | Drag \[N] |

|---|---:|---:|---:|---:|---:|

| NACA 0012 | 0.548 | 0.0255 | 21.48 | 302.26 | 14.07 |

| NACA 2412 | 0.768 | 0.0435 | 17.66 | 423.16 | 23.96 |

| NACA 4412 | 0.987 | 0.0696 | 14.19 | 544.06 | 38.35 |



### 📊 Fixed Alpha Lift Comparison



!\[Fixed Alpha Lift Comparison](Results/Figures/naca\_airfoil\_fixed\_alpha\_lift\_comparison.png)



### 📊 Fixed Alpha Drag Comparison



!\[Fixed Alpha Drag Comparison](Results/Figures/naca\_airfoil\_fixed\_alpha\_drag\_comparison.png)



---



## 🌬️ Velocity Effect Analysis



The effect of free-stream velocity on lift and drag forces was also analyzed.



As expected from the aerodynamic force equations, lift and drag forces increase with the square of velocity.



```text

Lift ∝ V²

Drag ∝ V²

```



This means that doubling the velocity increases aerodynamic forces approximately four times.



### 📈 Lift Force vs Velocity



!\[Lift vs Velocity](Results/Figures/naca\_airfoil\_lift\_vs\_velocity.png)



### 📉 Drag Force vs Velocity



!\[Drag vs Velocity](Results/Figures/naca\_airfoil\_drag\_vs\_velocity.png)



---



## 🔍 Key Engineering Findings



The analysis shows that \*\*NACA 0012\*\* provides the highest lift-to-drag ratio in this simplified model, making it the most aerodynamically efficient airfoil among the compared profiles.



\*\*NACA 2412\*\* provides a more balanced behavior by generating higher lift than NACA 0012 while maintaining moderate drag.



\*\*NACA 4412\*\* generates the highest lift due to its higher camber, but it also produces significantly higher drag. Therefore, it has the lowest lift-to-drag ratio among the compared airfoils.



At a fixed angle of attack of 5 degrees, cambered airfoils generate more lift than the symmetric NACA 0012 airfoil. However, this increase in lift comes with a clear drag penalty.



---



## 🧠 Engineering Interpretation



This project demonstrates the trade-off between lift generation and aerodynamic efficiency.



A highly cambered airfoil can produce more lift at the same angle of attack, but it may also create more drag. Therefore, the best airfoil selection depends on the design objective.



For applications where aerodynamic efficiency is more important, a higher lift-to-drag ratio may be preferred. For applications where maximum lift is required, a more cambered airfoil may be more suitable.



---



## 📁 Repository Structure


```text

04-NACA-Airfoil-Aerodynamic-Analysis

│

├── MATLAB

│   ├── naca\_airfoil\_basic\_analysis.m

│   ├── naca\_airfoil\_comparison.m

│   ├── naca\_airfoil\_velocity\_effect.m

│   ├── naca\_airfoil\_fixed\_alpha\_comparison.m

│   └── run\_all\_naca\_analysis.m

│

├── Results

│   ├── Figures

│   │   ├── naca0012\_basic\_aerodynamic\_analysis.png

│   │   ├── naca\_airfoil\_lift\_comparison.png

│   │   ├── naca\_airfoil\_drag\_comparison.png

│   │   ├── naca\_airfoil\_ld\_comparison.png

│   │   ├── naca\_airfoil\_lift\_vs\_velocity.png

│   │   ├── naca\_airfoil\_drag\_vs\_velocity.png

│   │   ├── naca\_airfoil\_fixed\_alpha\_lift\_comparison.png

│   │   └── naca\_airfoil\_fixed\_alpha\_drag\_comparison.png

│   │

│   └── Tables

│       ├── naca0012\_basic\_aerodynamic\_results.csv

│       ├── naca\_airfoil\_comparison\_results.csv

│       ├── naca\_airfoil\_velocity\_effect\_results.csv

│       └── naca\_airfoil\_fixed\_alpha\_results.csv

│

└── README.md

```



---



## 🛠️ Tools Used



\- MATLAB

\- Numerical simulation

\- Aerodynamic coefficient estimation

\- Lift and drag force calculation

\- Data visualization

\- CSV result export

\- GitHub documentation



---


## ✅ Skills Demonstrated



\- Airfoil aerodynamic analysis

\- Lift and drag coefficient calculation

\- Lift-to-drag ratio evaluation

\- MATLAB scripting

\- Engineering plotting and visualization

\- Comparative aerodynamic analysis

\- Result interpretation

\- Technical project documentation



---



## 🏷️ Project Category



\*\*Aerospace Engineering\*\*  

\*\*Aerodynamics\*\*  

\*\*Airfoil Analysis\*\*  

\*\*NACA Airfoils\*\*  

\*\*MATLAB Simulation\*\*  

\*\*Engineering Analysis\*\*



---



## 👨‍💻 Author



\*\*Emirhan Tevfik Yiğit\*\*  

Aerospace Engineering Student  



MATLAB \& Simulink | UAV Design | Aerodynamics | Engineering Analysis

