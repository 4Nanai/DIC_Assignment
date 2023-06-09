----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2023/06/09 14:53:50
-- Design Name: 
-- Module Name: encoder - Behavioral
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

-- VHDL code for an 8-3 bit encoder with parallel input and output

entity encoder_8_3 is
  port(
    x: in std_logic_vector(7 downto 0); -- input vector
    y: out std_logic_vector(2 downto 0) -- output vector
  );
end entity;

architecture struct of encoder_8_3 is
  -- declare internal signals
  signal s0, s1, s2, s3, s4, s5, s6, s7: std_logic;
  signal t0, t1, t2, t3: std_logic;
begin
  -- use OR gates to generate intermediate signals
  s0 <= x(0) or x(1);
  s1 <= x(2) or x(3);
  s2 <= x(4) or x(5);
  s3 <= x(6) or x(7);
  t0 <= s0 or s1;
  t1 <= s2 or s3;
  t2 <= x(1) or x(3);
  t3 <= x(5) or x(7);
  
  -- use AND gates to generate output signals
  y(0) <= (not t0) and (not t1);
  y(1) <= ((not t0) and t1 and (not t3)) or (t0 and (not t2));
  y(2) <= ((not t0) and t1 and t3) or (t0 and t2);

end architecture;