
  
---------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.02.2021 08:33:14
-- Design Name: 
-- Module Name: compteur - Behavioral
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

entity compteur_test_victoire is
    Port ( CE : in STD_LOGIC;   -- Signal générique
           H : in STD_LOGIC;    -- Signal générique
           RST : in STD_LOGIC;  -- Signal générique
           en_cpt : in STD_LOGIC;   -- Signal FSM
           init_cpt : in STD_LOGIC; -- Signal FSM
           addr_grille_c_out : out STD_LOGIC_VECTOR (2 downto 0);
           addr_grille_l_out : out STD_LOGIC_VECTOR (2 downto 0)
           );
end compteur_test_victoire;

architecture Behavioral of compteur_test_victoire is
signal cpt_c: unsigned (2 downto 0):="000";
signal cpt_l: unsigned (2 downto 0):="000";
begin
    process(H,RST)
    begin
        if(RST = '1') then
           
            cpt_c<="000";
            cpt_l<="000";
        elsif (H'event and H ='1') then
            if (CE = '1') then
                if(init_cpt = '1') then
                      cpt_c<="000";
                      cpt_l<="000";
                elsif(en_cpt = '1') then
                  if(cpt_l = "110" and cpt_c="110")then
                       cpt_c<="000";
                       cpt_l<="000";
                  else
                         if(cpt_c="110") then
                              cpt_l <= cpt_l + 1;
                              cpt_c<="000";
                         else
                              cpt_c <= cpt_c + 1;
                         end if;           
                   end if;
                end if;
            end if;
        end if;
    end process;
         addr_grille_c_out <= std_logic_vector(cpt_c);
         addr_grille_l_out <= std_logic_vector(cpt_l);
end Behavioral;

