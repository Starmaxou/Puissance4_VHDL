
  
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
           addr_grille_l_out : out STD_LOGIC_VECTOR (2 downto 0);
           out_check_victoire : out STD_LOGIC
           );
end compteur_test_victoire;

architecture Behavioral of compteur_test_victoire is
begin
    process(H,RST)
    variable cpt_c: integer range 0 to 6;
    variable cpt_l: integer range 0 to 6;
    variable flag   : boolean := false;
    begin
        if(RST = '1') then
           
            cpt_c:=0;
            cpt_l:=0;
            addr_grille_c_out<="000";
            addr_grille_l_out<="000";
            out_check_victoire<='0';
            flag:=false;
        elsif (H'event and H ='1') then
            if (CE = '1') then
                if(init_cpt = '1') then
                      cpt_c:=0;
                      cpt_l:=0;
                      flag:=true;
                elsif(en_cpt = '1' and flag=true) then
                  if(cpt_l = 6 and cpt_c=6)then
                     out_check_victoire<='1'; 
                     flag:=false;              
                  else
                         if(cpt_c=6) then
                              cpt_l := cpt_l + 1;
                              cpt_c:=0;
                         else
                              cpt_c := cpt_c + 1;
                         end if;           
                   end if;
                end if;
                  addr_grille_c_out <= std_logic_vector(to_unsigned(cpt_c, 3));
                  addr_grille_l_out <= std_logic_vector(to_unsigned(cpt_l, 3));
            end if;
        end if;
    end process;
end Behavioral;

