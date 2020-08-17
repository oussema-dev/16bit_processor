library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity instr_reg_test is
end entity;

architecture arch of instr_reg_test is
  signal done   : boolean := false;
  signal passed : boolean := true;
  signal ok     : boolean := true;

  component instr_reg is
   port ( clk : in  std_logic;
          ce  : in  std_logic;
          rst : in  std_logic;

          instr : in  std_logic_vector(15 downto 0);
          cond  : out std_logic_vector(3 downto 0);
          op    : out std_logic_vector(3 downto 0);
          updt  : out std_logic;
          imm   : out std_logic;
          val   : out std_logic_vector(5 downto 0) );
  end component;

  signal clk : std_logic;
  signal ce  : std_logic;
  signal rst : std_logic;
  
  signal instr : std_logic_vector(15 downto 0);
  signal cond  : std_logic_vector(3 downto 0);
  signal op    : std_logic_vector(3 downto 0);
  signal updt  : std_logic;
  signal imm   : std_logic;
  signal val   : std_logic_vector(5 downto 0);
begin

  instr_reg_0 : instr_reg
    port map ( clk => clk,
               ce  => ce,
               rst => rst,

               instr => instr,
               cond  => cond,
               op    => op,
               updt  => updt,
               imm   => imm,
               val   => val );

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
    ce    <= '1';
    rst   <= '1';
    instr <= X"FFFF";
    wait for 12 ns;
    -- Clock enabled ---------------------------------------------------- 12 ns
    ce    <= '1';
    rst   <= '0';
    instr <= X"5AA5";
    wait for 10 ns;
    -- Clock disabled --------------------------------------------------- 22 ns
    ce    <= '0';
    rst   <= '0';
    instr <= X"FFFF";
    wait for 10 ns;
    --------------------------------------------------------------------- 32 ns
    ce    <= 'U';
    rst   <= 'U';
    instr <= "UUUUUUUUUUUUUUUU";
    wait;
  end process;

  -----------------------------------------------------------------------------
  -- Output verification
  -----------------------------------------------------------------------------

  process
  begin
    wait for 9 ns;
    -- Reset (before clk) ------------------------------------------------ 9 ns
    ok <= (cond = "0000"  ) and
          (op   = "0000"  ) and
          (updt = '0'     ) and
          (imm  = '0'     ) and
          (val  = "000000");
    wait for 2 ns;
    -- Reset (after clk) ------------------------------------------------ 11 ns
    ok <= (cond = "0000"  ) and
          (op   = "0000"  ) and
          (updt = '0'     ) and
          (imm  = '0'     ) and
          (val  = "000000");
    wait for 8 ns;
    -- Clock enabled (before clk) --------------------------------------- 19 ns
    ok <= (cond = "0000"  ) and
          (op   = "0000"  ) and
          (updt = '0'     ) and
          (imm  = '0'     ) and
          (val  = "000000");
    wait for 2 ns;
    -- Clock enabled (after clk) ---------------------------------------- 21 ns
    ok <= (cond = "0101"  ) and
          (op   = "1010"  ) and
          (updt = '1'     ) and
          (imm  = '0'     ) and
          (val  = "100101");
    wait for 8 ns;
    -- Clock disabled (before clk) -------------------------------------- 29 ns
    ok <= (cond = "0101"  ) and
          (op   = "1010"  ) and
          (updt = '1'     ) and
          (imm  = '0'     ) and
          (val  = "100101");
    wait for 2 ns;
    -- Clock disabled (after clk) --------------------------------------- 31 ns
    ok <= (cond = "0101"  ) and
          (op   = "1010"  ) and
          (updt = '1'     ) and
          (imm  = '0'     ) and
          (val  = "100101");
    wait for 1 ns;
    --------------------------------------------------------------------- 32 ns
    ok   <= true;
    done <= true;
    wait;
  end process;

  passed <= passed and ok;
  
end architecture;