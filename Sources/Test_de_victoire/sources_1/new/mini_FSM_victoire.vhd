----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.02.2021 09:38:01
-- Design Name: 
-- Module Name: FSM - Behavioral
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

entity mini_FSM_victoire is
    Port ( CE : in STD_LOGIC;
           H : in STD_LOGIC;
           RST : in STD_LOGIC;
           W_ready: in STD_LOGIC;
           BP: in STD_LOGIC;
           in_check_victoire :in STD_LOGIC;
           out_en_affichage: out STD_LOGIC;
           out_init_cpt: out STD_LOGIC;
           out_en_cpt: out STD_LOGIC;
           out_en_verif: out STD_LOGIC;
           out_init_verif: out STD_LOGIC;
           sel_ADDR: out STD_LOGIC
           );
end mini_FSM_victoire ;

architecture Behavioral of mini_FSM_victoire  is

    type Etat is ( Etat_init, Etat_init_cpt, Etat_aff_on, Etat_wait_W_off, Etat_wait_W_on, Etat_en_cpt_on, Etat_en_cpt_off,Etat_verif_init, Etat_verif);
	signal pr_state , nx_state : Etat := Etat_init;
	
begin

    maj_etat : process ( H , RST )
    begin
        if (RST ='1') then
            pr_state <= Etat_init ;
        elsif ( H' event and H ='1') then
            if(CE = '1') then
            	pr_state <= nx_state ;
            end if;
        end if;
    end process maj_etat;
    
    cal_nx_state : process (pr_state, W_ready,BP, in_check_victoire)
        begin
            case pr_state is
                    when Etat_init =>
                                if(BP='1')then
                                      nx_state <=Etat_init_cpt;
                                else
                                      nx_state <=Etat_init;
                                end if;
                      
                    when Etat_init_cpt =>
                                 if(BP='0')then
                                      nx_state <=Etat_aff_on;
                                else
                                      nx_state <=Etat_init_cpt;
                                end if;
                                
                    when Etat_aff_on =>  
                                nx_state <= Etat_wait_W_off;
                    when Etat_wait_W_off=>  
                               
                                    if(W_ready='0')then
                                         nx_state <=  Etat_wait_W_on;
                                    else
                                        nx_state <=  Etat_wait_W_off;
                                    end if;
  

                    when Etat_wait_W_on=>
                                if(W_ready='1')then
                                     nx_state <=  Etat_en_cpt_on;
                                else
                                    nx_state <=  Etat_wait_W_on;
                                end if;
                    when Etat_en_cpt_on=> 
                             nx_state <=  Etat_en_cpt_off;
                    when Etat_en_cpt_off=> 
                                if(in_check_victoire='1')then
                                    nx_state <= Etat_verif_init;
                                else
                                     nx_state <= Etat_aff_on;
                                end if;
                    when Etat_verif_init=>  
                              nx_state <=  Etat_verif;
                    when Etat_verif=> 
                              nx_state <=Etat_verif;
                                  
                             
            end case;
        end process cal_nx_state;
    
    cal_output : process( pr_state)
        begin
            case pr_state is
                when Etat_Init =>
                    out_en_affichage<='0';
                    out_init_cpt<='0';
                    out_en_cpt<='0';
                    out_en_verif<='0';
                    out_init_verif<='0';
                    sel_ADDR<='0';
                                    
                when Etat_init_cpt =>
                    out_en_affichage<='0';
                    out_init_cpt<='1';
                    out_en_cpt<='0';
                    out_en_verif<='0';
                    out_init_verif<='0';
                    sel_ADDR<='0';
                    
                when  Etat_aff_on =>
                    out_en_affichage<='1';
                    out_init_cpt<='0';
                    out_en_cpt<='0';
                    out_en_verif<='0';
                    out_init_verif<='0';
                    sel_ADDR<='0';
                                        
                when  Etat_wait_W_off =>
                    out_en_affichage<='0';
                    out_init_cpt<='0';
                    out_en_cpt<='0';
                    out_en_verif<='0';
                    out_init_verif<='0';
                    sel_ADDR<='0';
                             
                when Etat_wait_W_on =>
                    out_en_affichage<='0';
                    out_init_cpt<='0';
                    out_en_cpt<='0';
                    out_en_verif<='0';
                    out_init_verif<='0';
                    sel_ADDR<='0';
                                                           
                when Etat_en_cpt_on =>
                    out_en_affichage<='0';
                    out_init_cpt<='0';
                    out_en_cpt<='1';
                    out_en_verif<='0';
                    out_init_verif<='0';
                    sel_ADDR<='0';
                    
                when Etat_en_cpt_off =>
                    out_en_affichage<='0';
                    out_init_cpt<='0';
                    out_en_cpt<='0';
                    out_en_verif<='0';
                    out_init_verif<='0';
                    sel_ADDR<='0';
                when Etat_verif_init=>  
                    out_en_affichage<='0';
                    out_init_cpt<='0';
                    out_en_cpt<='0';
                    out_en_verif<='1';
                    out_init_verif<='1';
                    sel_ADDR<='1';
                    
                when Etat_verif=> 
                    out_en_affichage<='0';
                    out_init_cpt<='0';
                    out_en_cpt<='0';
                    out_en_verif<='1';
                    out_init_verif<='0';
                    sel_ADDR<='1'; 
                 
                                                    
            end case;
        end process cal_output;

end Behavioral;