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
           init_state : in STD_LOGIC;
           in_data : in STD_LOGIC_VECTOR (2 downto 0);
           addr_grille_c_out : out STD_LOGIC_VECTOR (2 downto 0);
           addr_grille_l_out : out STD_LOGIC_VECTOR (2 downto 0);
           out_victoire : out STD_LOGIC_VECTOR (1 downto 0);
           piece1_LC : out STD_LOGIC_VECTOR (15 downto 0);
           piece2_LC : out STD_LOGIC_VECTOR (15 downto 0);
           piece3_LC : out STD_LOGIC_VECTOR (15 downto 0);
           piece4_LC : out STD_LOGIC_VECTOR (15 downto 0)
   
           );
end verification_victoire;

architecture Behavioral of verification_victoire is
 TYPE Etat IS (INIT_STATE_ON,INIT_STATE_OFF,FIN,SEND,CHECK_LIGNE,CHECK_COLONNE,CHECK_DIAGONALE_G1,CHECK_DIAGONALE_G2,CHECK_DIAGONALE_G3,CHECK_DIAGONALE_G4,CHECK_DIAGONALE_G5,CHECK_DIAGONALE_G6,CHECK_DIAGONALE_D1,CHECK_DIAGONALE_D2,CHECK_DIAGONALE_D3,CHECK_DIAGONALE_D4,CHECK_DIAGONALE_D5,CHECK_DIAGONALE_D6,TMP);
 signal pr_state , nx_state  : Etat := INIT_STATE_ON;
 SIGNAL cpt_c:  STD_LOGIC_VECTOR (7 downto 0);
 SIGNAL cpt_l : STD_LOGIC_VECTOR (7 downto 0);
 SIGNAL cpt_c_1:  STD_LOGIC_VECTOR (7 downto 0);
 SIGNAL cpt_l_1 : STD_LOGIC_VECTOR (7 downto 0);
 SIGNAL cpt_piece4_jaune : STD_LOGIC_VECTOR (2 downto 0);
 SIGNAL cpt_piece4_rouge : STD_LOGIC_VECTOR (2 downto 0);
 SIGNAL buf_out_piece1_LC : STD_LOGIC_VECTOR (15 downto 0);
 SIGNAL buf_out_piece2_LC : STD_LOGIC_VECTOR (15 downto 0);
 SIGNAL buf_out_piece3_LC : STD_LOGIC_VECTOR (15 downto 0);
 SIGNAL buf_out_piece4_LC : STD_LOGIC_VECTOR (15 downto 0);

