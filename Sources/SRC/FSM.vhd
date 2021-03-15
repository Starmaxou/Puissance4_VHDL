----------------------------------------------------------------------------------
-- Company: ENSEIRB-MATMECA
-- Engineer: Maxime ALBERTY
-- 
-- Create Date: 24.02.2021 09:38:01
-- Design Name: 
-- Module Name: FSM - Behavioral
-- Project Name: Puissance4_VHDL 
-- Target Devices: xc7a50tcsg324-1
-- Tool Versions: 
-- Description: Machine d'état du projet VHDL Puissance4
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

entity FSM is
    Port ( CE : in STD_LOGIC;
           H : in STD_LOGIC;
           RST : in STD_LOGIC);
end FSM;

architecture Behavioral of FSM is

    type Etat is ( Etat_init, Etat_Rouge, Etat_Jaune, Etat_Test_Jeu, Etat_Affichage, Etat_Test_Victoire, Etat_Affichage_Victoire, Etat_Victoire);
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
    
    cal_nx_state : process (pr_state)
        begin
            case pr_state is
                when Etat_Init =>
                    nx_state <= Etat_Rouge;
                when Etat_Rouge =>
                    
                when Etat_Jaune =>
                    
                when Etat_Test_Jeu =>
                    
                when Etat_Affichage =>
                    
                when Etat_Test_Victoire =>
                    
                when Etat_Affichage_Victoire =>
                    
                when Etat_Victoire =>
                    
                when others =>
                    nx_state <= Etat_init;
            end case;
        end process cal_nx_state;
    
    cal_output : process( pr_state, code_op, carry )
        begin
            case pr_state is
                when Etat_Init =>
                    
                when Etat_Rouge =>
                    
                when Etat_Jaune =>
                    
                when Etat_Test_Jeu =>
                    
                when Etat_Affichage =>
                    
                when Etat_Test_Victoire =>
                    
                when Etat_Affichage_Victoire =>
                    
                when Etat_Victoire =>
                                                                                      
            end case;
        end process cal_output;

end Behavioral;
