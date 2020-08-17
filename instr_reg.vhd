library ieee;
use ieee.std_logic_1164.all;
entity instr_reg is
	port (
		clk : in std_logic;
		ce : in std_logic;
		rst : in std_logic;
		instr : in std_logic_vector(15 downto 0);
		cond : out std_logic_vector(3 downto 0);
		op : out std_logic_vector(3 downto 0);
		updt : out std_logic;
		imm : out std_logic;
		val : out std_logic_vector(5 downto 0) 
	);
end entity;
architecture arch of instr_reg is
begin
	process (clk, rst)
	begin
		if (rst = '1') then
			cond <= "0000";
			op <= "0000";
			updt <= '0';
			imm <= '0';
			val <= "000000";
		elsif (rising_edge(clk)) then
			if(ce = '1') then
				cond <= instr(15 downto 12);
				op <= instr(11 downto 8);
				updt <= instr(7);
				imm <= instr(6);
				val <= instr(5 downto 0);
			end if;
		end if;
	end process;
end architecture;