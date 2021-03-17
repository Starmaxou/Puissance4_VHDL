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

entity verification_victoire is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           ce : in STD_LOGIC;
           en_verif : in STD_LOGIC;
           init_state : in STD_LOGIC;
           in_data : in STD_LOGIC_VECTOR (1 downto 0);
           addr_grille_c_out : out STD_LOGIC_VECTOR (2 downto 0);
           addr_grille_l_out : out STD_LOGIC_VECTOR (2 downto 0);
           --out_piece1_CL : out STD_LOGIC_VECTOR (5 downto 0);
           --out_piece2_CL : out STD_LOGIC_VECTOR (5 downto 0);
           --out_piece3_CL : out STD_LOGIC_VECTOR (5 downto 0);
           --out_piece4_CL : out STD_LOGIC_VECTOR (5 downto 0);
           out_victoire : out STD_LOGIC_VECTOR (1 downto 0)
           );
end verification_victoire;

architecture Behavioral of verification_victoire is
 TYPE STATE_TYPE IS (INIT_STATE_ON,INIT_STATE_OFF,SEND,CHECK_LIGNE,CHECK_COLONNE,CHECK_DIAGONALE_G1,CHECK_DIAGONALE_G2,CHECK_DIAGONALE_G3,CHECK_DIAGONALE_G4,CHECK_DIAGONALE_G5,CHECK_DIAGONALE_G6,CHECK_DIAGONALE_D1,CHECK_DIAGONALE_D2,CHECK_DIAGONALE_D3,CHECK_DIAGONALE_D4,CHECK_DIAGONALE_D5,CHECK_DIAGONALE_D6);
 SIGNAL cstate : STATE_TYPE;
 
