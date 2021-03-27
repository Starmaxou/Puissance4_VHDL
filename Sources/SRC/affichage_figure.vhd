----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.03.2021 13:36:07
-- Design Name: 
-- Module Name: affichage_figure - Behavioral
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

entity affichage_figure is
    port (
            ce : in std_logic;
            clk : in std_logic;
            reset : in std_logic;
            in_HG : in std_logic_vector(15 downto 0);
            in_BD : in std_logic_vector(15 downto 0);
            in_affichage_en : in STD_LOGIC;
            out_adr : out std_logic_vector(13 downto 0);
            out_adr_figure : out std_logic_vector(13 downto 0);
            out_R_W: out std_logic
    );
end affichage_figure;

architecture Behavioral of affichage_figure is
    type Etat is ( WAITING_ON,WAITING_OFF, RUNNING,CHECK);
    signal pr_state , nx_state : Etat := WAITING_ON;
    signal S_Nb_HGL:STD_LOGIC_VECTOR (7 downto 0); --max 99
    signal S_Nb_HGC:STD_LOGIC_VECTOR (7 downto 0);--max 159
    signal S_Nb_BDL:STD_LOGIC_VECTOR (7 downto 0); --max 99
    signal S_Nb_BDC:STD_LOGIC_VECTOR (7 downto 0);--max 159
  
    signal S_cpt_L_screen:STD_LOGIC_VECTOR (7 downto 0);--max 99
    signal S_cpt_C_screen:STD_LOGIC_VECTOR (7 downto 0);--max 159
    signal S_End_L_screen:STD_LOGIC_VECTOR (7 downto 0);--max 99
    signal S_End_C_screen:STD_LOGIC_VECTOR (7 downto 0);--max 159
    signal out_adr_figure_tmp :  std_logic_vector(13 downto 0);
    signal out_adr_tmp :  std_logic_vector(13 downto 0);
