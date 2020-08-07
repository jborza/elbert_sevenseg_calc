----------------------------------------------------------------------------------
--Displays a 3-bit number on the seven-segment display
-- 7 segment configuration
--        1    
--      ____
--   6 |    | 2
--     |_7__| 
--   5 |    | 3
--     |____| .0
--       4
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity seven_seg_3bit is
    Port ( Number : in  STD_LOGIC_VECTOR (2 downto 0);
			  SevenSegment : out  STD_LOGIC_VECTOR (7 downto 0));
end seven_seg_3bit;

architecture Behavioral of seven_seg_3bit is
	
begin
	with Number select
		SevenSegment(7 downto 1) <=
			"0000001" when "000", --0
			"1001111" when "001", --1
			"0010010" when "010", --2
			"0000110" when "011", --3
			"1001100" when "100", --4
			"0100100" when "101", --5
			"0100000" when "110", --6
			"0001111" when others; --7
		SevenSegment(0) <= '1'; --decimal point
end Behavioral;

