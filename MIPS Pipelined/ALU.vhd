library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity MyALU is
	port (
	Input_1 : in STD_LOGIC_VECTOR(31 downto 0);
	Input_2 : in STD_LOGIC_VECTOR(31 downto 0);
	ALU_control : in STD_LOGIC_VECTOR(3 downto 0);
	ALU_result : out STD_LOGIC_VECTOR(31 downto 0));
end MyALU;

architecture Behavioral of MyALU is
	signal result : STD_LOGIC_VECTOR(31 downto 0);

begin

	process (Input_1, Input_2, ALU_control)
	begin
		case ALU_control is
			when "0010" => -- Add
					result <= STD_LOGIC_VECTOR(UNSIGNED(Input_1) + UNSIGNED(Input_2));
			when "0110" => -- Sub
					result <= STD_LOGIC_VECTOR(UNSIGNED(Input_1) - UNSIGNED(Input_2));
			when "0000" => -- And
					result <= Input_1 and Input_2;
			when "0001" => -- Or
					result <= Input_2 or Input_2;
			when "0111" => -- Set Less Than
					if (SIGNED(Input_1) < SIGNED(Input_2)) then
						result <= X"00000001";
					else 
						result <= X"00000000";
					end if;
			when others => null; -- Nop
					result <= X"00000000";
		end case;

	end process;
	
	ALU_result <= result;
	
end Behavioral;