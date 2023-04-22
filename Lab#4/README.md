# Problems in the Aggregation

- Defining memory stage but consider that we don't have mem_stage module we have memory and mem_stage_reg, so we instantiate them in arm explicitly

- Hazard detection unit is the most important implementation in this experiment, consider that a lot of hazards happens for handling register assignments

- We should add output of two_src in ID_Stage consider that it's an input of hazard detection unit and happens to stop the propagation of signals to ID_Stage_Reg and EXE_Stage (conidtion_check OR Hazard)

- Connect branch_taken to flushes and define flush for IF_Stage, IF_Stage_Reg, ID_Stage_Reg, and connect hazards to IF_Stage, IF_Stage_Reg, and ID_Stage

- First check register_file assignment and then memory assignment

- Need more time to complete the statements for me like 10ps clk (20ps) added about 25000ps fot testbench
