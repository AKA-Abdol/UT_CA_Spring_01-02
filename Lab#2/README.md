
# Lab 2

In this sesion you should design and implement Instruction Decode pipeline stage. For ID_Stage we need 3 sub modules:
- RegisterFile, consider 18, 32bit reg
    - How to define regFile?
    ```bash
        reg[31:0] regFile[0:14];
    ```
- ControlUnit, with 3 input of mode, Op-code, and S, you should generate some critical signals
    - Caution! in the "SwitchCase" we can't "if" or conditional statements like "x = (a == 2'b10) ? 1 : 0;". So, define mem_read_en, mem_write_en outside of your case block (outside of always block with simple assign)
    ```bash
        assign mem_read_en = (mode == 2'b01 && s == 1'b1) ? 1 : 0;
    ```
- ConditionCheck, with inputs from StatusRegister (it's not implemented and we are not going to implement it in this session), and condition from Instruction we should generate a 1bit signal shows that the condition is valid or not 
    - Caution! output of this module in the final ID_Stage module is going to be not! (I named the selector signal of mux can_not_pass (it's a shitty name btw!))
    ```bash
        --> is_valid is output of ControlCheck module
        can_not_pass = ~is_valid;
    ```

After you implemented all modules you should assemble instances of them in the ID_Stage module.
- Caution! consider that you should use 2 mux2to1 for:
    - one: input of src2 for RegisterFile the selector is mem_wb_en, it is mostly Rm except for STR it is Rd (or dest)
    ```bash
        Rd = Instruction[15:12]
        Rm = Instruction[3:0]
        if mem_write_en == 1 then val_Rm = Rd else val_Rm = Rm;
    ```
    - two: output to ID_Stage_Reg with ConditionCheck output as selector

## Notations
- from IF_Stage to IF_Stage_Reg we are one clk late
- BUT from IF_Stage_Reg to ID_Stage we are sync! I mean they are working at the same clk and values.
- and for ID_Stage_Reg again we are one clk late from ID_Stage.

Wish You Luck!
