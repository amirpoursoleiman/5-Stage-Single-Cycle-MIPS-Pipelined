library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MyShiftLefter is
	port (
	SL_in  : in STD_LOGIC_VECTOR(31 downto 0);
	SL_out : out STD_LOGIC_VECTOR(31 downto 0));
end MyShiftLefter;

architecture Behavioral of MyShiftLefter is

begin

	SL_out(31) <= SL_in(31);
	SL_out(30 downto 2) <= SL_in(28 downto 0);
	SL_out(1 downto 0) <= (others => '0');

end Behavioral;