begin

        maj_etat : process ( clk , reset )
        begin
            if (reset  ='1') then
                pr_state <= WAITING_ON ;
            elsif ( clk' event and clk ='1') then
                if(CE = '1') then
                    pr_state <= nx_state ;
                end if;
            end if;
        end process maj_etat;


       cal_nx_state : process (pr_state,in_affichage_en,S_Nb_HGL,S_Nb_HGC,S_Nb_BDL,S_Nb_BDC,S_cpt_L_screen,S_cpt_C_screen,S_End_L_screen,S_End_C_screen)
        begin
            case pr_state is
                   
                         WHEN WAITING_ON =>  
                                if( in_affichage_en = '1') then
                                    nx_state <= WAITING_OFF;
                                else
                                    nx_state <= WAITING_ON;
                                end if;  
                          
                         WHEN WAITING_OFF =>
                                if( in_affichage_en = '0') then
                                     nx_state <= CHECK;
                                else
                                     nx_state <= WAITING_OFF;
                                end if;   
                         WHEN CHECK=>
                                    if(S_Nb_HGC>S_Nb_BDC or S_Nb_HGL>S_Nb_BDL or S_Nb_BDC>X"A0" or S_Nb_HGC>X"A0" or S_Nb_BDL>X"64" or S_Nb_HGL>X"64" or S_Nb_BDC<X"00" or S_Nb_HGC<X"00"  or S_Nb_BDL<X"00"  or S_Nb_HGL<X"00")then
                                        nx_state <=WAITING_ON;
                                    else
                                        nx_state <=RUNNING;
                                    end if;
                         
                         WHEN RUNNING =>
                               -- if(S_cpt_L_screen = (S_Nb_BDL-S_Nb_HGL) and S_cpt_C_screen=(S_Nb_BDC-S_Nb_HGC))then
                               if(S_cpt_L_screen = S_End_L_screen and S_cpt_C_screen= S_End_C_screen)then    
                                    nx_state <= WAITING_ON;
                                end if;
            end case;
        end process cal_nx_state;
        
        cal_output : process( pr_state,clk)
        variable Nb_HGL:integer range 0 to 99;
        variable Nb_HGL_cpy:integer range 0 to 99;
        variable Nb_HGC:integer range 0 to 159;
        variable Nb_HGC_cpy:integer range 0 to 159;
        variable Nb_BDL:integer range 0 to 99;
        variable Nb_BDC:integer range 0 to 159;
        variable cpt_c: integer range 0 to 159;
        variable cpt_figure: integer range 0 to 15999;
        variable cpt_l: integer range 0 to 99;
        begin
          if( clk' event and clk='1')then
            case pr_state is
                         WHEN WAITING_ON =>  
                         
                                    cpt_l := 0;
                                    cpt_c := 0;
                                    cpt_figure := 0;
                                    Nb_HGL:=0;
                                    Nb_HGC:=0;
                                    Nb_HGC_cpy:=0;
                                    Nb_HGL_cpy:=0;
                                    Nb_BDL:=0;
                                    Nb_BDC:=0;
                                    out_R_W <='0';
                                    out_adr<="00000000000000";
                                    out_adr_figure<="00000000000000";
                         WHEN WAITING_OFF =>
                                    Nb_HGL:=to_integer(unsigned(in_HG(7 downto 0)));
                                    Nb_HGC:=to_integer(unsigned(in_HG(15 downto 8)));
                                    Nb_BDL:=to_integer(unsigned(in_BD(7 downto 0)));
                                    Nb_BDC:=to_integer(unsigned(in_BD(15 downto 8)));
                                    out_R_W <='0';
                                    out_adr<="00000000000000";
                                    out_adr_figure<="00000000000000";
                         WHEN CHECK=>
                                    out_R_W <='0';      
                                    out_adr<="00000000000000";
                                    out_adr_figure<="00000000000000";                 
                         WHEN RUNNING =>
                                    
                                    out_R_W <='1';    
                                    out_adr<= std_logic_vector(to_unsigned( Nb_HGC+cpt_c+(160*(cpt_l+Nb_HGL)), 14));
                                    out_adr_figure<= std_logic_vector(to_unsigned(cpt_figure,14)); 
                                    cpt_figure:=cpt_figure+1;
                                    --if(cpt_figure>1)then
                                        if(cpt_l = (Nb_BDL-Nb_HGL) and cpt_c=(Nb_BDC-Nb_HGC))then
                                            cpt_c:=0;
                                            cpt_l:=0; 
                                            cpt_figure:=0;   
                                          
                                             
                                        else
                                             if(cpt_c=(Nb_BDC-Nb_HGC)) then
                                                  cpt_l := cpt_l + 1;
                                                  cpt_c:=0;
                                             else
                                                  cpt_c := cpt_c + 1;
                                             end if;
                                        end if;   
                                   -- end if;
                                  
                                  
                                    
            end case;
            
            -- out_adr_figure<= std_logic_vector(to_unsigned(cpt_figure,14)); 
             S_Nb_HGL <= std_logic_vector(to_unsigned(Nb_HGL,8)); 
             S_Nb_HGC <= std_logic_vector(to_unsigned(Nb_HGC,8)); 
             S_Nb_BDL <= std_logic_vector(to_unsigned(Nb_BDL,8)); 
             S_Nb_BDC <= std_logic_vector(to_unsigned(Nb_BDC,8)); 
             S_cpt_L_screen<= std_logic_vector(to_unsigned( cpt_l,8)); 
             S_cpt_C_screen<= std_logic_vector(to_unsigned( cpt_c,8)); 
             S_End_L_screen<= std_logic_vector(to_unsigned( Nb_BDL-Nb_HGL,8)); 
             S_End_C_screen<= std_logic_vector(to_unsigned( Nb_BDC-Nb_HGC,8)); 
          end if; 
        end process cal_output;
end Behavioral;