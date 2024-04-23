LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;

entity MyEqual is
	port (
	value1 : in std_logic_vector (31 downto 0);
	value2 : in std_logic_vector (31 downto 0);
	EqualID : out std_logic);
end MyEqual;

architecture Behavioral of MyEqual is
begin

process(value1,value2)

begin
      if(value1 = value2) then
      EqualID <= '1';
      else
      EqualID <= '0';
      end if;
end process;

end Behavioral;
