library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

entity MyPC is
      port (
      CLK    : in  STD_LOGIC;
      Reset  : in  STD_LOGIC;
      StallF : in  STD_LOGIC;
      PC_in  : in  STD_LOGIC_VECTOR(31 downto 0);
      PC_out : out STD_LOGIC_VECTOR(31 downto 0) := (others => '0') );
end MyPC;

architecture Behavioral of MyPC is

begin

      process (CLK, Reset, StallF)
            variable pcout : STD_LOGIC_VECTOR(31 downto 0);
      begin

            if (Reset = '1') then
                  PC_out <= "00000000000000000000000000000000";
            elsif (falling_edge(CLK) and StallF = '0') then
                  PC_out <= PC_in;
                  pcout := PC_in;
            elsif (falling_edge(CLK) and StallF = '1') then
                  PC_out <= pcout;
                  pcout  := pcout;
            end if;

      end process;

end Behavioral;
