----------------------------------------------------------------------------------
-- Engineer: parsa khorrami
-- 
-- Create Date:    14:08:34 02/12/2020 
-- Design Name: 32bit
-- Module Name:    p32 - Behavioral 

----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;






--32 bit
entity p32 is
port ( p :in std_logic_vector(31 downto 0); clk: in std_logic;
		 r : out std_logic_vector(15 downto 0);
		 agb: out std_logic;
		 aeb: out std_logic;
		 alb: out std_logic);
		 
end p32;

architecture Behavioral of p32 is

begin
p0: process (clk) is 

variable a: std_logic_vector(7 downto 0);
variable b: std_logic_vector(7 downto 0);
variable q: std_logic_vector(15 downto 0);
variable z16:std_logic_vector(15 downto 0):= "0000000000000000";
variable z8:std_logic_vector(7 downto 0):= "00000000";
variable shift: std_logic_vector(2 downto 0);


begin 
a:=p(7)&p(6)&p(5)&p(4)&p(3)&p(2)&p(1)&p(0);
b:=p(15)&p(14)&p(13)&p(12)&p(11)&p(10)&p(9)&p(8);
shift:=p(24)&p(23)&p(22);

--reset
if (p(31)='1') then 
q:= z16;
agb <= '0';
aeb <= '0';
alb <= '0';

--b
elsif (p(30)='1') then
q:= z8&b;

--a
elsif (p(29)='1') then
q:= z8&a;

--logic 
--and
elsif ((p(18)='0')and(p(17)='0')and(p(16)='0')) then
q:= (z8&a) and (z8&b);

--or
elsif ((p(18)='0')and(p(17)='0')and(p(16)='1')) then
q:= (z8&a) or (z8&b);

--xor
elsif ((p(18)='0')and(p(17)='1')and(p(16)='0')) then
q:= z8&(a xor b);

--nand
elsif ((p(18)='0')and(p(17)='1')and(p(16)='1')) then
q:= z8&(a nand b);

--nor
elsif ((p(18)='1')and(p(17)='0')and(p(16)='0')) then
q:= z8&(a nor b);

--xor
elsif ((p(18)='1')and(p(17)='0')and(p(16)='1')) then
q:= z8&(a xnor b);

--not
elsif ((p(18)='1')and(p(17)='1')and(p(16)='0')) then
--nota
	if (p(28)='0')then
	q:= z8&(not a);
--notb
	elsif (p(28)='1')then
	q:= z8&(not b);
	end if;
	
--math
-- +
elsif ((p(21)='0')and(p(20)='0')and(p(19)='0')) then
q := std_logic_vector(unsigned(z8 & a) + unsigned(z8 & b));

-- -
elsif ((p(21)='0')and(p(20)='0')and(p(19)='1')) then
q := std_logic_vector(unsigned(z8 & a) - unsigned(z8 & b));

-- *
elsif ((p(21)='0')and(p(20)='1')and(p(19)='0')) then
q := std_logic_vector(unsigned( a) * unsigned( b));

-- +1
elsif ((p(21)='0')and(p(20)='1')and(p(19)='1')) then 
-- a+1
	if (p(28)='0')then
	q := std_logic_vector(unsigned(z8 & a) + 1);
	elsif (p(28)='1')then
-- b+1
	q :=  std_logic_vector(unsigned(z8& b) + 1);
	end if;

-- -1	
elsif ((p(21)='1')and(p(20)='0')and(p(19)='0')) then
-- a-1
	if (p(28)='0')then
	q := std_logic_vector(unsigned(z8&a) - 1);
-- b-1
	elsif (p(28)='1')then
	q := std_logic_vector(unsigned(z8& b) - 1)																																																																								;
	end if;

-- a?b	
elsif ((p(21)='1')and(p(20)='0')and(p(19)='1')) then
	if (a > b)then
	agb<='1'; 
	alb<='0';
	aeb<='0';
	elsif (a < b)then
	agb<='0'; 
	alb<='1';
	aeb<='0';
	elsif (a = b)then
	agb<='0'; 
	alb<='0';
	aeb<='1';
	end if;

--shift
--srl
elsif ((p(27)='0')and(p(26)='0')and(p(25)='0')) then
--srl a
	if (p(28)='0')then
	q := z8& (std_logic_vector(unsigned(a) srl to_integer(unsigned(shift))));
	elsif (p(28)='1')then
--srlb
	q := z8& (std_logic_vector(unsigned(b) srl to_integer(unsigned(shift))));
	end if;

--sra
elsif ((p(27)='0')and(p(26)='0')and(p(25)='1')) then
--sra a
	if (p(28)='0')then
		if (p(7)='0')then
		q := z8& (std_logic_vector(unsigned(a) srl to_integer(unsigned(shift))));
		elsif (p(7)='1')then
			if (shift="000") then
			q:= z8 & a;
			elsif (shift="001") then
			q:= z8 & a(7)&a(7)&a(5)& a(4)&a(3)&a(2)&a(1)&a(0);
			elsif (shift="010") then
			q:= z8 & a(7)&a(7)&a(7)& a(4)&a(3)&a(2)&a(1)&a(0);
			elsif (shift="011") then
			q:= z8 & a(7)&a(7)&a(7)& a(7)&a(3)&a(2)&a(1)&a(0);
			elsif (shift="100") then
			q:= z8 & a(7)&a(7)&a(7)& a(7)&a(7)&a(2)&a(1)&a(0);
			elsif (shift="101") then
			q:= z8 & a(7)&a(7)&a(7)& a(7)&a(7)&a(7)&a(1)&a(0);
			elsif (shift="110") then
			q:= z8 & a(7)&a(7)&a(7)& a(7)&a(7)&a(7)&a(7)&a(0);
			elsif (shift="111") then
			q:= z8 & a(7)&a(7)&a(7)& a(7)&a(7)&a(7)&a(7)&a(7);
			end if;
		end if;
