<h1 align="center">✈️ Aircraft Performance Analysis Using MATLAB</h1>

<p align="center">
  <b>MATLAB-Based Aircraft Performance Study</b>
</p>

<p align="center">
  Aerospace Engineering • Flight Performance • MATLAB • Climb Analysis • Altitude Effects
</p>

<hr>

<h2>📌 Project Overview</h2>

This project presents a basic <b>aircraft performance analysis</b> using <b>MATLAB</b>.

The main objective of this project is to analyze how aircraft performance changes with flight speed, available thrust, climb capability, and altitude.

The study focuses on important aircraft performance concepts such as <b>stall speed</b>, <b>drag</b>, <b>thrust required</b>, <b>power required</b>, <b>rate of climb</b>, <b>best climb speed</b>, and <b>altitude effects</b>.

This project is a continuation of previous aerodynamic analysis studies and represents a transition from airfoil-level analysis to full aircraft-level performance analysis.

<hr>

<h2>🎯 Project Goals</h2>

<ul>
  <li>Calculate stall speed</li>
  <li>Analyze lift coefficient required for level flight</li>
  <li>Calculate drag using a drag polar model</li>
  <li>Determine thrust required for steady level flight</li>
  <li>Calculate power required</li>
  <li>Estimate best endurance speed</li>
  <li>Estimate best range speed</li>
  <li>Analyze excess thrust and excess power</li>
  <li>Calculate rate of climb</li>
  <li>Determine best climb speed</li>
  <li>Study the effect of altitude on aircraft performance</li>
  <li>Save results as figures and CSV tables</li>
  <li>Document the project in a clean engineering format</li>
</ul>

<hr>

<h2>🧠 Engineering Background</h2>

Aircraft performance analysis is one of the fundamental topics in aerospace engineering.

It helps engineers understand how an aircraft behaves under different flight conditions such as speed, thrust, weight, wing area, and altitude.

In steady level flight, the basic force balance is:

<p align="center">
  <b>Lift = Weight</b>
</p>

<p align="center">
  <b>Thrust Required = Drag</b>
</p>

This means that the aircraft must generate enough lift to support its weight and enough thrust to overcome aerodynamic drag.

<hr>

<h2>📐 Aircraft Parameters</h2>

| Parameter | Value | Unit |
|---|---:|---|
| Aircraft Weight | 12000 | N |
| Wing Area | 16.2 | m² |
| Air Density at Sea Level | 1.225 | kg/m³ |
| Zero-Lift Drag Coefficient | 0.025 | - |
| Induced Drag Factor | 0.045 | - |
| Maximum Lift Coefficient | 1.50 | - |
| Available Thrust at Sea Level | 1800 | N |

<hr>

<h2>📐 Aerodynamic Model</h2>

The lift coefficient required for steady level flight is calculated using:

<p align="center">
  <b>CL = W / (0.5 × rho × V² × S)</b>
</p>

The drag coefficient is calculated using a parabolic drag polar:

<p align="center">
  <b>CD = CD0 + k × CL²</b>
</p>

The drag force is calculated as:

<p align="center">
  <b>D = 0.5 × rho × V² × S × CD</b>
</p>

In steady level flight:

<p align="center">
  <b>Thrust Required = Drag</b>
</p>

The power required is calculated as:

<p align="center">
  <b>Power Required = Thrust Required × Velocity</b>
</p>

<hr>

<h2>🧪 MATLAB Analyses</h2>

| Analysis | MATLAB File | Description |
|---|---|---|
| Basic Performance Analysis | `aircraft_performance_basic_analysis.m` | Calculates stall speed, drag, thrust required, power required, best range speed and best endurance speed |
| Climb Performance Analysis | `aircraft_performance_climb_analysis.m` | Calculates excess thrust, excess power, rate of climb, best climb speed and maximum level flight speed |
| Altitude Effect Analysis | `aircraft_performance_altitude_analysis.m` | Studies how air density and altitude affect stall speed, climb performance and maximum speed |
| Run All Analyses | `run_all_aircraft_performance_analysis.m` | Runs all aircraft performance analyses automatically |