begin
    
    maj_etat : process ( clk , reset )
    begin
        if ( reset ='1') then
            pr_state <= INIT_STATE_ON ;
        elsif ( clk' event and clk='1') then
            if(ce = '1') then
            	pr_state <= nx_state ;
            end if;
        end if;
    end process maj_etat;

    
    cal_nx_state : process (pr_state, cpt_c, cpt_l, init_state,cpt_piece4_rouge,cpt_piece4_jaune)
        begin
            case pr_state is
                       when  INIT_STATE_ON=>
                                if( init_state='1')then
                                      nx_state <=INIT_STATE_OFF;
                                else
                                      nx_state <=INIT_STATE_ON;
                                end if;
                       when  INIT_STATE_OFF=>   
                                if(init_state='0')then
                                    nx_state <=CHECK_LIGNE;
                                else
                                    nx_state<=INIT_STATE_OFF;
                                end if;  
                       when  CHECK_LIGNE=>  
                            if(cpt_piece4_rouge ="100" or cpt_piece4_jaune="100")then
                                nx_state <= FIN;
                            else
                                    if(cpt_l = X"06" and cpt_c=X"06")then
                                         nx_state <= CHECK_COLONNE;
                                    else
                                         nx_state <= CHECK_LIGNE;
                                    end if;
                            end if;

                       when   CHECK_COLONNE=>
                           if(cpt_piece4_rouge ="100" or cpt_piece4_jaune="100")then
                                nx_state <= FIN;
                            else
                                  if(cpt_l = X"06" and cpt_c=X"06")then
                                         nx_state <= CHECK_DIAGONALE_G1;
                                  else
                                         nx_state <= CHECK_COLONNE;
                                  end if; 
                            end if;  
                              
                       when   CHECK_DIAGONALE_G1=>
                           if(cpt_piece4_rouge ="100" or cpt_piece4_jaune="100")then
                                nx_state <= FIN;
                            else
                                  if(cpt_c = X"03" and cpt_l=X"06")then
                                         nx_state <= CHECK_DIAGONALE_G2;
                                  else
                                         nx_state <= CHECK_DIAGONALE_G1;
                                  end if; 
                            end if;
                              
                       when   CHECK_DIAGONALE_G2=>
                           if(cpt_piece4_rouge ="100" or cpt_piece4_jaune="100")then
                                nx_state <= FIN;
                            else
                                    if(cpt_c = X"04" and cpt_l=X"06")then
                                         nx_state <= CHECK_DIAGONALE_G3;
                                    else
                                         nx_state <= CHECK_DIAGONALE_G2;
                                    end if; 
                            end if;
    
                       when   CHECK_DIAGONALE_G3=>
                           if(cpt_piece4_rouge ="100" or cpt_piece4_jaune="100")then
                                nx_state <= FIN;
                            else
                                    if(cpt_c = X"05" and cpt_l=X"06")then
                                         nx_state <= CHECK_DIAGONALE_G4;
                                    else
                                         nx_state <= CHECK_DIAGONALE_G3;
                                    end if; 
                            end if;

                       when   CHECK_DIAGONALE_G4=>
                           if(cpt_piece4_rouge ="100" or cpt_piece4_jaune="100")then
                                nx_state <= FIN;
                            else
                                    if(cpt_c = X"06" and cpt_l=X"06")then
                                         nx_state <= CHECK_DIAGONALE_G5;
                                    else
                                         nx_state <= CHECK_DIAGONALE_G4;
                                    end if; 
                            end if;

                       when   CHECK_DIAGONALE_G5=>
                           if(cpt_piece4_rouge ="100" or cpt_piece4_jaune="100")then
                                nx_state <= FIN;
                            else
                                    if(cpt_c = X"06" and cpt_l=X"05")then
                                         nx_state <= CHECK_DIAGONALE_G6;
                                    else
                                         nx_state <= CHECK_DIAGONALE_G5;
                                    end if; 
                            end if;

                       when   CHECK_DIAGONALE_G6=>
                           if(cpt_piece4_rouge ="100" or cpt_piece4_jaune="100")then
                                nx_state <= FIN;
                            else
                                    if(cpt_c = X"06" and cpt_l=X"04")then
                                         nx_state <= CHECK_DIAGONALE_D1;
                                    else
                                         nx_state <= CHECK_DIAGONALE_G6;
                                    end if;
                            end if;

                       when   CHECK_DIAGONALE_D1=>
                           if(cpt_piece4_rouge ="100" or cpt_piece4_jaune="100")then
                                nx_state <= FIN;
                           else
                                 if(cpt_c = X"03" and cpt_l=X"06")then
                                         nx_state <= CHECK_DIAGONALE_D2;
                                 else
                                         nx_state <= CHECK_DIAGONALE_D1;
                                 end if;
                           end if;
                                
                       when   CHECK_DIAGONALE_D2=>
                           if(cpt_piece4_rouge ="100" or cpt_piece4_jaune="100")then
                                nx_state <= FIN;
                            else
                                    if(cpt_c = X"02" and cpt_l=X"06")then
                                         nx_state <= CHECK_DIAGONALE_D3;
                                    else
                                         nx_state <= CHECK_DIAGONALE_D2;
                                    end if;  
                            end if;
                              
                       when   CHECK_DIAGONALE_D3=>
                           if(cpt_piece4_rouge ="100" or cpt_piece4_jaune="100")then
                                nx_state <= FIN;
                            else
                                    if(cpt_c = X"01" and cpt_l=X"06")then
                                         nx_state <= CHECK_DIAGONALE_D4;
                                    else
                                         nx_state <= CHECK_DIAGONALE_D3;
                                    end if;           
                            end if;
                     
                       when   CHECK_DIAGONALE_D4=>
                           if(cpt_piece4_rouge ="100" or cpt_piece4_jaune="100")then
                                nx_state <= FIN;
                            else
                                    if(cpt_c = X"00" and cpt_l=X"06")then
                                         nx_state <= CHECK_DIAGONALE_D5;
                                    else
                                         nx_state <= CHECK_DIAGONALE_D4;
                                    end if;               
                            end if;
                 
                       when   CHECK_DIAGONALE_D5=>
                           if(cpt_piece4_rouge ="100" or cpt_piece4_jaune="100")then
                                nx_state <= FIN;
                            else
                                if(cpt_c = X"00" and cpt_l=X"05")then
                                         nx_state <= CHECK_DIAGONALE_D6;
                                else
                                         nx_state <= CHECK_DIAGONALE_D5;
                                end if; 
                            end if;
                                                              
                       when   CHECK_DIAGONALE_D6=>
                           if(cpt_piece4_rouge ="100" or cpt_piece4_jaune="100")then
                                nx_state <= FIN;
                            else
                                 if(cpt_c = X"00" and cpt_l=X"04")then
                                          nx_state <= FIN;
                                 else
                                         nx_state <= CHECK_DIAGONALE_D6;
                                 end if;
                            end if;
                      when  FIN=>
                                  nx_state <=TMP;
                       when  TMP=>
                                nx_state <=SEND;
                      when  SEND=>
                              nx_state <=INIT_STATE_ON;
            end case;
        end process cal_nx_state;
        
        
    cal_output : process(clk,reset)
     variable Vcpt_c: integer range 0 to 6;
     variable Vcpt_l: integer range 1 to 6;
        begin
         if(reset='1')then
           Vcpt_c:=0;
           Vcpt_l:=1;
           
         elsif ( clk' event and clk='1') then
            if(ce = '1') then
            case pr_state is
                when INIT_STATE_ON =>
                   Vcpt_c:=0;
                   Vcpt_l:=1;
                when INIT_STATE_OFF =>
                  Vcpt_c:=0;
                  Vcpt_l:=1;
                when CHECK_LIGNE =>
                    
                        if(Vcpt_l = 6 and Vcpt_c=6)then
                            Vcpt_l:=1;
                            Vcpt_c:=0;
                          
                        else
                             if(Vcpt_c=6) then
                                  Vcpt_l := Vcpt_l + 1;
                                  Vcpt_c:=0;
                             else
                                  Vcpt_c := Vcpt_c + 1;
                             end if;
                            
                        end if;                  
                 
                when CHECK_COLONNE =>
                      if(Vcpt_l = 6 and Vcpt_c=6)then
                        Vcpt_c:=0;
                        Vcpt_l:=3;                   
                      else
                         if(Vcpt_l=6) then
                              Vcpt_c := Vcpt_c + 1;
                              Vcpt_l:=1;
                         else
                              Vcpt_l := Vcpt_l + 1;
                         end if;
                      end if;             
                when CHECK_DIAGONALE_G1=>
                      if(Vcpt_c = 3 and Vcpt_l=6)then
                        Vcpt_c:=0;
                        Vcpt_l:=2;
                      else
                        Vcpt_c := Vcpt_c + 1;
                        Vcpt_l := Vcpt_l + 1;
                      end if;
           
                when CHECK_DIAGONALE_G2=>
                     if(Vcpt_c = 4 and Vcpt_l=6)then
                        Vcpt_c:=0;
                        Vcpt_l:=1;
                     else
                        Vcpt_c := Vcpt_c + 1;
                        Vcpt_l := Vcpt_l + 1;
                     end if;
                                  
                when CHECK_DIAGONALE_G3=>
                     if(Vcpt_c = 5 and Vcpt_l=6)then
                        Vcpt_c:=1;
                        Vcpt_l:=1;
                     else
                        Vcpt_c := Vcpt_c + 1;
                        Vcpt_l := Vcpt_l + 1;
                     end if;  
                                  
                when CHECK_DIAGONALE_G4=>
                     if(Vcpt_c = 6 and Vcpt_l=6)then
                        Vcpt_c:=2;
                        Vcpt_l:=1;
                     else
                        Vcpt_c := Vcpt_c + 1;
                        Vcpt_l := Vcpt_l + 1;
                     end if; 
                                                          
                when CHECK_DIAGONALE_G5=>
                     if(Vcpt_c = 6 and Vcpt_l=5)then
                        Vcpt_c:=3;
                        Vcpt_l:=1;
                     else
                        Vcpt_c := Vcpt_c + 1;
                        Vcpt_l := Vcpt_l + 1;
                     end if;
                   
                                  
                when CHECK_DIAGONALE_G6=>
                     if(Vcpt_c = 6 and Vcpt_l=4)then
                        Vcpt_c:=6;
                        Vcpt_l:=3;
                     else
                        Vcpt_c := Vcpt_c + 1;
                        Vcpt_l := Vcpt_l + 1;
                     end if;  
                                               
                when CHECK_DIAGONALE_D1=>
                     if(Vcpt_c = 3 and Vcpt_l=6)then
                        Vcpt_c:=6;
                        Vcpt_l:=2;
                     else
                        Vcpt_c := Vcpt_c - 1;
                        Vcpt_l := Vcpt_l + 1;
                     end if;  
                                                      
                 when CHECK_DIAGONALE_D2=>
                     if(Vcpt_c = 2 and Vcpt_l=6)then
                        Vcpt_c:=6;
                        Vcpt_l:=1;
                     else
                        Vcpt_c := Vcpt_c - 1;
                        Vcpt_l := Vcpt_l + 1;
                     end if;
                                                
                when CHECK_DIAGONALE_D3=>
                     if(Vcpt_c = 1 and Vcpt_l=6)then
                        Vcpt_c:=5;
                        Vcpt_l:=1;
                     else
                        Vcpt_c := Vcpt_c - 1;
                        Vcpt_l := Vcpt_l + 1;
                     end if; 
                                  
                when CHECK_DIAGONALE_D4=>
                     if(Vcpt_c = 0 and Vcpt_l=6)then
                        Vcpt_c:=4;
                        Vcpt_l:=1;
                     else
                        Vcpt_c := Vcpt_c - 1;
                        Vcpt_l := Vcpt_l + 1;
                     end if; 
                                
                when CHECK_DIAGONALE_D5=>
                     if(Vcpt_c = 0 and Vcpt_l=5)then
                        Vcpt_c:=3;
                        Vcpt_l:=1;
                     else
                        Vcpt_c := Vcpt_c - 1;
                        Vcpt_l := Vcpt_l + 1;
                     end if; 
                   
                when CHECK_DIAGONALE_D6=>
                     if(Vcpt_c = 0 and Vcpt_l=4)then
                          Vcpt_c:=0;
                          Vcpt_l:=1;
                     else
                          Vcpt_c := Vcpt_c - 1;
                          Vcpt_l := Vcpt_l + 1;
                     end if; 
                   
                when others=> 
                        Vcpt_c:=0;
                        Vcpt_l:=1;            
               
                    
            end case;
            cpt_c<= std_logic_vector(to_unsigned(Vcpt_c, 8));
            cpt_l<= std_logic_vector(to_unsigned(Vcpt_l, 8));
            cpt_c_1<= cpt_c;
            cpt_l_1<= cpt_l;

         
         end if;
      end if;
    end process cal_output;
    
    
    cal_victoire : process(pr_state,cpt_l_1,cpt_c_1,cpt_piece4_jaune,cpt_piece4_rouge,buf_out_piece4_LC,buf_out_piece3_LC,buf_out_piece2_LC,buf_out_piece1_LC)
    begin
          
            if(pr_state =INIT_STATE_OFF)then
            
                 buf_out_piece1_LC<="0000000000000000";
                 buf_out_piece2_LC<="0000000000000000";
                 buf_out_piece3_LC<="0000000000000000";
                 buf_out_piece4_LC<="0000000000000000";
                 
            else
                   buf_out_piece4_LC(15 downto 8) <=cpt_l_1;
                   buf_out_piece3_LC(15 downto 8) <=buf_out_piece4_LC(15 downto 8);
                   buf_out_piece2_LC(15 downto 8) <=buf_out_piece3_LC(15 downto 8);
                   buf_out_piece1_LC(15 downto 8) <=buf_out_piece2_LC(15 downto 8);
                
                   buf_out_piece4_LC(7 downto 0) <=cpt_c_1;
                   buf_out_piece3_LC(7 downto 0) <=buf_out_piece4_LC(7 downto 0);
                   buf_out_piece2_LC(7 downto 0) <=buf_out_piece3_LC(7 downto 0);
                   buf_out_piece1_LC(7 downto 0) <=buf_out_piece2_LC(7 downto 0);
                
            end if;                   
    end process cal_victoire;
    
    cal_piece : process(cpt_piece4_jaune,cpt_piece4_rouge,buf_out_piece4_LC,buf_out_piece3_LC,buf_out_piece2_LC,buf_out_piece1_LC)
    begin   
            if( cpt_piece4_rouge ="100" or cpt_piece4_jaune ="100")then
                   piece4_LC<=buf_out_piece4_LC;
                   piece3_LC<=buf_out_piece3_LC;
                   piece2_LC<=buf_out_piece2_LC;
                   piece1_LC<=buf_out_piece1_LC;
            else
                   
                   piece1_LC<="0000000000000000";
                   piece2_LC<="0000000000000000";
                   piece3_LC<="0000000000000000";
                   piece4_LC<="0000000000000000";
            end if;                   
    end process cal_piece;
    
    
    cal_piece_victoire : process(pr_state,cpt_piece4_jaune,cpt_piece4_rouge)
    begin
          
            if(pr_state =SEND)then
                    
                     if(cpt_piece4_jaune >="100") then--4
                            out_victoire<="10";
                     elsif(cpt_piece4_rouge >="100")then --4
                            out_victoire<="01"; 
                     else
                            out_victoire<="11";
                     end if;
            else
                 out_victoire<="00";
            end if;                   
    end process cal_piece_victoire;
    
    
    
    cal_nb_piece : process(clk,reset)
    variable cpt_piece_jaune: integer range 0 to 4;
    variable cpt_piece_rouge: integer range 0 to 4;
        begin
                 if ( reset ='1') then
                   cpt_piece_jaune := 0;
                   cpt_piece_rouge := 0;
                 elsif ( clk' event and clk='1') then
                  if(ce = '1') then
                         if( pr_state /=INIT_STATE_ON and pr_state /=INIT_STATE_OFF and pr_state /=SEND)then
                                if(cpt_piece_jaune<4) then
                                   if( in_data="110")then --jaune
                                     
                                        cpt_piece_jaune:=cpt_piece_jaune+ 1;
                                   else
                                      
                                        if(cpt_piece_jaune<4)then
                                            cpt_piece_jaune:=0;
                                        end if;
                                      
                                   end if;
                                end if;
                                if(cpt_piece_rouge<4) then
                                   if( in_data="010")then --rouge
                                        cpt_piece_rouge:=cpt_piece_rouge+1;
                                   else
                                        if(cpt_piece_rouge<4)then
                                            cpt_piece_rouge:=0;
                                        end if;
                                   end if;
                                end if;
                           
                         end if; 
                             cpt_piece4_jaune<= std_logic_vector(to_unsigned(cpt_piece_jaune, 3));
                             cpt_piece4_rouge<= std_logic_vector(to_unsigned(cpt_piece_rouge, 3));
                    end if;
                 end if;
            
            
            
                     
    end process cal_nb_piece;
     addr_grille_c_out <= cpt_c(2 downto 0);
     addr_grille_l_out <= cpt_l(2 downto 0);    
end Behavioral;