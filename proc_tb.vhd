library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity proc_test is
end entity;

architecture arch of proc_test is
  signal done   : boolean := false;
  signal passed : boolean := true;
  signal ok     : boolean := true;

  component proc is
    port ( clk : in  std_logic;
           rst : in  std_logic;
         
           ram_addr : out std_logic_vector(15 downto 0);
           ram_din  : out std_logic_vector(15 downto 0);
           ram_dout : in  std_logic_vector(15 downto 0);
           ram_we   : out std_logic );
  end component;

  signal clk : std_logic;
  signal rst : std_logic;
  
  signal ram_addr : std_logic_vector(15 downto 0);
  signal ram_din  : std_logic_vector(15 downto 0);
  signal ram_dout : std_logic_vector(15 downto 0);
  signal ram_we   : std_logic;
begin

  proc_0 : proc
    port map ( clk => clk,
               rst => rst,

               ram_addr => ram_addr,
               ram_din  => ram_din,
               ram_dout => ram_dout,
               ram_we   => ram_we );

  -----------------------------------------------------------------------------
  -- Clock signal
  -----------------------------------------------------------------------------

  process
  begin
    if not done then
      clk <= '1';
      wait for 5 ns;
      clk <= '0';
      wait for 5 ns;
    else
      clk <= 'U';
      wait;
    end if;
  end process;

  -----------------------------------------------------------------------------
  -- Input stimuli
  -----------------------------------------------------------------------------

  process
  begin
    -- Reset ------------------------------------------------------------- 0 ns
    rst      <= '1';
    ram_dout <= X"0000";
    wait for 12 ns;
    rst      <= '0';
    -- Instr CE --------------------------------------------------------- 12 ns
    wait for 10 ns;
    -- Instr cond ------------------------------------------------------- 22 ns
    wait for 10 ns;
    -- Instr op --------------------------------------------------------- 32 ns
    wait for 10 ns;
    -- Instr updt ------------------------------------------------------- 42 ns
    wait for 10 ns;
    -- Instr imm -------------------------------------------------------- 52 ns
    wait for 10 ns;
    -- Instr reg -------------------------------------------------------- 62 ns
    wait for 10 ns;
    -- Status CE -------------------------------------------------------- 72 ns
    wait for 10 ns;
    -- Status in -------------------------------------------------------- 82 ns
    wait for 10 ns;
    -- Status out ------------------------------------------------------- 92 ns
    wait for 10 ns;
    -- Accumulator CE -------------------------------------------------- 102 ns
    wait for 10 ns;
    -- Accumulator out ------------------------------------------------- 112 ns
    wait for 10 ns;
    -- Program counter CE ---------------------------------------------- 122 ns
    wait for 10 ns;
    -- Program counter out --------------------------------------------- 132 ns
    wait for 10 ns;
    -- Return program counter CE --------------------------------------- 142 ns
    wait for 10 ns;
    -- Register CE ----------------------------------------------------- 152 ns
    wait for 10 ns;
    -- Register out ---------------------------------------------------- 162 ns
    wait for 10 ns;
    -- RAM WE ---------------------------------------------------------- 172 ns
    wait for 10 ns;
    -- RAM out --------------------------------------------------------- 182 ns
    ram_dout <= X"A5A5";
    wait for 10 ns;
    ram_dout <= X"0000";
    -- Select RAM address [0] ------------------------------------------ 192 ns
    wait for 10 ns;
    -- Select RAM address [1] ------------------------------------------ 202 ns
    wait for 10 ns;
    -- Select operand 1 [0] -------------------------------------------- 212 ns
    wait for 10 ns;
    -- Select operand 1 [1] -------------------------------------------- 222 ns
    wait for 10 ns;
    -- Select register file in [00] ------------------------------------ 232 ns
    wait for 10 ns;
    -- Select register file in [01] ------------------------------------ 242 ns
    ram_dout <= X"4B4B";
    wait for 10 ns;
    ram_dout <= X"0000";
    -- Select register file in [10] ------------------------------------ 252 ns
    wait for 10 ns;
    -------------------------------------------------------------------- 262 ns
    rst      <= 'U';
    ram_dout <= "UUUUUUUUUUUUUUUU";
    wait;
  end process;

  -----------------------------------------------------------------------------
  -- Output verification
  -----------------------------------------------------------------------------

  process
  begin
    wait for 9 ns;
    -- Reset (before clk) ------------------------------------------------ 9 ns
    ok <= (ram_we = '0');
    wait for 2 ns;
    -- Reset (after clk) ------------------------------------------------ 11 ns
    ok <= (ram_we = '0');
    wait for 8 ns;
    -- Instr CE (before clk) -------------------------------------------- 19 ns
    ok <= (ram_we = '0');
    wait for 2 ns;
    -- Instr CE (after clk) --------------------------------------------- 21 ns
    ok <= (ram_we = '0');
    wait for 8 ns;
    -- Instr cond (before clk) ------------------------------------------ 29 ns
    ok <= (ram_we = '0');
    wait for 2 ns;
    -- Instr cond (after clk) ------------------------------------------- 31 ns
    ok <= (ram_we = '0');
    wait for 8 ns;
    -- Instr op (before clk) -------------------------------------------- 39 ns
    ok <= (ram_we = '0');
    wait for 2 ns;
    -- Instr op (after clk) --------------------------------------------- 41 ns
    ok <= (ram_we = '0');
    wait for 8 ns;
    -- Instr updt (before clk) ------------------------------------------ 49 ns
    ok <= (ram_we = '0');
    wait for 2 ns;
    -- Instr updt (after clk) ------------------------------------------- 51 ns
    ok <= (ram_we = '0');
    wait for 8 ns;
    -- Instr imm (before clk) ------------------------------------------- 59 ns
    ok <= (ram_we = '0');
    wait for 2 ns;
    -- Instr imm (after clk) -------------------------------------------- 61 ns
    ok <= (ram_we = '0');
    wait for 8 ns;
    -- Instr reg (before clk) ------------------------------------------- 69 ns
    ok <= (ram_we = '0');
    wait for 2 ns;
    -- Instr reg (after clk) -------------------------------------------- 71 ns
    ok <= (ram_we = '0');
    wait for 8 ns;
    -- Status CE (before clk) ------------------------------------------- 79 ns
    ok <= (ram_we = '0');
    wait for 2 ns;
    -- Status CE (after clk) -------------------------------------------- 81 ns
    ok <= (ram_we = '0');
    wait for 8 ns;
    -- Status in (before clk) ------------------------------------------- 89 ns
    ok <= (ram_we = '0');
    wait for 2 ns;
    -- Status in (after clk) -------------------------------------------- 91 ns
    ok <= (ram_we = '0');
    wait for 8 ns;
    -- Status out (before clk) ------------------------------------------ 99 ns
    ok <= (ram_we = '0');
    wait for 2 ns;
    -- Status out (after clk) ------------------------------------------ 101 ns
    ok <= (ram_we = '0');
    wait for 8 ns;
    -- Accumulator CE (before clk) ------------------------------------- 109 ns
    ok <= (ram_we = '0');
    wait for 2 ns;
    -- Accumulator CE (after clk) -------------------------------------- 111 ns
    ok <= (ram_we = '0');
    wait for 8 ns;
    -- Accumulator out (before clk) ------------------------------------ 119 ns
    ok <= (ram_we = '0');
    wait for 2 ns;
    -- Accumulator out (after clk) ------------------------------------- 121 ns
    ok <= (ram_we = '0');
    wait for 8 ns;
    -- Program counter CE (before clk) --------------------------------- 129 ns
    ok <= (ram_we = '0');
    wait for 2 ns;
    -- Program counter CE (after clk) ---------------------------------- 131 ns
    ok <= (ram_we = '0');
    wait for 8 ns;
    -- Program counter out (before clk) -------------------------------- 139 ns
    ok <= (ram_we = '0');
    wait for 2 ns;
    -- Program counter out (after clk) --------------------------------- 141 ns
    ok <= (ram_we = '0');
    wait for 8 ns;
    -- Return program counter CE (before clk) -------------------------- 149 ns
    ok <= (ram_we = '0');
    wait for 2 ns;
    -- Return program counter CE (after clk) --------------------------- 151 ns
    ok <= (ram_we = '0');
    wait for 8 ns;
    -- Register CE (before clk) ---------------------------------------- 159 ns
    ok <= (ram_we = '0');
    wait for 2 ns;
    -- Register CE (after clk) ----------------------------------------- 161 ns
    ok <= (ram_we = '0');
    wait for 8 ns;
    -- Register out (before clk) --------------------------------------- 169 ns
    ok <= (ram_we = '0');
    wait for 2 ns;
    -- Register out (after clk) ---------------------------------------- 171 ns
    ok <= (ram_we = '0');
    wait for 8 ns;
    -- RAM WE (before clk) --------------------------------------------- 179 ns
    ok <= (ram_we = '1');
    wait for 2 ns;
    -- RAM WE (after clk) ---------------------------------------------- 181 ns
    ok <= (ram_we = '1');
    wait for 8 ns;
    -- RAM out (before clk) -------------------------------------------- 189 ns
    ok <= (ram_we = '0');
    wait for 2 ns;
    -- RAM out (after clk) --------------------------------------------- 191 ns
    ok <= (ram_we = '0');
    wait for 8 ns;
    -- Select RAM address [0] (before clk) ----------------------------- 199 ns
    ok <= (ram_we = '0') and
          (ram_addr = X"5A5A");
    wait for 2 ns;
    -- Select RAM address [0] (after clk) ------------------------------ 201 ns
    ok <= (ram_we = '0') and
          (ram_addr = X"5A5A");
    wait for 8 ns;
    -- Select RAM address [1] (before clk) ----------------------------- 209 ns
    ok <= (ram_we = '0') and
          (ram_addr = X"0000");
    wait for 2 ns;
    -- Select RAM address [1] (after clk) ------------------------------ 211 ns
    ok <= (ram_we = '0') and
          (ram_addr = X"A5A5");
    wait for 8 ns;
    -- Select operand 1 [0] (before clk) ------------------------------- 219 ns
    ok <= (ram_we = '0');
    wait for 2 ns;
    -- Select operand 1 [0] (after clk) -------------------------------- 221 ns
    ok <= (ram_we = '0');
    wait for 8 ns;
    -- Select operand 1 [1] (before clk) ------------------------------- 229 ns
    ok <= (ram_we = '0');
    wait for 2 ns;
    -- Select operand 1 [1] (after clk) -------------------------------- 231 ns
    ok <= (ram_we = '0');
    wait for 8 ns;
    -- Select register file in [00] (before clk) ----------------------- 239 ns
    ok <= (ram_we = '0');
    wait for 2 ns;
    -- Select register file in [00] (after clk) ------------------------ 241 ns
    ok <= (ram_we = '0');
    wait for 8 ns;
    -- Select register file in [01] (before clk) ----------------------- 249 ns
    ok <= (ram_we = '0');
    wait for 2 ns;
    -- Select register file in [01] (after clk) ------------------------ 251 ns
    ok <= (ram_we = '0');
    wait for 8 ns;
    -- Select register file in [10] (before clk) ----------------------- 259 ns
    ok <= (ram_we = '0');
    wait for 2 ns;
    -- Select register file in [10] (after clk) ------------------------ 261 ns
    ok <= (ram_we = '0');
    wait for 1 ns;
    -------------------------------------------------------------------- 262 ns
    ok   <= true;
    done <= true;
    wait;
  end process;

  passed <= passed and ok;
  
end architecture;