<hr>

<h2>📊 Basic Performance Results</h2>

The basic performance analysis evaluates how aircraft performance changes with velocity.

| Result | Value |
|---|---:|
| Stall Speed | 28.39 m/s |
| Minimum Drag | 805.06 N |
| Best Range Speed | 40.00 m/s |
| Minimum Power Required | 28456.52 W |
| Best Endurance Speed | 31.00 m/s |

<h3>📈 Basic Aircraft Performance Plot</h3>

<p align="center">
  <img src="Results/Figures/aircraft_performance_basic_analysis.png" alt="Basic Aircraft Performance Analysis">
</p>

<hr>

<h2>🚀 Climb Performance Results</h2>

The climb analysis includes thrust available, thrust required, excess power and rate of climb.

| Result | Value |
|---|---:|
| Available Thrust | 1800.00 N |
| Stall Speed | 28.39 m/s |
| Maximum Rate of Climb | 3.85 m/s |
| Maximum Rate of Climb | 757.24 ft/min |
| Best Climb Speed | 52.00 m/s |
| Maximum Level Flight Speed | 82.00 m/s |

<h3>📈 Climb Performance Plot</h3>

<p align="center">
  <img src="Results/Figures/aircraft_performance_climb_analysis.png" alt="Aircraft Performance Climb Analysis">
</p>

<hr>

<h2>🌍 Altitude Effect Analysis</h2>

The altitude analysis studies how aircraft performance changes as altitude increases.

As altitude increases, air density decreases. This affects lift generation, available thrust, stall speed and climb performance.

The simplified air density model used in this project is based on an exponential atmosphere approximation.

<h3>📊 Altitude Summary Results</h3>

| Altitude | Air Density | Available Thrust | Stall Speed | Max ROC | Best Climb Speed | Max Level Speed |
|---:|---:|---:|---:|---:|---:|---:|
| 0 m | 1.2250 kg/m³ | 1800.00 N | 28.39 m/s | 3.85 m/s | 52.00 m/s | 82.00 m/s |
| 1500 m | 1.0268 kg/m³ | 1508.80 N | 31.01 m/s | 2.86 m/s | 53.00 m/s | 81.00 m/s |
| 3000 m | 0.8607 kg/m³ | 1264.71 N | 33.87 m/s | 1.97 m/s | 55.00 m/s | 80.00 m/s |
| 4500 m | 0.7215 kg/m³ | 1060.11 N | 37.00 m/s | 1.16 m/s | 57.00 m/s | 77.00 m/s |

<h3>📈 Altitude Effect Plot</h3>

<p align="center">
  <img src="Results/Figures/aircraft_performance_altitude_analysis.png" alt="Aircraft Performance Altitude Analysis">
</p>

<hr>

<h2>🔍 Key Engineering Findings</h2>

<ul>
  <li>The aircraft has a stall speed of <b>28.39 m/s</b> at sea level.</li>
  <li>The minimum drag condition occurs at approximately <b>40 m/s</b>.</li>
  <li>The minimum power required occurs at approximately <b>31 m/s</b>.</li>
  <li>The maximum rate of climb occurs at approximately <b>52 m/s</b>.</li>
  <li>At sea level, the maximum rate of climb is <b>3.85 m/s</b>, which is approximately <b>757 ft/min</b>.</li>
  <li>The maximum level flight speed is approximately <b>82 m/s</b>.</li>
</ul>

<hr>

<h2>🌍 Altitude Performance Interpretation</h2>

The altitude analysis clearly shows that aircraft performance decreases as altitude increases.

As altitude increases:

<ul>
  <li>Air density decreases</li>
  <li>Available thrust decreases</li>
  <li>Stall speed increases</li>
  <li>Maximum rate of climb decreases</li>
  <li>Best climb speed slightly increases</li>
  <li>Maximum level flight speed decreases</li>
</ul>

At sea level, the aircraft can achieve a maximum rate of climb of <b>3.85 m/s</b>.

At <b>4500 m</b>, the maximum rate of climb decreases to <b>1.16 m/s</b>.

This shows that the aircraft has less excess power available for climbing at higher altitudes.

