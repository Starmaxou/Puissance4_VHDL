----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.04.2020 13:09:55
-- Design Name: 
-- Module Name: Clock_manager - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Clock_manager is
    Port ( H : in STD_LOGIC;
           RAZ : in STD_LOGIC;
           CEaff : out STD_LOGIC;
           CEincrement : out STD_LOGIC;
           CETraitement : out STD_LOGIC);
end Clock_manager;

architecture Behavioral of Clock_manager is
	signal Cpt25M 	: unsigned (1 downto 0);
	signal Cpt3k 	: unsigned (15 downto 0);
	signal Cpt1 	: unsigned (26 downto 0);
begin

	clock_25MHz : process (H, RAZ)
	begin
		if (RAZ = '1') then
			Cpt25M <= "00";
			CETraitement <= '0';
		elsif rising_edge(H) then
			if (Cpt25M = 2) then
				Cpt25M <= "00";
				CETraitement <= '1';
			else
				Cpt25M <= Cpt25M + 1;
				CETraitement <= '0';
			end if;
		end if;
	end process;
	
	clock_3kHz : process (H, RAZ)
	begin
		if (RAZ = '1') then
			Cpt3k <= "0000000000000000";
			CEaff <= '0';
		elsif rising_edge(H) then
			if (Cpt3k = 33333) then
				CEaff <= '1';
				Cpt3k <= "0000000000000000";
			else
				Cpt3k <= Cpt3k + 1;
				CEaff <= '0';
			end if;
		end if;
	
	end process;
	
	clock_1Hz : process (H, RAZ)
	begin
		if (RAZ = '1') then
			Cpt1 <= "000000000000000000000000000";
			CEIncrement <= '0';
		elsif rising_edge(H) then

			if (Cpt1 = 100000000-1) then
				Cpt1 <= "000000000000000000000000000";
				CEIncrement <= '1';
			else
				Cpt1 <= Cpt1 + 1;
				CEIncrement <= '0';
			end if;
		end if;
	end process;

end Behavioral;