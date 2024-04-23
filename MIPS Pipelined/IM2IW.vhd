LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity MyIM2IW is
	port (    
        ReadDataM, ALUOutM :   in STD_LOGIC_VECTOR (31 DOWNTO 0);
        WriteRegM :            in STD_LOGIC_VECTOR (4 downto 0);
        RegWriteM, MemtoRegM : in STD_LOGIC;
	CLK :                  in STD_LOGIC;
	RegWriteW, MemtoRegW : out STD_LOGIC;
        WriteRegW :            out STD_LOGIC_VECTOR (4 downto 0);
        ReadDataW, ALUOutW:    out STD_LOGIC_VECTOR (31 downto 0));
end MyIM2IW;

architecture Behavioral of MyIM2IW is
begin

process (CLK)
              begin
              if (falling_edge(CLK)) then
              ReadDataW <= ReadDataM;
              ALUOutW <= ALUOutM;
              WriteRegW <= WriteRegM;
              RegWriteW <= RegWriteM;
              MemtoRegW <= MemtoRegM;
              end if;
end process;

end Behavioral;