<hr>

<h2>🧠 Engineering Interpretation</h2>

This project demonstrates the relationship between aerodynamic drag, available thrust, excess power and climb performance.

At low speeds, induced drag is high because the aircraft requires a high lift coefficient to maintain level flight.

At high speeds, parasite drag increases due to the increase in dynamic pressure.

Because of this, the drag curve has a minimum point. This minimum drag point is important for efficient cruise and range performance.

Rate of climb depends on excess power. When thrust available is greater than thrust required, the aircraft has positive excess power and can climb.

As altitude increases, air density decreases and the available thrust decreases. Therefore, the aircraft has less excess power and a lower climb rate.

<hr>

<h2>⚠️ Model Limitations</h2>

This project uses a simplified aircraft performance model.

The analysis does not include:

<ul>
  <li>Real engine performance maps</li>
  <li>Compressibility effects</li>
  <li>Detailed propeller efficiency</li>
  <li>Wind effects</li>
  <li>Aircraft stability and control effects</li>
  <li>Fuel burn and weight variation</li>
  <li>Real atmospheric temperature variation</li>
  <li>Detailed aerodynamic data from CFD or wind tunnel testing</li>
</ul>

The purpose of this project is to understand the fundamental aircraft performance relationships using MATLAB.

<hr>

<h2>📁 Repository Structure</h2>

<h3>MATLAB</h3>

<ul>
  <li><code>aircraft_performance_basic_analysis.m</code></li>
  <li><code>aircraft_performance_climb_analysis.m</code></li>
  <li><code>aircraft_performance_altitude_analysis.m</code></li>
  <li><code>run_all_aircraft_performance_analysis.m</code></li>
</ul>

<h3>Results / Figures</h3>

<ul>
  <li><code>aircraft_performance_basic_analysis.png</code></li>
  <li><code>aircraft_performance_climb_analysis.png</code></li>
  <li><code>aircraft_performance_altitude_analysis.png</code></li>
</ul>

<h3>Results / Tables</h3>

<ul>
  <li><code>aircraft_performance_basic_results.csv</code></li>
  <li><code>aircraft_performance_climb_results.csv</code></li>
  <li><code>aircraft_performance_altitude_full_results.csv</code></li>
  <li><code>aircraft_performance_altitude_summary_results.csv</code></li>
</ul>

<hr>

<h2>🛠️ Tools Used</h2>

<ul>
  <li>MATLAB</li>
  <li>Numerical simulation</li>
  <li>Aircraft performance analysis</li>
  <li>Aerodynamic drag polar modeling</li>
  <li>Thrust required calculation</li>
  <li>Power required calculation</li>
  <li>Rate of climb calculation</li>
  <li>Altitude effect analysis</li>
  <li>Data visualization</li>
  <li>CSV result export</li>
  <li>GitHub documentation</li>
</ul>

<hr>

<h2>✅ Skills Demonstrated</h2>

<ul>
  <li>Aircraft performance modeling</li>
  <li>Stall speed calculation</li>
  <li>Drag polar analysis</li>
  <li>Thrust required analysis</li>
  <li>Power required analysis</li>
  <li>Excess power calculation</li>
  <li>Rate of climb analysis</li>
  <li>Altitude performance interpretation</li>
  <li>MATLAB scripting</li>
  <li>Engineering visualization</li>
  <li>Technical documentation</li>
</ul>

<hr>

<h2>🏷️ Project Category</h2>

<p>
  <b>Aerospace Engineering</b><br>
  <b>Aircraft Performance</b><br>
  <b>Flight Mechanics</b><br>
  <b>MATLAB Simulation</b><br>
  <b>Aerodynamic Analysis</b><br>
  <b>Climb Performance</b><br>
  <b>Altitude Effects</b><br>
  <b>Engineering Portfolio</b>
</p>

<hr>

<h2>👨‍💻 Author</h2>

<p>
  <b>Emirhan Yiğit</b><br>
  Aerospace Engineering Student
</p>

<p>
  MATLAB & Simulink | UAV Design | Aerodynamics | Flight Performance | Engineering Analysis
</p>