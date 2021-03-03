----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.03.2021 13:36:07
-- Design Name: 
-- Module Name: grille - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity grille is
    port (
    en_men : in std_logic;
    R_W : in std_logic;
    ce : in std_logic;
    clk : in std_logic;
    in_adrL : in std_logic_vector(6 downto 0);
    in_adrC : in std_logic_vector(5 downto 0);
    in_data: in std_logic_vector(1 downto 0);
    out_data : out std_logic_vector(1 downto 0)
    );
end grille;

architecture Behavioral of grille is
type tab_mem is array (0 to 6,0 to 5) of std_logic_vector(1 downto 0);
signal my_table : tab_mem :=((others=> (others=>"00")));
begin
    mem : process(clk)
    begin
        if(clk = '1' and clk'event) then
         if(ce='1') then
            if(en_men='1')then
                if(R_W ='0') then
                    out_data <= my_table(to_integer(unsigned(in_adrL)),to_integer(unsigned(in_adrC)));
                else
                    my_table(to_integer(unsigned(in_adrL)),to_integer(unsigned(in_adrC)))<=in_data;
                end if;
            end if;
         end if;
        end if;
    end process;


end Behavioral;
