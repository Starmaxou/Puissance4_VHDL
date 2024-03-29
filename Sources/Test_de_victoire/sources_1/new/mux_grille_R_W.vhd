----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.02.2021 08:46:14
-- Design Name: 
-- Module Name: mux - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mux_grille_R_W is
    port(
        sel_mux :in STD_LOGIC;
        in_data0 : in STD_LOGIC;
        in_data1 : in STD_LOGIC;
        out_data : out STD_LOGIC
        );
--  Port ( );
end mux_grille_R_W;

architecture Behavioral of mux_grille_R_W is

begin
    mux : process(sel_mux,in_data0,in_data1)
        begin
        if(sel_mux='1')then
             out_data<= in_data1;
        else
             out_data<= in_data0;
        end if;
    end process;

end Behavioral;