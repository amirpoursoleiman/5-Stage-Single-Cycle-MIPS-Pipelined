library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MyMIPSProcessor is
	port (
		CLK   : in STD_LOGIC;
		Reset : in STD_LOGIC);
end MyMIPSProcessor;

architecture Behavioral of MyMIPSProcessor is
	component MyPC is
		port (
			CLK    : in  STD_LOGIC;
			Reset  : in  STD_LOGIC;
			StallF : in  STD_LOGIC;
			PC_in  : in  STD_LOGIC_VECTOR(31 downto 0);
			PC_out : out STD_LOGIC_VECTOR(31 downto 0));
	end component;

	component MyPCAdder is
		port (
			PCA_in  : in  STD_LOGIC_VECTOR(31 downto 0);
			PCA_out : out STD_LOGIC_VECTOR(31 downto 0));
	end component;

	component MyInstructionMemory is
		port (
			A  : in  STD_LOGIC_VECTOR(31 downto 0);
			RD : out STD_LOGIC_VECTOR(31 downto 0));
	end component;

	component MyControlUnit is
		port (
			Op       : in  STD_LOGIC_VECTOR (5 downto 0);
			RegDst   : out STD_LOGIC;
			Branch_E : out STD_LOGIC;
			MemRead  : out STD_LOGIC;
			MemtoReg : out STD_LOGIC;
			ALUOp    : out STD_LOGIC_VECTOR (1 downto 0);
			MemWrite : out STD_LOGIC;
			ALUSrc   : out STD_LOGIC;
			RegWrite : out STD_LOGIC);
	end component;

	component MyMux is
		generic (
			N : integer := 32);
		port (
			MUX_in_0   : in  STD_LOGIC_VECTOR(N - 1 downto 0);
			MUX_in_1   : in  STD_LOGIC_VECTOR(N - 1 downto 0);
			MUX_select : in  STD_LOGIC;
			MUX_out    : out STD_LOGIC_VECTOR(N - 1 downto 0));
	end component;

	component MyMux2 is
		port (
			MUX2_in_0   : in  std_logic_vector (31 DOWNTO 0);
			MUX2_in_1   : in  std_logic_vector (31 DOWNTO 0);
			MUX2_in_2   : in  std_logic_vector (31 DOWNTO 0);
			MUX2_out    : out std_logic_vector(31 DOWNTO 0);
			MUX2_select : in  std_logic_vector(1 downto 0));
	end component;

	component MyRegisterFile is
		port (
			CLK : in  STD_LOGIC;
			WE3 : in  STD_LOGIC;
			A1  : in  STD_LOGIC_VECTOR(4 downto 0);
			A2  : in  STD_LOGIC_VECTOR(4 downto 0);
			A3  : in  STD_LOGIC_VECTOR(4 downto 0);
			WD3 : in  STD_LOGIC_VECTOR(31 downto 0);
			RD1 : out STD_LOGIC_VECTOR(31 downto 0);
			RD2 : out STD_LOGIC_VECTOR(31 downto 0));
	end component;

	component MyALU is
		port (
			Input_1     : in  STD_LOGIC_VECTOR(31 downto 0);
			Input_2     : in  STD_LOGIC_VECTOR(31 downto 0);
			ALU_control : in  STD_LOGIC_VECTOR(3 downto 0);
			ALU_result  : out STD_LOGIC_VECTOR(31 downto 0));
	end component;

	component MySignExtend is
		port (
			SE_in  : in  STD_LOGIC_VECTOR(15 downto 0);
			SE_out : out STD_LOGIC_VECTOR(31 downto 0));
	end component;

	component MyALUControl is
		port (
			ALUC_funct     : in  STD_LOGIC_VECTOR(5 downto 0);
			ALUOp          : in  STD_LOGIC_VECTOR(1 downto 0);
			ALUC_operation : out STD_LOGIC_VECTOR(3 downto 0));
	end component;

	component MyDataMemory is
		port (
			CLK       : in  STD_LOGIC;
			Address   : in  STD_LOGIC_VECTOR (31 downto 0);
			WD        : in  STD_LOGIC_VECTOR (31 downto 0);
			RE        : in  STD_LOGIC;
			WE        : in  STD_LOGIC;
			Read_Data : out STD_LOGIC_VECTOR (31 downto 0));
	end component;

	component MyShiftLefter is
		port (
			SL_in  : in  STD_LOGIC_VECTOR(31 downto 0);
			SL_out : out STD_LOGIC_VECTOR(31 downto 0));
	end component;

	component MyHazardUnit is
		port (
			RsD, RtD, RsE, RtE, WriteRegE, WriteRegM, WriteRegW : in  STD_LOGIC_VECTOR (4 downto 0);
			BranchD, MemtoRegE, RegWriteE, RegWriteM, RegWriteW : in  STD_LOGIC;
			StallF, StallD, FlushE                              : out STD_LOGIC;
			ForwardAE, ForwardBE                                : out STD_LOGIC_VECTOR (1 downto 0));
	end component;

	component MyEqual is
		port (
			value1  : in  std_logic_vector (31 downto 0);
			value2  : in  std_logic_vector (31 downto 0);
			EqualID : out std_logic);
	end component;

	component MyIF2ID is
		port (
			InstrF   : in  STD_LOGIC_VECTOR (31 DOWNTO 0);
			StallD   : in  STD_LOGIC;
			PCPlus4F : in  STD_LOGIC_VECTOR(31 downto 0);
			PCSrcD   : in  STD_LOGIC;
			CLK      : in  STD_LOGIC;
			InstrD   : out STD_LOGIC_VECTOR (31 DOWNTO 0);
			PCPlus4D : out STD_LOGIC_VECTOR (31 downto 0));
	end component;

	component MyID2IE is
		port (
			RD1D, RD2D, SignImmD                                        : in  STD_LOGIC_VECTOR (31 downto 0);
			RsD, RtD, RdD                                               : in  STD_LOGIC_VECTOR (4 downto 0);
			RegWriteD, MemtoRegD, MemWriteD, MemReadD, ALUSrcD, RegDstD : in  STD_LOGIC;
			FlushE                                                      : in  STD_LOGIC;
			CLK                                                         : in  STD_LOGIC;
			ALUOpD                                                      : in  STD_LOGIC_VECTOR (1 downto 0);
			RegWriteE, MemtoRegE, MemWriteE, MemReadE, ALUSrcE, RegDstE : out STD_LOGIC;
			RsE, RtE, RdE                                               : out STD_LOGIC_VECTOR (4 downto 0);
			RD1E, RD2E, SignImmE                                        : out STD_LOGIC_VECTOR (31 downto 0);
			ALUOpE                                                      : out STD_LOGIC_VECTOR (1 downto 0));
	end component;

	component MyIE2IM is
		port (
			ALUOutE, WriteDataE                       : in  STD_LOGIC_VECTOR (31 downto 0);
			WriteRegE                                 : in  STD_LOGIC_VECTOR(4 downto 0);
			RegWriteE, MemtoRegE, MemWriteE, MemReadE : in  STD_LOGIC;
			CLK                                       : in  STD_LOGIC;
			RegWriteM, MemtoRegM, MemWriteM, MemReadM : out STD_LOGIC;
			WriteRegM                                 : out STD_LOGIC_VECTOR(4 downto 0);
			ALUOutM, WriteDataM                       : out STD_LOGIC_VECTOR(31 downto 0));
	end component;

	component MyIM2IW is
		port (
			ReadDataM, ALUOutM   : in  STD_LOGIC_VECTOR (31 DOWNTO 0);
			WriteRegM            : in  STD_LOGIC_VECTOR (4 downto 0);
			RegWriteM, MemtoRegM : in  STD_LOGIC;
			CLK                  : in  STD_LOGIC;
			RegWriteW, MemtoRegW : out STD_LOGIC;
			WriteRegW            : out STD_LOGIC_VECTOR (4 downto 0);
			ReadDataW, ALUOutW   : out STD_LOGIC_VECTOR (31 downto 0));
	end component;

	signal PCprime    : STD_LOGIC_VECTOR(31 downto 0) := X"00000000";
	signal PCF        : STD_LOGIC_VECTOR(31 downto 0) := X"00000000";
	signal PCPLus4_F  : STD_LOGIC_VECTOR(31 downto 0) := X"00000000";
	signal Stall_F    : STD_LOGIC;
	signal Instr_F    : STD_LOGIC_VECTOR(31 downto 0) := X"00000000";
	signal PCBranch_D : STD_LOGIC_VECTOR(31 downto 0) := X"00000000";

	signal Stall_D          : STD_LOGIC;
	signal PCSrc_D          : STD_LOGIC;
	signal Instr_D          : STD_LOGIC_VECTOR(31 downto 0);
	signal PCPLus4_D        : STD_LOGIC_VECTOR(31 downto 0);
	signal RegWrite_W       : STD_LOGIC;
	signal ResultW          : STD_LOGIC_VECTOR(31 downto 0);
	signal RD1_D            : STD_LOGIC_VECTOR(31 downto 0);
	signal RD2_D            : STD_LOGIC_VECTOR(31 downto 0);
	signal SignImm_D        : STD_LOGIC_VECTOR(31 downto 0);
	signal shiftedSignImm_D : STD_LOGIC_VECTOR(31 downto 0);
	signal Equal_ID         : STD_LOGIC;

	signal Rs_D, Rt_D, Rd_D : STD_LOGIC_VECTOR(4 downto 0);
	signal opcode           : STD_LOGIC_VECTOR(5 downto 0);
	signal immediate        : STD_LOGIC_VECTOR(15 downto 0);
	signal funct            : STD_LOGIC_VECTOR(5 downto 0);

	signal RegDst_D, Branch_D, MemRead_D, MemtoReg_D, MemWrite_D, ALUSrc_D, RegWrite_D : STD_LOGIC;
	signal ALUOp_D                                                                     : STD_LOGIC_VECTOR(1 downto 0);
	signal Flush_E                                                                     : STD_LOGIC;
	signal RegWrite_E, MemtoReg_E, MemWrite_E, MemRead_E, ALUSrc_E, RegDst_E           : STD_LOGIC;
	signal Rs_E, Rt_E, Rd_E                                                            : STD_LOGIC_VECTOR(4 downto 0);
	signal RD1_E                                                                       : STD_LOGIC_VECTOR(31 downto 0);
	signal RD2_E                                                                       : STD_LOGIC_VECTOR(31 downto 0);
	signal SignImm_E                                                                   : STD_LOGIC_VECTOR(31 downto 0);
	signal ALUOp_E                                                                     : STD_LOGIC_VECTOR(1 downto 0);
	signal WriteReg_E                                                                  : STD_LOGIC_VECTOR(4 downto 0);
	signal ForwardA_E                                                                  : STD_LOGIC_VECTOR (1 downto 0);
	signal ForwardB_E                                                                  : STD_LOGIC_VECTOR (1 downto 0);
	signal WriteData_E                                                                 : STD_LOGIC_VECTOR(31 downto 0);
	signal SrcAE                                                                       : STD_LOGIC_VECTOR(31 downto 0);
	signal SrcBE                                                                       : STD_LOGIC_VECTOR(31 downto 0);
	signal ALUOut_M                                                                    : STD_LOGIC_VECTOR(31 downto 0);
	signal ALUOut_W                                                                    : STD_LOGIC_VECTOR(31 downto 0);
	signal ALUOut_E                                                                    : STD_LOGIC_VECTOR(31 downto 0);

	signal WriteReg_W                                    : STD_LOGIC_VECTOR(4 downto 0);
	signal ReadData_M                                    : STD_LOGIC_VECTOR(31 downto 0);
	signal RegWrite_M, MemtoReg_M, MemWrite_M, MemRead_M : STD_LOGIC;
	signal WriteReg_M                                    : STD_LOGIC_VECTOR(4 downto 0);
	signal WriteData_M                                   : STD_LOGIC_VECTOR(31 downto 0);
	signal alu_operation                                 : STD_LOGIC_VECTOR(3 downto 0);

	signal MemtoReg_W : STD_LOGIC;
	signal ReadData_W : STD_LOGIC_VECTOR(31 downto 0);

