  
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

entity FSM_test_top is
    Port ( CE : in STD_LOGIC;
           H : in STD_LOGIC;
           RST : in STD_LOGIC;
           res_victoire: in std_logic_vector(1 downto 0);
           BP_affiche : in STD_LOGIC;
           BP_victoire : in STD_LOGIC;
           init_verif : out STD_LOGIC;
           en_affichage : out STD_LOGIC;
           SEL_ADDR : out STD_LOGIC
           );
end FSM_test_top;

architecture Behavioral of FSM_test_top is

    type Etat is ( Etat_init, Etat_Affichage,Etat_init_Verif, Etat_Verif );
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
    
    cal_nx_state : process (pr_state,BP_affiche,BP_victoire,res_victoire)
        begin
            case pr_state is
                when Etat_init =>
                        if( BP_affiche='1')then
                             nx_state <= Etat_Affichage;
                        else
                             nx_state <= Etat_init;
                        end if;
                       
                 when Etat_Affichage =>
                        if( BP_victoire='1')then
                             nx_state <= Etat_init_Verif;
                        else
                             nx_state <= Etat_Affichage;
                        end if;
               
                            
                 when Etat_init_Verif=>
                            nx_state <= Etat_Verif;
                 when Etat_Verif=>
                                --if(res_victoire="00")then
                                  nx_state <= Etat_Verif;
                                --else
                                -- nx_state <= Etat_Affichage;
                                --end if;
                              
                    
                  
 
            end case;
        end process cal_nx_state;
    
    cal_output : process( pr_state)
        begin
            case pr_state is
                when Etat_init =>
                     init_verif <='0';
                     en_affichage <='0';
                     SEL_ADDR  <='0';
                       
                when Etat_Affichage =>
                     init_verif <='0';
                     en_affichage <='1';
                     SEL_ADDR  <='0';
                
                when Etat_init_Verif=>
                     init_verif <='1';
                     en_affichage <='0';
                     SEL_ADDR  <='1';
                            
                when Etat_Verif=>
                     init_verif <='0';
                     en_affichage <='0';
                     SEL_ADDR  <='1';
                            
                                                    
            end case;
        end process cal_output;

end Behavioral;