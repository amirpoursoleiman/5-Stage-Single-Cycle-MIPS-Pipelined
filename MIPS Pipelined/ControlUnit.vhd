library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MyControlUnit is
    port ( 
    Op        : in  STD_LOGIC_VECTOR (5 downto 0);
    RegDst    : out  STD_LOGIC;
    Branch_E  : out  STD_LOGIC;
    MemRead   : out  STD_LOGIC;
    MemtoReg  : out  STD_LOGIC;
    ALUOp     : out  STD_LOGIC_VECTOR (1 downto 0);
    MemWrite  : out  STD_LOGIC;
    ALUSrc    : out  STD_LOGIC;
    RegWrite  : out  STD_LOGIC);
end MyControlUnit;

architecture Behavioral of MyControlUnit is

begin

	process (Op)
	begin
		case Op is
			when "000000" => -- R-type commands
				RegDst    <= '1';
				Branch_E  <= '0';
				MemRead   <= '0';
				MemtoReg  <= '0';
				ALUOp     <= "10";
				MemWrite  <= '0';
				ALUSrc    <= '0';
				RegWrite  <= '1';
			when "100011" => -- lw
				RegDst    <= '0';
				Branch_E  <= '0';
				MemRead   <= '1';
				MemtoReg  <= '1';
				ALUOp     <= "00";
				MemWrite  <= '0';
				ALUSrc    <= '1';
				RegWrite  <= '1';
			when "101011" => -- sw
				RegDst    <= '1';
				Branch_E  <= '0';
				MemRead   <= '0';
				MemtoReg  <= '0';
				ALUOp     <= "00";
				MemWrite  <= '1';
				ALUSrc    <= '1';
				RegWrite  <= '0';
			when "000100" => -- beq
				RegDst    <= 'X';
				Branch_E  <= '1';
				MemRead   <= '0';
				MemtoReg  <= 'X';
				ALUOp     <= "01";
				MemWrite  <= '0';
				ALUSrc    <= '0';
				RegWrite  <= '0';
			when others => NULL;
				RegDst    <= '0';
				Branch_E  <= '0';
				MemRead   <= '0';
				MemtoReg  <= '0';
				ALUOp     <= "00";
				MemWrite  <= '0';
				ALUSrc    <= '0';
				RegWrite  <= '0';
		end case;
	end process;

end Behavioral;