# ✈️ Aircraft Performance Analysis Using MATLAB

<p align="center">
  <b>MATLAB-Based Aircraft Performance Study</b>
</p>

<p align="center">
  Aerospace Engineering • Flight Performance • MATLAB • Climb Analysis • Altitude Effects
</p>

---

## 📌 Project Overview

This project presents a basic **aircraft performance analysis** using **MATLAB**.

The main objective of this project is to analyze how aircraft performance changes with flight speed, available thrust, climb capability, and altitude.

The study focuses on important aircraft performance concepts such as **stall speed**, **drag**, **thrust required**, **power required**, **rate of climb**, **best climb speed**, and **altitude effects**.

This project is a continuation of the previous aerodynamic analysis studies and represents a transition from airfoil-level analysis to full aircraft-level performance analysis.

---

## 🎯 Project Goals

- Calculate stall speed
- Analyze lift coefficient required for level flight
- Calculate drag using a drag polar model
- Determine thrust required for steady level flight
- Calculate power required
- Estimate best endurance speed
- Estimate best range speed
- Analyze excess thrust and excess power
- Calculate rate of climb
- Determine best climb speed
- Study the effect of altitude on aircraft performance
- Save results as figures and CSV tables
- Document the project in a clean engineering format

---

## 🧠 Engineering Background

Aircraft performance analysis is one of the fundamental topics in aerospace engineering.

It helps engineers understand how an aircraft behaves under different flight conditions such as speed, thrust, weight, wing area, and altitude.

In steady level flight, the basic force balance is:

**Lift = Weight**

**Thrust Required = Drag**

This means that the aircraft must generate enough lift to support its weight and enough thrust to overcome aerodynamic drag.

---

## 📐 Aircraft Parameters

The aircraft model used in this project is a simplified representative aircraft model.

| Parameter | Value | Unit |
|---|---:|---|
| Aircraft Weight | 12000 | N |
| Wing Area | 16.2 | m² |
| Air Density at Sea Level | 1.225 | kg/m³ |
| Zero-Lift Drag Coefficient | 0.025 | - |
| Induced Drag Factor | 0.045 | - |
| Maximum Lift Coefficient | 1.50 | - |
| Available Thrust at Sea Level | 1800 | N |

---

## 📐 Aerodynamic Model

The lift coefficient required for steady level flight is calculated using:

**CL = W / (0.5 × rho × V² × S)**

The drag coefficient is calculated using a parabolic drag polar:

**CD = CD0 + k × CL²**

The drag force is calculated as:

**D = 0.5 × rho × V² × S × CD**

In steady level flight:

**Thrust Required = Drag**

The power required is calculated as:

**Power Required = Thrust Required × Velocity**

---

## 🧪 MATLAB Analyses

This project includes three main MATLAB analyses:

| Analysis | MATLAB File | Description |
|---|---|---|
| Basic Performance Analysis | `aircraft_performance_basic_analysis.m` | Calculates stall speed, drag, thrust required, power required, best range speed and best endurance speed |
| Climb Performance Analysis | `aircraft_performance_climb_analysis.m` | Calculates excess thrust, excess power, rate of climb, best climb speed and maximum level flight speed |
| Altitude Effect Analysis | `aircraft_performance_altitude_analysis.m` | Studies how air density and altitude affect stall speed, climb performance and maximum speed |
| Run All Analyses | `run_all_aircraft_performance_analysis.m` | Runs all aircraft performance analyses automatically |

---

## 📊 Basic Performance Results

The basic performance analysis evaluates how aircraft performance changes with velocity.

| Result | Value |
|---|---:|
| Stall Speed | 28.39 m/s |
| Minimum Drag | 805.06 N |
| Best Range Speed | 40.00 m/s |
| Minimum Power Required | 28456.52 W |
| Best Endurance Speed | 31.00 m/s |

### 📈 Basic Aircraft Performance Plot

![Basic Aircraft Performance Analysis](Results/Figures/aircraft_performance_basic_analysis.png)

---

## 🚀 Climb Performance Results

The climb analysis includes thrust available, thrust required, excess power and rate of climb.

| Result | Value |
|---|---:|
| Available Thrust | 1800.00 N |
| Stall Speed | 28.39 m/s |
| Maximum Rate of Climb | 3.85 m/s |
| Maximum Rate of Climb | 757.24 ft/min |
| Best Climb Speed | 52.00 m/s |
| Maximum Level Flight Speed | 82.00 m/s |

### 📈 Climb Performance Plot

![Aircraft Performance Climb Analysis](Results/Figures/aircraft_performance_climb_analysis.png)

---

## 🌍 Altitude Effect Analysis

The altitude analysis studies how aircraft performance changes as altitude increases.

As altitude increases, air density decreases. This affects lift generation, available thrust, stall speed and climb performance.

The simplified air density model used in this project is based on an exponential atmosphere approximation.

### 📊 Altitude Summary Results