begin
    mem : process(clk)
    variable cpt_c: integer range 0 to 6;
    variable cpt_l: integer range 0 to 5;
    variable cpt_piece: integer range 0 to 5;
    variable cpt_couleur: integer range 0 to 1;
    begin
        if(reset='1')then
            cpt_c:=0;
            cpt_l:=0;
            cpt_couleur:=0;
            cstate <= INIT_STATE_ON;
            out_victoire<="00";
            addr_grille_c_out<="000";
            addr_grille_l_out<="000";
        elsif(clk = '1' and clk'event) then
             if(ce='1') then
                if( en_verif='1')then
                   CASE cstate IS
                          WHEN INIT_STATE_ON=>
                                if(init_state='1')then
                                    cstate <=INIT_STATE_OFF;
                                else
                                    cstate <=INIT_STATE_ON;
                                end if;
                          cpt_c:=0;
                          cpt_l:=0;
                          cpt_couleur:=0;
                          WHEN INIT_STATE_OFF=>
                                if(init_state='0')then
                                    out_victoire<="00";
                                    cstate <=CHECK_LIGNE;
                                else
                                    cstate <=INIT_STATE_OFF;
                                end if;
                          WHEN CHECK_LIGNE=>
                                  if(cpt_l = 5 and cpt_c=6)then
                                    cpt_l:=0;
                                    cpt_c:=0;
                                    cstate <= CHECK_COLONNE;
                                  else
                                     if(cpt_c=6) then
                                          cpt_l := cpt_l + 1;
                                          cpt_c:=0;
                                     else
                                          cpt_c := cpt_c + 1;
                                     end if;
                                     cstate <=CHECK_LIGNE;
                                  end if;
                          WHEN CHECK_COLONNE =>
                                  if(cpt_l = 5 and cpt_c=6)then
                                    cpt_c:=0;
                                    cpt_l:=2;
                                    cstate <= CHECK_DIAGONALE_G1;
                                  else
                                     if(cpt_l=5) then
                                          cpt_c := cpt_c + 1;
                                          cpt_l:=0;
                                     else
                                          cpt_l := cpt_l + 1;
                                     end if;
                                     cstate <=CHECK_COLONNE;
                                  end if;
                                  
                           WHEN CHECK_DIAGONALE_G1=>
                           
                           
                                  if(cpt_c = 3 and cpt_l=5)then
                                    cpt_c:=0;
                                    cpt_l:=1;
                                    cstate <= CHECK_DIAGONALE_G2;
                                  else
                                          cpt_c := cpt_c + 1;
                                          cpt_l := cpt_l + 1;
                                     cstate <=CHECK_DIAGONALE_G1;
                                  end if;
                                  
                           WHEN CHECK_DIAGONALE_G2=>
                                  if(cpt_c = 4 and cpt_l=5)then
                                    cpt_c:=0;
                                    cpt_l:=0;
                                    cstate <= CHECK_DIAGONALE_G3;
                                  else
                                          cpt_c := cpt_c + 1;
                                          cpt_l := cpt_l + 1;
                                     cstate <=CHECK_DIAGONALE_G2;
                                  end if;
                                  
                           WHEN CHECK_DIAGONALE_G3=>
                               if(cpt_c = 5 and cpt_l=5)then
                                    cpt_c:=1;
                                    cpt_l:=0;
                                    cstate <= CHECK_DIAGONALE_G4;
                               else
                                          cpt_c := cpt_c + 1;
                                          cpt_l := cpt_l + 1;
                                     cstate <=CHECK_DIAGONALE_G3;
                               end if;
                                      
                                                                                            
                           WHEN CHECK_DIAGONALE_G4=>
                               if(cpt_c = 6 and cpt_l=5)then
                                    cpt_c:=2;
                                    cpt_l:=0;
                                    cstate <= CHECK_DIAGONALE_G5;
                               else
                                          cpt_c := cpt_c + 1;
                                          cpt_l := cpt_l + 1;
                                     cstate <=CHECK_DIAGONALE_G4;
                               end if;
                                 
                                 
                           WHEN CHECK_DIAGONALE_G5=>
                               if(cpt_c = 6 and cpt_l=4)then
                                    cpt_c:=3;
                                    cpt_l:=0;
                                    cstate <= CHECK_DIAGONALE_G6;
                               else
                                          cpt_c := cpt_c + 1;
                                          cpt_l := cpt_l + 1;
                                     cstate <=CHECK_DIAGONALE_G5;
                               end if;
                               
                            WHEN CHECK_DIAGONALE_G6=>
                               if(cpt_c = 6 and cpt_l=3)then
                                    cpt_c:=6;
                                    cpt_l:=2;
                                    cstate <= CHECK_DIAGONALE_D1;
                               else
                                          cpt_c := cpt_c + 1;
                                          cpt_l := cpt_l + 1;
                                     cstate <=CHECK_DIAGONALE_G6;
                               end if;
                           WHEN CHECK_DIAGONALE_D1=>
                                if(cpt_c = 3 and cpt_l=5)then
                                    cpt_c:=6;
                                    cpt_l:=1;
                                    cstate <= CHECK_DIAGONALE_D2;
                               else
                                          cpt_c := cpt_c - 1;
                                          cpt_l := cpt_l + 1;
                                     cstate <=CHECK_DIAGONALE_D1;
                               end if;
                           
                           WHEN CHECK_DIAGONALE_D2=>
                              if(cpt_c = 2 and cpt_l=5)then
                                    cpt_c:=6;
                                    cpt_l:=0;
                                    cstate <= CHECK_DIAGONALE_D3;
                               else
                                          cpt_c := cpt_c - 1;
                                          cpt_l := cpt_l + 1;
                                     cstate <=CHECK_DIAGONALE_D2;
                               end if;
                           WHEN CHECK_DIAGONALE_D3=>
                               if(cpt_c = 1 and cpt_l=5)then
                                    cpt_c:=5;
                                    cpt_l:=0;
                                    cstate <= CHECK_DIAGONALE_D4;
                               else
                                          cpt_c := cpt_c - 1;
                                          cpt_l := cpt_l + 1;
                                     cstate <=CHECK_DIAGONALE_D3;
                               end if;
                               
                           WHEN CHECK_DIAGONALE_D4=>   
                               if(cpt_c = 0 and cpt_l=5)then
                                    cpt_c:=4;
                                    cpt_l:=0;
                                    cstate <= CHECK_DIAGONALE_D5;
                               else
                                          cpt_c := cpt_c - 1;
                                          cpt_l := cpt_l + 1;
                                     cstate <=CHECK_DIAGONALE_D4;
                               end if;                                         
                          WHEN CHECK_DIAGONALE_D5=>           
                                if(cpt_c = 0 and cpt_l=4)then
                                    cpt_c:=3;
                                    cpt_l:=0;
                                    cstate <= CHECK_DIAGONALE_D6;
                               else
                                          cpt_c := cpt_c - 1;
                                          cpt_l := cpt_l + 1;
                                     cstate <=CHECK_DIAGONALE_D5;
                               end if;              
                                                                               
                                                                 
                           WHEN CHECK_DIAGONALE_D6=>
                               if(cpt_c = 0 and cpt_l=3)then
                                   if(cpt_couleur=1)then
                                        cpt_c:=0;
                                        cpt_l:=0;
                                        out_victoire<="11"; --pas de victoire
                                        cstate <= SEND;
                                   else
                                        cpt_c:=0;
                                        cpt_l:=0;
                                        cpt_couleur:=cpt_couleur+1;
                                        cstate <= CHECK_LIGNE;
                                   end if;
                               else
                                     cpt_c := cpt_c - 1;
                                     cpt_l := cpt_l + 1;
                                     cstate <=CHECK_DIAGONALE_D6;
                               end if;
                           WHEN SEND=>
                                    cstate <=INIT_STATE_ON;
                           
                           END CASE;      
                           if(cstate /= INIT_STATE_ON and cstate /= SEND) then
                                if(cpt_couleur=0)then
                                       if( in_data="10")then --jaune
                                            cpt_piece:=cpt_piece+1;
                                       else
                                            cpt_piece:=0;
                                       end if;
                                   else
                                       if( in_data="01")then --rouge
                                            cpt_piece:=cpt_piece+1;
                                       else
                                            cpt_piece:=0;
                                      end if;
                                end if;     
                           end if;  
                           if(cpt_piece =4)then
                              if(cpt_couleur=0)then --jaune
                                out_victoire<="10";
                              else
                                out_victoire<="01"; --rouge
                              end if;
                              cstate <= SEND;
                           end if;                                                         
                    addr_grille_c_out <= std_logic_vector(to_unsigned(cpt_c, 3));
                    addr_grille_l_out <= std_logic_vector(to_unsigned(cpt_l, 3));
                end if;
             end if;
             
        end if;
    end process;

end Behavioral;
