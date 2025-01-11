# Assembly Programs for 8086 (TASM Syntax)

Welcome to the **Assembly Programs Repository**! This collection features several programs written in **8086 Assembly Language** using the **TASM syntax**. These programs were created as part of the *Architecture des Ordinateurs* module and showcase fundamental concepts of low-level programming.

## 📋 Table of Contents

1. [About the Repository](#about-the-repository)
2. [Programs Overview](#programs-overview)
3. [Setup and Usage](#setup-and-usage)
4. [Contributing](#contributing)
5. [Acknowledgments](#acknowledgments)

---

## 📖 About the Repository

This repository serves as a learning resource and demonstration of the power and intricacies of **8086 Assembly Language**. These programs explore various topics, such as:

- Arithmetic operations
- String manipulation
- System interrupts
- Logical operations
- Memory management

Each program is thoroughly commented to help readers understand the logic and flow.

---

## 🗂 Programs Overview

Here are some highlights of the programs included:

- **Addition and Subtraction:** A basic program that demonstrates arithmetic operations.
- **String Reverse:** Reverses a given string using Assembly.
- **Factorial Calculation:** Computes the factorial of a number using loops.
- **Number Conversion:** Converts numbers between different bases (Binary, Decimal, Hexadecimal).
- **Keyboard Input Display:** Captures keyboard input and displays it on the screen.
                              **and much more!!!!!**
For detailed information on each program, check the comments inside the `.asm` files.

---

## 🛠️ Setup and Usage

### Prerequisites

1. **TASM (Turbo Assembler):** Ensure you have TASM installed to assemble and run the programs.
2. **DOS Emulator:** Use an emulator like [DOSBox](https://www.dosbox.com/) to run TASM on modern systems.

### Steps to Run

1. Clone this repository:
   ```bash
   git clone https://github.com/naderyb/Asm-programs.git
   cd Asm-programs
   ```
   2. Open your TASM environment or DOS emulator.
3. Assemble the desired program:
   ```bash
   tasm program_name.asm
   tlink program_name.obj
   program_name.exe
   ```
or in case you want to visualize the states of the segments...:
```bash
   tasm program_name.asm
   tlink program_name.obj
   debug program_name.exe
```
---
## 🤝 Contributing
Contributions are highly encouraged! If you'd like to improve an existing program, fix bugs, or add your own programs, follow these steps:
1. fork the the repository by clicking the "Fork" button at the top.
2. Clone your forked repository:
```bash
   git clone https://www.github.com/naderyb/asm_programs.git
   cd asm_programs
```
3. Create a new branch for your changes:
```bash
   git checkout -b feature/your-feature-name
```
4. Make your changes and commit them:
```bash
git commit -m "Add your feature description"
```
5. Push your changes to your forked repository:
```bash
git push origin feature/your-feature-name
```
6. Open a **Pull Request** on the original repository and describe your changes.
---
## 🙏 Acknowledgments
# A big thank you to **Mr BOUKABOU Hamid** who made this repository possible, and have been patient throughout these 3 semesters.
---

> **Made and created with ❤️ by [naderyb](https://github.com/naderyb) | © 2025**  
> Contributions and feedback are welcome! Let’s build something amazing together.
