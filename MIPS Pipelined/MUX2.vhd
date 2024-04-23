library ieee;
use ieee.std_logic_1164.ALL;

Entity MyMUX2 is
        port (
        MUX2_in_0 : in std_logic_vector (31 DOWNTO 0);
	MUX2_in_1 : in std_logic_vector (31 DOWNTO 0);
	MUX2_in_2 : in std_logic_vector (31 DOWNTO 0);
	MUX2_out : out std_logic_vector(31 DOWNTO 0);
	MUX2_select : in std_logic_vector(1 downto 0));
end entity;

architecture Behavioral of MyMUX2 is
begin

MUX2_out <= MUX2_in_0 when MUX2_select = "00" else
            MUX2_in_1 when MUX2_select = "01" else 
            MUX2_in_2 when MUX2_select = "10" else
            "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";

end Behavioral;
