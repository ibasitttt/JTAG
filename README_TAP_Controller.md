# 🔌 JTAG TAP Controller FSM – Verilog Implementation

## 📘 Project Overview

This project implements a **JTAG TAP Controller** as defined by the IEEE 1149.1 standard (commonly known as JTAG). The TAP (Test Access Port) Controller is the central piece of the JTAG protocol, responsible for managing all operations through a finite state machine (FSM).

The implementation includes:
- RTL (Verilog) code for the TAP controller FSM
- Synthesizable and testable design
- Full state transition logic using `TMS` and `TCK`
- Output signals: `cdr`, `sdr`, `udr`, `cir`, `sir`, `uir`
- A comprehensive testbench

---

## 🧠 What is JTAG?

JTAG is a **serial interface** used to test and program digital systems such as microcontrollers, processors, and FPGAs. Instead of relying on thousands of GPIOs to inspect or modify chip behavior, JTAG uses only a few lines to access internal registers, execute instructions, and debug the system.

---

## 🧭 TAP Controller FSM

The TAP controller is implemented as a 16-state finite state machine (FSM). Transitions depend on the `TMS` (Test Mode Select) signal and occur at the rising edge of the `TCK` (Test Clock).

### Main States:
- **TEST_LOGIC_RESET**: Resets all test logic
- **RUN_TEST_IDLE**: Idle or test execution
- **SELECT_DR/IR_SCAN**: Determines DR or IR operations
- **CAPTURE, SHIFT, EXIT, PAUSE, UPDATE** for both DR and IR paths

Each state controls specific outputs (`cdr`, `sdr`, `udr`, etc.) to indicate the current operation.

---

## 🧪 Testbench

The testbench drives the FSM through its states using sequences of `TMS` and `TCK` signals. Waveform analysis ensures correctness of state transitions and output signal activations.

---

## 🚀 How to Run

1. Clone the repository.
2. Open in your preferred Verilog simulator (e.g., ModelSim, Vivado, Icarus Verilog).
3. Simulate the testbench file.
4. Inspect output waveforms and logs to validate transitions.

---

## 📁 Files Included

- `tap_controller.v` – RTL implementation of the FSM
- `tap_controller_tb.v` – Testbench for simulation
- `README.md` – This documentation

---

## 🤝 Author

Reyansh Gahlot
Hardware & Digital Design Enthusiast  
Connect with me on [LinkedIn](https://www.linkedin.com/in/reyanshgahlot/)

---

## 📌 Tags

`JTAG` `TAP Controller` `FSM` `Verilog` `RTL Design` `Digital Electronics` `Debugging` `FPGA`

