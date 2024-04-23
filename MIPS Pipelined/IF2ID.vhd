LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity MyIF2ID is
	port (
        InstrF   : in STD_LOGIC_VECTOR (31 DOWNTO 0);
        StallD   : in STD_LOGIC;
        PCPlus4F : in STD_LOGIC_VECTOR(31 downto 0);
        PCSrcD   : in STD_LOGIC;
        CLK      : in STD_LOGIC;
        InstrD   : out STD_LOGIC_VECTOR (31 DOWNTO 0);
        PCPlus4D : out STD_LOGIC_VECTOR (31 downto 0));
end MyIF2ID;

architecture behavioral of MyIF2ID is
begin

      process(CLK)
      variable Ins, PCPlus: std_logic_vector(31 Downto 0); 
      begin

           if (falling_edge(CLK) and PCSrcD = '1') then
           InstrD <= "00000000000000000000000000000000";
           Ins := "00000000000000000000000000000000";
           PCPlus4D <= "00000000000000000000000000000000";
           PCPlus := "00000000000000000000000000000000";
           elsif (falling_edge(CLK) and StallD = '0' ) then
           InstrD <= InstrF;
           Ins := InstrF;
           PCPlus4D <= PCPlus4F;
           PCPlus := PCPlus4F;
           elsif (falling_edge(CLK) and StallD = '1') then
           InstrD <= Ins;
           PCPlus4D <= PCPlus;
           end if;
       end process;

end behavioral;
