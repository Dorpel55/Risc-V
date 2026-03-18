Project: RISC-V (single-file RTL)

Summary
- This repository currently contains a SystemVerilog register-file implementation (`Register File.sv`). There are no build scripts, testbenches, or CI configs present in the workspace.

What to preserve
- Zero register semantics: `RA1`, `RA2`, and `WA` are 5-bit indices; reads return `32'b0` when index is zero. Keep `x0` hardwired to zero when editing or refactoring.
- Synchronous write behavior: writes are performed on `posedge clk` gated by `RegWrite` and `WA != 0`. Preserve the write-enable gating and synchronous reset semantics when changing logic.

Conventions & patterns in this repo
- Language: SystemVerilog (single module `RegisterFile`). Use `.sv` extensions and SystemVerilog constructs rather than Verilog-2001-only style.
- Naming: Module is `RegisterFile` (PascalCase). Signals use mixed casing (e.g., `RegWrite`, `RA1`, `WD`). Follow existing signal names when extending modules.
- Register array: `logic [31:0] registers [31:0];` — 32 registers of 32 bits. Preserve array indexing direction if refactoring.

Observable issues (do not auto-fix without review)
- `Register File.sv` contains syntactic problems (missing commas in port list, an extra trailing comma, misplaced `else`/`end` nesting). Any automated edits should run a compile/sim before committing.

Developer workflows (what I found)
- No Makefile/CI/testbench present. Before pushing changes, run a SystemVerilog lint/compile step locally with your preferred tool (examples below). Confirm which simulator the project owner prefers.
  - Example quick checks (pick your tool):
    - `iverilog -g2012 -o sim.vvp "Register File.sv"` then `vvp sim.vvp` (Icarus Verilog; limited SystemVerilog support)
    - `verilator --lint-only --sv "Register File.sv"` (Verilator lint pass)

Editing guidelines for AI agents
- Read-first: open `Register File.sv` and preserve the visible semantics (x0 behavior and synchronous write). Document any change rationale in the commit message.
- Small, testable commits: for each change, produce a minimal simulation or compile command that demonstrates the change works (see example commands above).
- Don't rename interface signals across the repo without a matching update to all references. This repo is small now, but keep compatibility in mind.

Examples from the codebase
- Zero-register read pattern:
  - `assign RD1 = (RA1 == 5'h0) ? 32'b0 : registers[RA1];`
- Synchronous write pattern (intended):
  - `always @(posedge clk) begin` gated by `if (rst)` and `else if (RegWrite)` (note: nesting currently has syntax issues).

If you need more context
- There are no other source files or docs in the repo. Ask the repository owner which simulator/toolchain they expect and whether they want a testbench added (I can scaffold one and example run steps).

Questions for the owner
- Preferred simulator/toolchain? (Icarus, Verilator, VCS, Questa/ModelSim)
- Should `rst` be synchronous or asynchronous? Current code uses a synchronous-reset style (inside `posedge clk`) but has structural issues.

If this file is incomplete or you want different focus, tell me which files or workflows to prioritize and I'll iterate.
