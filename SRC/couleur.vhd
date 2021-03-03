----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.03.2021 14:22:07
-- Design Name: 
-- Module Name: couleur - Behavioral
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

entity couleur is
    port( 
            BpA: in std_logic;
            BpB: in std_logic;
            BpC: in std_logic;
            dataout: out std_logic_vector (2 downto 0));
end couleur;

architecture Behavioral of couleur is
    begin
       dataout <= "001" when (BpA ='1' and BpB ='0'and BpC ='0') else
       "111" when (BpA ='0' and BpB ='1'and BpC ='0') else
       "100" when (BpA ='0' and BpB ='0'and BpC ='1') else
       "010";
end Behavioral;
