LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY MyTB_MIPSProcessor IS
END MyTB_MIPSProcessor;

ARCHITECTURE Behavioral OF MyTB_MIPSProcessor IS

    COMPONENT MyMIPSProcessor
        PORT(
            CLK   : IN std_logic;
            Reset : IN std_logic
        );
    END COMPONENT;

    signal CLK   : std_logic := '0';
    signal Reset : std_logic := '0';
    constant CLK_period : time := 10 ns;

BEGIN

        MyTB : MyMIPSProcessor PORT MAP (
            CLK => CLK,
            Reset => Reset
        );

    process
    begin
        CLK <= '0';
        wait for CLK_period/2;
        CLK <= '1';
        wait for CLK_period/2;
    end process;

END Behavioral;