begin

	opcode    <= Instr_D(31 downto 26);
	Rs_D      <= Instr_D(25 downto 21);
	Rt_D      <= Instr_D(20 downto 16);
	Rd_D      <= Instr_D(15 downto 11);
	immediate <= Instr_D(15 downto 0);

	funct     <= SignImm_E(5 downto 0);

	PCBranch_D <= PCPlus4_D + shiftedSignImm_D;

	PCSrc_D <= ((Branch_D and Equal_ID));

		BranchMUX : MyMux generic map(32) port map (PCPLus4_F, PCBranch_D, PCSrc_D, PCprime);

		PC        : MyPC port map (CLK, Reset, Stall_F, PCprime, PCF);
		PCA       : MyPCAdder port map (PCF, PCPLus4_F);


		IM        : MyInstructionMemory port map (PCF, Instr_F);

		IF_2_ID : MyIF2ID port map (Instr_F, Stall_D, PCPLus4_F, PCSrc_D, CLK, Instr_D, PCPlus4_D);
		RF      : MyRegisterFile port map (CLK, RegWrite_W, Rs_D, Rt_D, WriteReg_W, ResultW, RD1_D, RD2_D);
		SE      : MySignExtend port map (immediate, SignImm_D);
		SL      : MyShiftLefter port map (SignImm_D, shiftedSignImm_D);
		CU      : MyControlUnit port map (opcode, RegDst_D, Branch_D, MemRead_D, MemtoReg_D, ALUOp_D, MemWrite_D, ALUSrc_D, RegWrite_D);
		Equal   : MyEqual port map (RD1_D, RD2_D, Equal_ID);

		ID_2_IE     : MyID2IE port map(RD1_D, RD2_D, SignImm_D, Rs_D, Rt_D, Rd_D, RegWrite_D, MemtoReg_D, MemWrite_D, MemRead_D, ALUSrc_D, RegDst_D, Flush_E, CLK, ALUOp_D, RegWrite_E, MemtoReg_E, MemWrite_E, MemRead_E, ALUSrc_E, RegDst_E, Rs_E, Rt_E, Rd_E, RD1_E, RD2_E, SignImm_E, ALUOp_E);
		RegDstMUX   : MyMux generic map(5) port map (Rt_E, Rd_E, RegDst_E, WriteReg_E);
		ForwardAMUX : MyMux2 port map (RD1_E, ALUOut_M, ALUOut_W, SrcAE, ForwardA_E);
		ForwardBMUX : MyMux2 port map (RD2_E, ALUOut_M, ALUOut_W, WriteData_E, ForwardB_E);
		ALUSrcMUX   : MyMux generic map(32) port map (WriteData_E, SignImm_E, ALUSrc_E, SrcBE);
		ALUC        : MyALUControl port map (funct, ALUOp_E, alu_operation);
		ALU         : MyALU port map (SrcAE, SrcBE, alu_operation, ALUOut_E);

		IE_2_IM : MyIE2IM port map (ALUOut_E, WriteData_E, WriteReg_E, RegWrite_E, MemtoReg_E, MemWrite_E, MemRead_E, CLK, RegWrite_M, MemtoReg_M, MemWrite_M, MemRead_M, WriteReg_M, ALUOut_M, WriteData_M);
		DM      : MyDataMemory port map (CLK, ALUOut_M, WriteData_M, MemRead_M, MemWrite_M, ReadData_M);

		IM_2_IW     : MyIM2IW port map (ReadData_M, ALUOut_M, WriteReg_M, RegWrite_M, MemtoReg_M, CLK, RegWrite_W, MemtoReg_W, WriteReg_W, ReadData_W, ALUOut_W);
		MemtoRegMUX : MyMux generic map(32) port map (ALUOut_W, ReadData_W, MemtoReg_W, ResultW);

		Hazard_Unit : MyHazardUnit port map (Rs_D, Rt_D, Rs_E, Rt_E, WriteReg_E, WriteReg_M, WriteReg_W, Branch_D, MemtoReg_E, RegWrite_E, RegWrite_M, RegWrite_W, Stall_F, Stall_D, Flush_E, ForwardA_E, ForwardB_E);

end Behavioral;