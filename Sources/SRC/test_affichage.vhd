----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.03.2021 15:06:07
-- Design Name: 
-- Module Name: test_affichage - Behavioral
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

entity test_affichage is
        port( 
            clk: in std_logic;
            Bp1: in std_logic;
            Bp2: in std_logic;
            Bp3: in std_logic;
            Bp4: in std_logic;
            Bp5: in std_logic;
            out_HG: out std_logic_vector(15 downto 0);
            out_BD: out std_logic_vector(15 downto 0);
            out_num_figure: out std_logic_vector( 2 downto 0);
            out_en_affichage_test: out std_logic);
end test_affichage;

architecture Behavioral of test_affichage is
signal flag: std_logic :='0';
  begin
    process (clk)
        begin
            if(clk = '1' and clk'event) then
            
                if(Bp1 ='1' and Bp2 ='0'and Bp3 ='0'and Bp4 ='0' and Bp5 ='0')then
                      out_num_figure<="001";
                      out_HG<=x"2211";
                      out_BD<=x"2B1A";
                elsif(Bp1 ='0' and Bp2 ='1'and Bp3 ='0'and Bp4 ='0' and Bp5 ='0')then
                      out_num_figure<="010";
                      out_HG<=  x"3011";
                      out_BD<= x"391A";
                elsif(Bp1 ='0' and Bp2 ='0'and Bp3 ='1'and Bp4 ='0' and Bp5 ='0')then
                      out_num_figure<="011";
                      out_HG<= x"3E11";
                      out_BD<= x"471A";
                elsif(Bp1 ='0' and Bp2 ='0'and Bp3 ='0'and Bp4 ='1' and Bp5 ='0')then
                      out_num_figure<="100";
                      out_HG<=x"4C11";                
                      out_BD<=x"551A";
                elsif(Bp1 ='0' and Bp2 ='0'and Bp3 ='0'and Bp4 ='0' and Bp5 ='1')then
                     out_num_figure<="000";
                     out_HG<=x"4C11";                
                     out_BD<=x"551A";
                end if;
                
            
            end if;
    end process;
  
   out_en_affichage_test<='0' when (Bp1='0' and Bp2='0' and Bp3='0' and Bp4='0' and Bp5='0') else
                      '1';
                              
                        
end Behavioral;
