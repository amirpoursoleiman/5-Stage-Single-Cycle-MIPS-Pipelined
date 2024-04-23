library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity MySignExtend is
	port (
	SE_in  : in STD_LOGIC_VECTOR(15 downto 0);
	SE_out : out STD_LOGIC_VECTOR(31 downto 0));
end MySignExtend;

architecture Behavioral of MySignExtend is

begin
	SE_out <= STD_LOGIC_VECTOR(RESIZE(SIGNED(SE_in), 32));

end Behavioral;