| Altitude | Air Density | Available Thrust | Stall Speed | Max ROC | Best Climb Speed | Max Level Speed |
|---:|---:|---:|---:|---:|---:|---:|
| 0 m | 1.2250 kg/m³ | 1800.00 N | 28.39 m/s | 3.85 m/s | 52.00 m/s | 82.00 m/s |
| 1500 m | 1.0268 kg/m³ | 1508.80 N | 31.01 m/s | 2.86 m/s | 53.00 m/s | 81.00 m/s |
| 3000 m | 0.8607 kg/m³ | 1264.71 N | 33.87 m/s | 1.97 m/s | 55.00 m/s | 80.00 m/s |
| 4500 m | 0.7215 kg/m³ | 1060.11 N | 37.00 m/s | 1.16 m/s | 57.00 m/s | 77.00 m/s |

### 📈 Altitude Effect Plot

![Aircraft Performance Altitude Analysis](Results/Figures/aircraft_performance_altitude_analysis.png)

---

## 🔍 Key Engineering Findings

The basic performance analysis shows that the aircraft has a stall speed of **28.39 m/s** at sea level.

The minimum drag condition occurs at approximately **40 m/s**, which can be interpreted as the best range speed approximation for this simplified model.

The minimum power required occurs at approximately **31 m/s**, which can be interpreted as the best endurance speed approximation.

The climb analysis shows that the aircraft reaches its maximum rate of climb at approximately **52 m/s**.

At sea level, the maximum rate of climb is **3.85 m/s**, which is approximately **757 ft/min**.

The maximum level flight speed is approximately **82 m/s**, where thrust available is still sufficient to overcome drag.

---

## 🌍 Altitude Performance Interpretation

The altitude analysis clearly shows that aircraft performance decreases as altitude increases.

As altitude increases:

- Air density decreases
- Available thrust decreases
- Stall speed increases
- Maximum rate of climb decreases
- Best climb speed slightly increases
- Maximum level flight speed decreases

At sea level, the aircraft can achieve a maximum rate of climb of **3.85 m/s**.

At **4500 m**, the maximum rate of climb decreases to **1.16 m/s**.

This shows that the aircraft has less excess power available for climbing at higher altitudes.

---

## 🧠 Engineering Interpretation

This project demonstrates the relationship between aerodynamic drag, available thrust, excess power and climb performance.

At low speeds, induced drag is high because the aircraft requires a high lift coefficient to maintain level flight.

At high speeds, parasite drag increases due to the increase in dynamic pressure.

Because of this, the drag curve has a minimum point. This minimum drag point is important for efficient cruise and range performance.

Rate of climb depends on excess power. When thrust available is greater than thrust required, the aircraft has positive excess power and can climb.

As altitude increases, air density decreases and the available thrust decreases. Therefore, the aircraft has less excess power and a lower climb rate.

---

## ⚠️ Model Limitations

This project uses a simplified aircraft performance model.

The analysis does not include:

- Real engine performance maps
- Compressibility effects
- Detailed propeller efficiency
- Wind effects
- Aircraft stability and control effects
- Fuel burn and weight variation
- Real atmospheric temperature variation
- Detailed aerodynamic data from CFD or wind tunnel testing

The purpose of this project is to understand the fundamental aircraft performance relationships using MATLAB.

---

## 📁 Repository Structure

- `MATLAB`
  - `aircraft_performance_basic_analysis.m`
  - `aircraft_performance_climb_analysis.m`
  - `aircraft_performance_altitude_analysis.m`
  - `run_all_aircraft_performance_analysis.m`

- `Results`
  - `Figures`
    - `aircraft_performance_basic_analysis.png`
    - `aircraft_performance_climb_analysis.png`
    - `aircraft_performance_altitude_analysis.png`
  - `Tables`
    - `aircraft_performance_basic_results.csv`
    - `aircraft_performance_climb_results.csv`
    - `aircraft_performance_altitude_full_results.csv`
    - `aircraft_performance_altitude_summary_results.csv`

- `README.md`

---

## 🛠️ Tools Used

- MATLAB
- Numerical simulation
- Aircraft performance analysis
- Aerodynamic drag polar modeling
- Thrust required calculation
- Power required calculation
- Rate of climb calculation
- Altitude effect analysis
- Data visualization
- CSV result export
- GitHub documentation

---

## ✅ Skills Demonstrated

- Aircraft performance modeling
- Stall speed calculation
- Drag polar analysis
- Thrust required analysis
- Power required analysis
- Excess power calculation
- Rate of climb analysis
- Altitude performance interpretation
- MATLAB scripting
- Engineering visualization
- Technical documentation

---

## 🏷️ Project Category

**Aerospace Engineering**  
**Aircraft Performance**  
**Flight Mechanics**  
**MATLAB Simulation**  
**Aerodynamic Analysis**  
**Climb Performance**  
**Altitude Effects**  
**Engineering Portfolio**

---

## 👨‍💻 Author

**Emirhan Tevfik Yiğit**  
Aerospace Engineering Student  

MATLAB & Simulink | UAV Design | Aerodynamics | Flight Performance | Engineering Analysis