LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity MyIE2IM is
	port (    
        ALUOutE, WriteDataE :                       in STD_LOGIC_VECTOR (31 downto 0);
        WriteRegE :                                 in STD_LOGIC_VECTOR(4 downto 0);
        RegWriteE, MemtoRegE, MemWriteE, MemReadE : in STD_LOGIC;
        CLK :                                       in STD_LOGIC;
        RegWriteM, MemtoRegM, MemWriteM, MemReadM : out STD_LOGIC;
        WriteRegM :                                 out STD_LOGIC_VECTOR(4 downto 0);
        ALUOutM, WriteDataM :                       out STD_LOGIC_VECTOR(31 downto 0));
end MyIE2IM;

architecture Behavioral of MyIE2IM is
begin

process(CLK)
begin
     if (falling_edge(CLK)) then
     ALUOutM <= ALUOutE;
     WriteDataM <= WriteDataE; 
     RegWriteM <= RegWriteE;
     MemtoRegM <= MemtoRegE;
     MemWriteM <= MemWriteE;
     MemReadM <= MemReadE;
     WriteRegM <= WriteRegE;
end if;
end process;

end Behavioral;
