
----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.03.2021 13:48:59
-- Design Name: 
-- Module Name: mem_figure - Behavioral
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

entity grille_to_figure is
    Port (
           in_piece : in STD_LOGIC_VECTOR (1 downto 0);
           out_num_figure : out STD_LOGIC_VECTOR (2 downto 0));
end grille_to_figure;

architecture Behavioral of grille_to_figure is

begin
   with in_piece select
            out_num_figure <=  "011" when "10",
                           "100" when "01",
                           "101"when others;
end Behavioral;