--sra b
	elsif (p(28)='1')then
		if (p(15)='0')then
		q := z8& (std_logic_vector(unsigned(b) srl to_integer(unsigned(shift))));
		elsif (p(15)='1')then
			if (shift="000") then
			q:= z8 & b;
			elsif (shift="001") then
			q:= z8 & b(7)&b(7)&b(5)& b(4)&b(3)&b(2)&b(1)&b(0);
			elsif (shift="010") then
			q:= z8 & b(7)&b(7)&b(7)& b(4)&b(3)&b(2)&b(1)&b(0);
			elsif (shift="011") then
			q:= z8 & b(7)&b(7)&b(7)& b(7)&b(3)&b(2)&b(1)&b(0);
			elsif (shift="100") then
			q:= z8 & b(7)&b(7)&b(7)& b(7)&b(7)&b(2)&b(1)&b(0);
			elsif (shift="101") then
			q:= z8 & b(7)&b(7)&b(7)& b(7)&b(7)&b(7)&b(1)&b(0);
			elsif (shift="110") then
			q:= z8 & b(7)&b(7)&b(7)& b(7)&b(7)&b(7)&b(7)&b(0);
			elsif (shift="111") then
			q:= z8 & b(7)&b(7)&b(7)& b(7)&b(7)&b(7)&b(7)&b(7);
			end if;
		end if;
	end if;	
--ror
elsif ((p(27)='0')and(p(26)='1')and(p(25)='0')) then
--ror a
	if (p(28)='0')then
	q := z8& (std_logic_vector(unsigned(a) ror to_integer(unsigned(shift))));
--ror b
	elsif (p(28)='1')then
	q := z8& (std_logic_vector(unsigned(b) ror to_integer(unsigned(shift))));
	end if;

--sll	
elsif ((p(28)='0')and(p(26)='1')and(p(25)='1')) then
--sll a
	if (p(28)='0')then
	q := z8& (std_logic_vector(unsigned(a) sll to_integer(unsigned(shift))));
--sll b
	elsif (p(28)='1')then
	q := z8& (std_logic_vector(unsigned(b) sll to_integer(unsigned(shift))));
	end if;

--sla
elsif ((p(28)='1')and(p(26)='0')and(p(25)='0')) then
--sla a
	if (p(28)='0')then
	
		if (p(0)='0')then
		q := z8& (std_logic_vector(unsigned(a) sll to_integer(unsigned(shift))));
		elsif (p(0)='1')then
			if (shift="000") then
			q:= z8 & a;
			elsif (shift="001") then
			q:= z8 & a(6)&a(5)&a(4)& a(3)&a(2)&a(1)&a(0)&a(0);
			elsif (shift="010") then
			q:= z8 & a(5)&a(4)&a(3)& a(2)&a(1)&a(0)&a(0)&a(0);
			elsif (shift="011") then
			q:= z8 & a(4)&a(3)&a(2)& a(1)&a(0)&a(0)&a(0)&a(0);
			elsif (shift="100") then
			q:= z8 & a(3)&a(2)&a(1)& a(0)&a(0)&a(0)&a(0)&a(0);
			elsif (shift="101") then
			q:= z8 & a(2)&a(1)&a(0)& a(0)&a(0)&a(0)&a(0)&a(0);
			elsif (shift="110") then
			q:= z8 & a(1)&a(0)&a(0)& a(0)&a(0)&a(0)&a(0)&a(0);
			elsif (shift="111") then
			q:= z8 & a(0)&a(0)&a(0)& a(0)&a(0)&a(0)&a(0)&a(0);
			end if;
		end if;
--sla b
	elsif (p(28)='1')then
	if (p(8)='0')then
		q := z8& (std_logic_vector(unsigned(b) sll to_integer(unsigned(shift))));
		elsif (p(8)='1')then
		
			if (shift="000") then
			q:= z8 & b;
			elsif (shift="001") then
			q:= z8 & b(6)&b(5)&b(4)& b(3)&b(2)&b(1)&b(0)&b(0);
			elsif (shift="010") then
			q:= z8 & b(5)&b(4)&b(3)& b(2)&b(1)&b(0)&b(0)&b(0);
			elsif (shift="011") then
			q:= z8 & b(4)&b(3)&b(2)& b(1)&b(0)&b(0)&b(0)&b(0);
			elsif (shift="100") then
			q:= z8 & b(3)&b(2)&b(1)& b(0)&b(0)&b(0)&b(0)&b(0);
			elsif (shift="101") then
			q:= z8 & b(2)&b(1)&b(0)& b(0)&b(0)&b(0)&b(0)&b(0);
			elsif (shift="110") then
			q:= z8 & b(1)&b(0)&b(0)& b(0)&b(0)&b(0)&b(0)&b(0);
			elsif (shift="111") then
			q:= z8 & b(0)&b(0)&b(0)& b(0)&b(0)&b(0)&b(0)&b(0);
			end if;
			
		end if;
	end if;

--rol
elsif ((p(27)='1')and(p(26)='0')and(p(25)='1')) then
--rol a
	if (p(28)='0')then
	q := z8& (std_logic_vector(unsigned(a) rol to_integer(unsigned(shift))));
--rol b
	elsif (p(28)='1')then
	q := z8& (std_logic_vector(unsigned(b) rol to_integer(unsigned(shift))));
	end if;

end if;
r<=q;

end process p0;


end Behavioral;

