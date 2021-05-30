# ALU-32bit
implemented in VHDL language\
Uses Xilinx ISE\
It Can do 24 functions. It has two 8-bit inputs, A,B. 

# Inputs and functions are:
Clk : one bit std_logic

P: 32 bit std_logic_vector

P(7 downto 0)= A

P(15 downto 8)= B

P(18 downto 16)= logic operation \
000 : and\
001 : or\
010: xor\
011 : nand\
100 : nor\
101 : xnor\
110 : not (A or B :depends on P(28) )

P(21 downto 19) = arithmetic\
000 : A+B\
001 : A-B\
010 : A*B\
011 : +1 (A or B :depends on P(28) )\
100 : -1 (A or B :depends on P(28) )\
101 : A?B (result = agb (A>b), alb (A<B) , aeb (A=B))

P( 24 downto 22) = number of shift\
P( 27 downto 25) = six shift operators\
000 : srl (A or B :depends on P(28) )\
001 : sra (A or B :depends on P(28) )\
010 : ror (A or B :depends on P(28) )\
011 : sll (A or B :depends on P(28) )\
100 : sla (A or B :depends on P(28) )\
101 : rol (A or B :depends on P(28) )

P(28)= select A or B

P(29)= put A on out bas

P(30)= put B on out bas

P(31)= Reset
