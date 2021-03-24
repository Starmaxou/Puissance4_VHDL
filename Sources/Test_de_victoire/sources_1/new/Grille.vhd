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

entity grille is
    Port ( clk : in STD_LOGIC;
           ce : in STD_LOGIC;
           en_mem : in STD_LOGIC;
           in_data : in STD_LOGIC_VECTOR (2 downto 0);
           R_W : in std_logic;
           addr_grille_c : in STD_LOGIC_VECTOR (2 downto 0);
           addr_grille_l : in STD_LOGIC_VECTOR (2 downto 0);
           out_data : out STD_LOGIC_VECTOR (2 downto 0));
end grille;

architecture Behavioral of grille is

type tab_mem is array (0 to 6, 0 to 6) of std_logic_vector(2 downto 0); --L C

signal grille : tab_mem := (
                           ("101", "101","001","100","001","100","001"),
                           ("000", "000","000","000","000","000","000"),
                           ("000", "000","000","000","000","000","000"),
                           ("000", "000","000","000","000","000","000"),
                           ("000", "000","000","000","000","000","000"),
                           ("000", "000","000","000","000","000","000"),
                           ("000", "000","000","010","010","010","010"));
                          
                           

begin
    mem : process(clk)
    begin
        if(clk = '1' and clk'event) then
         if(ce='1') then
            if(en_mem='1')then
                if(R_W ='0') then
                    out_data <= grille(to_integer(unsigned(addr_grille_l)),to_integer(unsigned(addr_grille_c)));
                else
                   grille(to_integer(unsigned(addr_grille_l)),to_integer(unsigned(addr_grille_c)))<=in_data;
                end if;
            end if;
         end if;
        end if;
    end process;

end Behavioral;