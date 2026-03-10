Topic: FastODE – A Lightweight High-Performance ODE Solver in C++ with Python Interface

Problem to Solve
Ordinary differential equations (ODEs) are one of the most widely used mathematical tools in science and engineering to describe how systems can change over time. Physical systems such as mechanic motion, electrical circuits and population models can expressed as an initial value problem(IVP):
dy/dt = f(t, y),  y(t₀) = y₀

where:

y is the state vector that represents the system,

t represents time,

f(t, y) is a function that defines how the system evolves,

y₀ is the initial condition.
The ultimate goal of an ODE solver is to achieve Numerical Integration and this is done by computing the value of the system state y at a later time t₁ > t₀ based initial state and the function f(t,y).
This project will make use of the Runge-Kutta methods:
    1. Fourth-Order Runge Kutta (RK4) - it's a fixed-step method that makes use local truncation error (O(h5)) and global error(O(h4))
    2. Dormand–Prince adaptive Runge Kutta (RK45) - a dynamic induced method that makes use of two different order methods to estimate the local error.  Based on this error estimate, the solver automatically adjusts the step size to satisfy user-defined accuracy tolerances.  This ensures that the solver is able to take smaller steps when the solutions changes rapidly and larger steps when the solution is smooth, optimizing both accuracy and efficiency.

Existing libraries like SciPy have powerful ODE solvers embedded in them.  However, they are often implemented in Python, specifically Python runtime and generally not ideal for situations where the solvers are to be implemented directly in C++ applications.  With that being said, the goal of FastODE is provide a lightweight solver that:
    1. provides a simple and transparent implementation of RK methods for educational use,
    2. allows direct integration into C++ applications,
    3. supports NumPy interoperability without unnecessary memory copying, and
    4. provides a clean Python interface similar to SciPy for ease of use
The project will mainly focus on non-stiff ODEs, which are common in many physical applications

Prospective Users
1.	Students and educators in applied mathematics, physics, and engineering who want a transparent, readable RK4/RK45 implementation they can study, modify, and extend. The codebase is intentionally kept small and well-commented.
2.	Scientific Python users who need a drop-in replacement for scipy.integrate.solve_ivp with lower overhead for moderate-sized problems, especially when the right-hand side function is already implemented in C++.
3.	HPC developers building simulation pipelines where the ODE solver is called millions of times (e.g. Monte Carlo trajectory ensembles). FastODE’s zero-copy numpy interface eliminates buffer allocation overhead on each call.


System Architecture
FastODE is organized into three layers:
    1. C++ Core (libfastode): this library contains the solver classes, that is, ODESolverRK4 and ODESolverRK45. The solver stores the state vector in a contiguous array of doubles to allow efficient numerical computation. RK45 will include adaptive step-size control using error estimation between the fourth- and fifth-order solutions. When the right-hand side function is implemented in C++, the solver runs entirely in native code for maximum performance.
    2. Python Bindings : Python bindings will be implemented using pybind11 whereby these bindings connect the Python interface with the C++ solver classes and allow Python functions to be used as the right-hand side function. The solution trajectory will be exposed to Python using the NumPy buffer protocol, which allows NumPy arrays to access the underlying C++ memory without copying the data. If the right-hand side function is written in Python, the solver will call back into Python at each Runge–Kutta stage. This may introduce some overhead, but it allows flexibility while still keeping the numerical core in C++.
    3. Python Interface Module : A thin Python module called fastode will provide a user-friendly interface similar to SciPy. The solver will return a solution object containing:
        - t: a 1D NumPy array of time points,
        - y: a 2D NumPy array of shape (n_dims, n_steps) containing the solution trajectory,
        - n_steps: the total number of steps taken,
        - n_rejected: the number of rejected steps (for RK45).
An additional helper function validate() will compare FastODE results with SciPy to verify correctness.

Workflow:
The typical workflow will be:
    - The user defines the function f(t, y) in Python.
    - The user provides the initial state y0, time interval, and tolerances.
    - The Python interface passes the data to the C++ solver (without copying the NumPy buffer).
    - The C++ solver performs the RK4 or RK45 integration.
    - The computed trajectory is returned to Python as a NumPy array.
    - The user can then visualize or analyze the results.

API Description

Engineering Infrastructure
Build System
CMake (3.18+) builds the C++ library and links against pybind11. A pyproject.toml wraps CMake for Python packaging, allowing installation with pip install -e . from the repository root. The project targets C++17.
Version Control
Git with a two-branch workflow: main for stable tagged releases and develop as the integration branch. Each feature or bug fix lives on a short-lived branch and is merged via pull request after CI passes. Commit messages follow the Conventional Commits convention (feat:, fix:, test:, docs:).
Testing Framework
C++ unit tests use Google Test (gtest) and verify the RK4 and RK45 kernels against problems with known analytical solutions: exponential decay (dy/dt = -ky), simple harmonic oscillator, and a two-body orbital problem. Python tests use pytest and validate FastODE output against scipy.integrate.solve_ivp to within rtol=1e-5. All tests must pass before any merge to main.
Continuous Integration
GitHub Actions runs on every push and pull request: compiles with CMake, runs gtest, installs the Python package, and runs pytest. The matrix covers Ubuntu (GCC) and macOS (Clang). A passing CI badge is displayed in the README.
Documentation
Python API is documented with NumPy-style docstrings and built into HTML with Sphinx + autodoc. C++ API is documented with Doxygen. A Quick Start section in the README walks through the Lotka-Volterra example end-to-end


Schedule
Planning phase (8 weeks):
    Week 1 (3/9) : Set up the repository structure. Configure CMake and pybind11. Implement a basic fixed-step RK4 solver for a scalar ODE. Validate the implementation using the exponential decay equation. Set up GitHub Actions.    
    Week 2 (3/16): Extend the RK4 solver to support vector-valued systems of arbitrary dimension. Add unit tests for the simple harmonic oscillator and Lotka–Volterra models. Expose the solver to Python through pybind11.ing.
    Week 3 (3/30): Implement the Dormand–Prince RK45 method in C++. Add the embedded error estimation and test the solver against SciPy results.
    Week 4 (4/13): Implement adaptive step-size control for RK45 using step acceptance and rejection rules. Refactor the solver classes and improve error handling.pecified rtol and atol. Refactoring week — clean up C++ class interfaces and improve error handling for degenerate inputs.
    Week 5 (4/27): Finalize the Python interface. Implement the fastode.solve() function and return a structured solution object. Complete the Python test suite.
    Week 6 (5/11): Add the validation utility and implement dense output interpolation for smoother plotting. Begin writing Sphinx documentation.
    Week 7 (5/25): Perform performance benchmarking comparing FastODE with SciPy and a pure Python implementation. Add a simple timing utility and summarize the results in the README.
    Week 8 (6/8) : Buffer week for unfinished tasks. If time permits, implement event detection and create demonstration notebooks for several example systems such as exponential decay, predator–prey dynamics, and a driven pendulum.
