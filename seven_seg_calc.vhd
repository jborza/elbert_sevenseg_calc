----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    04:55:31 08/04/2020 
-- Design Name: 
-- Module Name:    seven_seg_calc - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity seven_seg_calc is
    Port ( Clk : in STD_LOGIC;
				DPSwitch : in  STD_LOGIC_VECTOR (7 downto 0);
           SevenSegment : out  STD_LOGIC_VECTOR (7 downto 0);
			  Enable : out STD_LOGIC_VECTOR(2 downto 0);
			  LED : out STD_LOGIC_VECTOR(1 downto 0)
			  ); --7-segment enable bits
end seven_seg_calc;

architecture Behavioral of seven_seg_calc is
COMPONENT seven_seg_3bit
	PORT(
		Number : IN std_logic_vector(2 downto 0);          
		SevenSegment : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;
	COMPONENT seven_seg_4bit
	PORT(
		Number : IN std_logic_vector(3 downto 0);          
		SevenSegment : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;
	COMPONENT seven_seg_driver
	PORT(
		A : IN std_logic_vector(7 downto 0);
		B : IN std_logic_vector(7 downto 0);
		C : IN std_logic_vector(7 downto 0);
		Clk12Mhz : IN std_logic;          
		SevenSegment : OUT std_logic_vector(7 downto 0);
		Enable : OUT std_logic_vector(2 downto 0)
		);
	END COMPONENT;
	
	signal SSeg_A : STD_LOGIC_VECTOR(7 downto 0);
	signal SSeg_B : STD_LOGIC_VECTOR(7 downto 0);
	signal SSeg_Result : STD_LOGIC_VECTOR(7 downto 0);
	constant temp : STD_LOGIC_VECTOR(3 downto 0) := "1111";
	signal result : unsigned(3 downto 0);
	signal number_a : unsigned(3 downto 0);
	signal number_b : unsigned(3 downto 0);
	signal do_add : STD_LOGIC;
begin
	Result_seven_seg_4bit: seven_seg_4bit PORT MAP(
		Number => std_logic_vector(result),
		SevenSegment => SSeg_Result
	);
	A_seven_seg_3bit: seven_seg_3bit PORT MAP(
		Number => not DPSwitch(2 downto 0),
		SevenSegment => SSeg_A
	);
	B_seven_seg_3bit: seven_seg_3bit PORT MAP(
		Number => not DPSwitch(5 downto 3),
		SevenSegment => SSeg_B
	);
	Inst_seven_seg_driver: seven_seg_driver PORT MAP(
		A => SSeg_A,
		B => SSeg_B,
		C => SSeg_Result,
		SevenSegment => SevenSegment,
		Enable => Enable,
		Clk12Mhz => Clk
	);
	
	LED(1) <= not DPSwitch(6);
	
	--add or subtract flag
	do_add <= not DPSwitch(7);
	
	--add or subtract the numbers
	process(Clk)
	begin
		if rising_edge(Clk) then
			number_a <= unsigned(not DPSwitch(2 downto 0));
			number_b <= unsigned(not DPSwitch(5 downto 3));
			if do_add = '1' then
				result <= number_a + number_b;
			else
				result <= number_a - number_b;
			end if;
		end if;
	end process;
end Behavioral;