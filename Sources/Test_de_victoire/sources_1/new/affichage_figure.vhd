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
 TYPE STATE_TYPE IS (WAITING_ON,WAITING_OFF, RUNNING,CHECK);
 SIGNAL cstate : STATE_TYPE;
begin
    process(clk,reset)
    --variable Nb_pixel_HG: integer range 0 to 15999;
    --variable Nb_pixel_BD: integer range 0 to 15999;
    variable Nb_HGL:integer range 0 to 99;
    variable Nb_HGL_cpy:integer range 0 to 99;
    variable Nb_HGC:integer range 0 to 159;
    variable Nb_HGC_cpy:integer range 0 to 159;
    variable Nb_BDL:integer range 0 to 99;
    variable Nb_BDC:integer range 0 to 159;
    variable cpt_c: integer range 0 to 159;
    variable cpt_figure: integer range 0 to 15999;
    variable cpt_l: integer range 0 to 99;
    variable flag: boolean :=false;
    begin
        if(reset = '1') then
            cstate   <= WAITING_ON;
            cpt_l := 0;
            cpt_c := 0;
            cpt_figure := 0;
            --Nb_pixel_HG:= 0;
            --Nb_pixel_BD:=0;
            Nb_HGL:=0;
            Nb_HGC:=0;
            Nb_HGC_cpy:=0;
            Nb_BDL:=0;
            Nb_BDC:=0;
            out_R_W <='0';
            flag:=false;
            out_adr<="00000000000000";
        elsif (clk'event and clk ='1') then
            if (ce = '1') then
                        CASE cstate IS
                    
                            WHEN WAITING_ON =>
                                
                                if( in_affichage_en = '1') then
                                    cstate <= WAITING_OFF;
                                else
                                    cstate <= WAITING_ON;
                                end if;
                              
                             
                            WHEN WAITING_OFF =>
                                 
                                if( in_affichage_en = '0') then
                                
                                        Nb_HGL:=to_integer(unsigned(in_HG(7 downto 0)));
                                        Nb_HGC:=to_integer(unsigned(in_HG(15 downto 8)));
                                        Nb_BDL:=to_integer(unsigned(in_BD(7 downto 0)));
                                        Nb_BDC:=to_integer(unsigned(in_BD(15 downto 8)));
                                     cstate <= CHECK;
                                else
                                     cstate <= WAITING_OFF;
                                end if;
                             WHEN CHECK=>
                                    if(Nb_HGC>Nb_BDC or Nb_HGL>Nb_BDL or Nb_BDC>160 or Nb_HGC>160 or Nb_BDL>100 or Nb_HGL>100 or Nb_BDC<0 or Nb_HGC<0 or Nb_BDL<0 or Nb_HGL<0)then
                                        cstate <=WAITING_ON;
                                    else
                                        cpt_l := 0;
                                        cpt_c := 0;
                                        cpt_figure:=0;
                                        Nb_HGC_cpy:=Nb_HGC;
                                        Nb_HGL_cpy:=Nb_HGL;
                                        cstate <=RUNNING;
                                        out_R_W<='1';
                                    end if;
                             WHEN RUNNING =>
                             cpt_figure:=cpt_figure+1;
                             if(cpt_figure>1)then
                                if(cpt_l = (Nb_BDL-Nb_HGL) and cpt_c=(Nb_BDC-Nb_HGC))then
                                    out_R_W<='0';
                                    cstate <= WAITING_ON;
                                     
                                else
                                     
                                     if(cpt_c=(Nb_BDC-Nb_HGC)) then
                                          cpt_l := cpt_l + 1;
                                          cpt_c:=0;
                                     else
                                          cpt_c := cpt_c + 1;
                                     end if;
                                     cstate <= RUNNING;
                                end if;
                             else
                              cstate <= RUNNING;
                             end if;
                           
                                                                 
                           END CASE;
                           out_adr <= std_logic_vector(to_unsigned( Nb_HGC_cpy+cpt_c+(160*(cpt_l+Nb_HGL_cpy)), 14));
                           out_adr_figure<= std_logic_vector(to_unsigned(cpt_figure,14)); 
            end if;
        end if;
    end process;
end Behavioral;