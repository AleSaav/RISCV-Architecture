//************************* IF_ID_Register ******************************//
module IF_ID_Register(
    input [31:0] Instuction_Mem_OUT, //32-bit
    input  LE, Reset, clk, //Load Enable, Reset signal and Clock Signal
    output reg [31:0] I31_I0 //para el control unit
    ); //la senales de clock son rising edge triggered para todas las etapas 

    always @(posedge clk) 
    begin
        case (Reset)
        1'b1: 
        begin // Si la senal de Reset = 1, se da 
            I31_I0 <= 32'b0;
        end
        endcase

        case (LE)
        1'b1: 
        begin
            I31_I0 <= Instuction_Mem_OUT;
        end
        endcase
    end
endmodule
//************************* ID_EX_Register ******************************//
module ID_EX_Register (
    //Pipeline Register Input Signals
    input EX_Load_Instr_IN, EX_RF_Enable_IN, RAM_Enable_IN, RAM_RW_IN, RAM_SE_IN,
    input  Reset, clk, //Reset Signal and Clock Signal
    input JALR_Instr_IN, JAL_Instr_IN, AUIPC_Instr_IN,
    input [3:0] EX_ALU_op_IN,
    input [2:0] EX_shift_imm_IN,
    input [1:0] RAM_Size_IN,
    input [9:0] Comb_OpFunct_IN,

    //Pipeline Register Output Signals 
    output reg EX_Load_Instr_OUT, EX_RF_Enable_OUT, RAM_Enable_OUT, RAM_RW_OUT, RAM_SE_OUT, 
    output reg JALR_Instr_OUT, JAL_Instr_OUT, AUIPC_Instr_OUT,
    output reg [3:0] EX_ALU_op_OUT,
    output reg [2:0] EX_shift_imm_OUT,
    output reg [1:0] RAM_Size_OUT,
    output reg [9:0] Comb_OpFunct_OUT
    );

    always @ (posedge clk) 
        begin 
            case(Reset)
            1'b1: 
            begin
                EX_Load_Instr_OUT <= 1'b0;
                EX_RF_Enable_OUT <= 1'b0;
                RAM_Enable_OUT <= 1'b0;
                RAM_RW_OUT <= 1'b0;
                RAM_SE_OUT  <= 1'b0;
                JALR_Instr_OUT <= 1'b0;
                JAL_Instr_OUT <= 1'b0;
                AUIPC_Instr_OUT <= 1'b0;
                EX_ALU_op_OUT <= 4'b0;
                EX_shift_imm_OUT <= 3'b0;
                RAM_Size_OUT  <= 2'b0;
                Comb_OpFunct_OUT  <= 10'b0;
            end
            
            default:
            begin
                EX_Load_Instr_OUT <= EX_Load_Instr_IN;
                EX_RF_Enable_OUT <= EX_RF_Enable_IN;
                RAM_Enable_OUT <= RAM_Enable_IN;
                RAM_RW_OUT <= RAM_RW_IN;
                RAM_SE_OUT  <= RAM_SE_IN;
                JALR_Instr_OUT <= JALR_Instr_IN;
                JAL_Instr_OUT <= JAL_Instr_IN;
                AUIPC_Instr_OUT <= 1'b0;
                EX_ALU_op_OUT <= 4'b0;
                EX_shift_imm_OUT <= 3'b0;
                RAM_Size_OUT  <= 2'b0;
                Comb_OpFunct_OUT  <= 10'b0;
            end
        endcase
    end
endmodule
//************************* EX_MEM_Register ******************************//
module EX_MEM_Register (
    //Pipeline Register Input Signals
    input EX_Load_Instr_IN, EX_RF_Enable_IN, RAM_Enable_IN, RAM_RW_IN, RAM_SE_IN,
    input  Reset, clk, //Reset Signal and Clock Signal
    input [1:0] RAM_Size_IN,

    //Pipeline Register Output Signals
    output reg EX_Load_Instr_OUT, EX_RF_Enable_OUT, RAM_Enable_OUT, RAM_RW_OUT, RAM_SE_OUT, 
    output reg [1:0] RAM_Size_OUT
    );

    always @ (posedge clk) 
        begin 
            case(Reset)
            1'b1: 
            begin
                EX_Load_Instr_OUT <= 1'b0;
                EX_RF_Enable_OUT <= 1'b0;
                RAM_Enable_OUT <= 1'b0;
                RAM_RW_OUT <= 1'b0;
                RAM_SE_OUT  <= 1'b0;
                RAM_Size_OUT  <= 2'b0;
            end
            
            default:
            begin
                EX_Load_Instr_OUT <= EX_Load_Instr_IN;
                EX_RF_Enable_OUT <= EX_RF_Enable_IN;
                RAM_Enable_OUT <= RAM_Enable_IN;
                RAM_RW_OUT <= RAM_RW_IN;
                RAM_SE_OUT  <= RAM_SE_IN;
                RAM_Size_OUT  <= 2'b0;
            end
        endcase
    end
endmodule
//************************* MEM_WB_Register ******************************//
module MEM_WB_Register (
    //Pipeline Register Input Signals
    input EX_RF_Enable_IN,
    input  Reset, clk, //Reset Signal and Clock Signal
    //Pipeline Register Output Signals
    output reg EX_RF_Enable_OUT
    );

    always @ (posedge clk) 
        begin 
            case(Reset)
            1'b1: 
            begin      
                EX_RF_Enable_OUT <= 1'b0;
            end
            
            default:
            begin
                EX_RF_Enable_OUT <= EX_RF_Enable_IN;
            end
        endcase
    end
endmodule