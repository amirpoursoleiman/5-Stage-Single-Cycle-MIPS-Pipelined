library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MyRegisterFile is
	port (
	CLK : in  STD_LOGIC;
	WE3 : in  STD_LOGIC;
	A1  : in  STD_LOGIC_VECTOR(4 downto 0);
	A2  : in  STD_LOGIC_VECTOR(4 downto 0);
	A3  : in  STD_LOGIC_VECTOR(4 downto 0);
	WD3 : in  STD_LOGIC_VECTOR(31 downto 0);
	RD1 : out STD_LOGIC_VECTOR(31 downto 0);
	RD2 : out STD_LOGIC_VECTOR(31 downto 0));
end MyRegisterFile;

architecture Behavioral of MyRegisterFile is
	type Memory is array (0 to 31) of STD_LOGIC_VECTOR(31 downto 0);
	signal RegFile : Memory := (
			X"00000000",
			X"00000000",
			X"00000000",
			X"00000000",	
			X"00000000", 
			X"00000000", 
			X"00000000",  
			X"00000000",   
			X"00000000", 
			X"00000000", 
			X"00000000", 
			X"00000000", 
			X"00000000", 
			X"00000000", 
			X"00000000", 
			X"00000000", 
			X"00000000", 
			X"00000000", 
			X"00000000", 
			X"00000000", 
			X"00000000", 
			X"00000000", 
			X"00000000", 
			X"00000000", 
			X"00000000", 
			X"00000000", 
			X"00000000", 
			X"00000000", 
			X"00000000", 
			X"00000000", 
			X"00000000", 
                        X"00000000" 
	);

begin

	process (CLK)
	begin
		if (RISING_EDGE(CLK)) then
			if (WE3 = '1') then
				RegFile(TO_INTEGER(UNSIGNED(A3))) <= WD3;
			end if;
		end if;
	end process;

	RD1 <= RegFile(TO_INTEGER(UNSIGNED(A1)));
	RD2 <= RegFile(TO_INTEGER(UNSIGNED(A2)));

end Behavioral;
