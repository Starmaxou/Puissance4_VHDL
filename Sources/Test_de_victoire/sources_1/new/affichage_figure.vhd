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
   
begin

       

        
        cal_output : process( reset,clk)
        variable Nb_HGL:integer range 0 to 99;
        variable Nb_HGC:integer range 0 to 159;
        variable Nb_BDL:integer range 0 to 99;
        variable Nb_BDC:integer range 0 to 159;
        variable cpt_c: integer range 0 to 159;
        variable cpt_figure: integer range 0 to 15999;
        variable cpt_l: integer range 0 to 99;
        variable flag: boolean :=false;
        variable flag2: boolean :=false;
        begin
          if(reset='1')then
            cpt_l := 0;
            cpt_c := 0;
            cpt_figure := 0;
            Nb_HGL:=0;
            Nb_HGC:=0;
            Nb_BDL:=0;
            Nb_BDC:=0;
            out_R_W <='0';
            out_adr<="00000000000000";
            out_adr_figure<="00000000000000";
            flag:=false;
            flag:=false;
          elsif ( clk' event and clk='1')then
            if(ce='1')then
                    if(in_affichage_en = '1') then    
                        Nb_HGL:=to_integer(unsigned(in_HG(7 downto 0)));
                        Nb_HGC:=to_integer(unsigned(in_HG(15 downto 8)));
                        Nb_BDL:=to_integer(unsigned(in_BD(7 downto 0)));
                        Nb_BDC:=to_integer(unsigned(in_BD(15 downto 8)));
                        cpt_c:=0;
                        cpt_l:=0; 
                        cpt_figure:=0;   
                        out_R_W<='0'; 
                        flag:=false;  
                        flag2:=false;        
                     elsif( flag=false)then
                          out_R_W<='1'; 
                          if(flag2=true)then
                              cpt_figure:=cpt_figure+1;
                              if(cpt_l = (Nb_BDL-Nb_HGL) and cpt_c=(Nb_BDC-Nb_HGC))then
                                    cpt_c:=0;
                                    cpt_l:=0; 
                                    cpt_figure:=0;  
                                    out_R_W<='0';    
                                    flag:=true;
                                else
                                     if(cpt_c=(Nb_BDC-Nb_HGC)) then
                                          cpt_l := cpt_l + 1;
                                          cpt_c:=0;
                                     else
                                          cpt_c := cpt_c + 1;
                                     end if;
                                end if; 
                          end if;
                          flag2:=true;
                     end if;         
                                      
               end if;
          end if; 
                            out_adr<= std_logic_vector(to_unsigned( Nb_HGC+cpt_c+(160*(cpt_l+Nb_HGL)), 14));
                            out_adr_figure<= std_logic_vector(to_unsigned(cpt_figure,14));         
        end process cal_output;
end Behavioral;