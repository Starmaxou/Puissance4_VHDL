----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.03.2021 20:42:28
-- Design Name: 
-- Module Name: Edge_detector - Behavioral
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

entity Edge_detector is
   Port ( 
            
           clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           ce : in STD_LOGIC;
           data_in : in STD_LOGIC;
           data_out : out STD_LOGIC
   
   );
end Edge_detector;

architecture Behavioral of Edge_detector is
signal Q2: std_logic;
signal Q1: std_logic;
signal out_NOT: std_logic;
begin

        bascule_D1 : entity work.bascule_D 
        port map(
                    ce =>'1',
                    clk =>clk,
                    reset=>reset,
                    D=>data_in, 
                    Q=>Q1);  
        bascule_D2 : entity work.bascule_D 
        port map(
                    ce =>'1',
                    clk =>clk,
                    reset=>reset,
                    D=>Q1, 
                    Q=>Q2);  
        out_NOT <=  not(Q2);       
        data_out <= Q1 and out_NOT;
end Behavioral;
