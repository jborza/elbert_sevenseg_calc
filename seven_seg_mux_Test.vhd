--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:26:16 08/04/2020
-- Design Name:   
-- Module Name:   E:/projects/fpga/elbert_7seg/seven_seg_mux_Test.vhd
-- Project Name:  elbert_7seg
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: seven_seg_mux
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY seven_seg_mux_Test IS
END seven_seg_mux_Test;
 
ARCHITECTURE behavior OF seven_seg_mux_Test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT seven_seg_mux
    PORT(
         A : IN  std_logic_vector(7 downto 0);
         B : IN  std_logic_vector(7 downto 0);
         C : IN  std_logic_vector(7 downto 0);
         SevenSegment : OUT  std_logic_vector(7 downto 0);
         Enable : OUT  std_logic_vector(2 downto 0);
         Clk : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(7 downto 0) := "11111111";
   signal B : std_logic_vector(7 downto 0) := "00000000";
   signal C : std_logic_vector(7 downto 0) := "10101010";
   signal Clk : std_logic := '0';

 	--Outputs
   signal SevenSegment : std_logic_vector(7 downto 0);
   signal Enable : std_logic_vector(2 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: seven_seg_mux PORT MAP (
          A => A,
          B => B,
          C => C,
          SevenSegment => SevenSegment,
          Enable => Enable,
          Clk => Clk
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for Clk_period*10;

      -- insert stimulus here 
		
      wait;
   end process;

END;
