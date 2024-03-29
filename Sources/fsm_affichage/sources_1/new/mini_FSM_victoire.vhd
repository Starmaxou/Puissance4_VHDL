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
           en_FSM :in STD_LOGIC;
           out_en_affichage: out STD_LOGIC;
           out_en_cpt: out STD_LOGIC
           );
end mini_FSM_victoire ;

architecture Behavioral of mini_FSM_victoire  is

    type Etat is ( Etat_init, Etat_aff_on,Etat_aff_init, Etat_wait_W_off, Etat_wait_W_on, Etat_en_cpt_on, Etat_en_cpt_off);
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
    
    cal_nx_state : process (pr_state, W_ready, en_FSM)
        begin
            case pr_state is
                    when Etat_init =>
                                if(en_FSM='1')then
                                      nx_state <=Etat_aff_init;
                                else
                                      nx_state <=Etat_init;
                                end if;
                    when Etat_aff_init =>  
                                nx_state <=Etat_aff_on;
                                
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
                                if(en_FSM='1')then
                                      nx_state <=Etat_aff_init;
                                else
                                      nx_state <=Etat_init;
                                end if;
                                   
                                                   
                   end case;
        end process cal_nx_state;
    
    cal_output : process( pr_state)
        begin
            case pr_state is
                when Etat_Init =>
                    out_en_affichage<='0';
                    out_en_cpt<='0';
                  
                when Etat_aff_init =>
                    out_en_affichage<='0';
                    out_en_cpt<='0';
                                                   
                when  Etat_aff_on =>
                    out_en_affichage<='1';
                    out_en_cpt<='0';
                   
                                        
                when  Etat_wait_W_off =>
                    out_en_affichage<='0';
                    out_en_cpt<='0';
                   
                             
                when Etat_wait_W_on =>
                    out_en_affichage<='0';
                    out_en_cpt<='0';
                  
                                                           
                when Etat_en_cpt_on =>
                    out_en_affichage<='0';
                    out_en_cpt<='1';
                   
                    
                when Etat_en_cpt_off =>
                    out_en_affichage<='0';
                    out_en_cpt<='0';
                   
                 
                                                    
            end case;
        end process cal_output;

end Behavioral;