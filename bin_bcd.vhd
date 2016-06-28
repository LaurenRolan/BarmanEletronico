library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.numeric_std.all;


entity bin_bcd is
    Port
    (
    	--entrada
    	binIN : in  STD_LOGIC_VECTOR (15 downto 0);
    	
    	--saída para o display de sete segmentos
        ones : out  STD_LOGIC_VECTOR (6 downto 0);
        tens : out  STD_LOGIC_VECTOR (6 downto 0);
        hundreds : out  STD_LOGIC_VECTOR (6 downto 0);
        thousands : out  STD_LOGIC_VECTOR (6 downto 0)
    );
end bin_bcd;

architecture Behavioral of bin_bcd is
  --signal bcd : STD_LOGIC_VECTOR (15 downto 0) := "0000000000000000";
  signal prim: STD_LOGIC_VECTOR (3 downto 0) := "0000";
  signal sec: STD_LOGIC_VECTOR (3 downto 0) := "0000";
  signal ter: STD_LOGIC_VECTOR (3 downto 0) := "0000";
  signal qua: STD_LOGIC_VECTOR (3 downto 0) := "0000";
 
begin
	
bcd1: process(binIN)

  -- temporary variable
  variable temp : STD_LOGIC_VECTOR (15 downto 0);
  variable bcd : STD_LOGIC_VECTOR (15 downto 0) := (others => '0');
  
  -- variable to store the output BCD number
  -- organized as follows
  -- thousands = bcd(15 downto 12)
  -- hundreds = bcd(11 downto 8)
  -- tens = bcd(7 downto 4)
  -- units = bcd(3 downto 0)

  -- by
  -- https://en.wikipedia.org/wiki/Double_dabble
  
  begin
    -- zero the bcd variable
    bcd := (others => '0');
    
    -- read input into temp variable
    temp(15 downto 0) := binIN;
    
    -- cycle 12 times as we have 12 input bits
    -- this could be optimized, we dont need to check and add 3 for the 
    -- first 3 iterations as the number can never be >4
    for i in 0 to 15 loop
    
      if bcd(3 downto 0) > 4 then 
        bcd(3 downto 0) := bcd(3 downto 0) + 3;
      end if;
      
      if bcd(7 downto 4) > 4 then 
        bcd(7 downto 4) := bcd(7 downto 4) + 3;
      end if;
    
      if bcd(11 downto 8) > 4 then  
        bcd(11 downto 8) := bcd(11 downto 8) + 3;
      end if;
		
		if bcd(15 downto 12) > 4 then
			bcd(15 downto 12) := bcd(15 downto 12) + 3;
		end if;
        
      -- shift bcd left by 1 bit, copy MSB of temp into LSB of bcd
      bcd := bcd(14 downto 0) & temp(15);
    
      -- shift temp left by 1 bit
      temp := temp(14 downto 0) & '0';
    
    end loop;
 
    -- set outputs
    prim <= bcd(3 downto 0);
	 sec <= bcd(7 downto 4);
	 ter <= bcd (11 downto 8);
	 qua <= bcd (15 downto 12);
  
  end process bcd1;            
    S1: entity work.bcd_seven port map(prim, ones);
    S2: entity work.bcd_seven port map(sec, tens);
    S3: entity work.bcd_seven port map(ter, hundreds);
    S4: entity work.bcd_seven port map(qua, thousands); 
end Behavioral;