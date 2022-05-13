library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_package.all;

entity tb_refrigerante is

end entity;

architecture sim of tb_refrigerante is
	component dut_refrigerante is
		port(
	    		clk1         : in std_logic;
       			estado       : in std_logic_vector(1 downto 0);
			refrigerante : in std_logic_vector(1 downto 0);
       	 		nota1	     : in std_logic_vector(7 downto 0);
	    		saiu     : out std_logic;
	    		troco : out std_logic_vector(7 downto 0)
        	);
	end component;	

	signal clk1         : std_logic;
    	signal estado       : std_logic_vector(1 downto 0);
    	signal refrigerante : std_logic_vector(1 downto 0);
	signal nota1        : std_logic_vector(7 downto 0);
	signal saiu : std_logic;
	signal troco : std_logic_vector(7 downto 0);

begin
my_refrigerante: dut_refrigerante
	port map(
		clk1 => clk1,
        	estado => estado,
        	refrigerante => refrigerante,
		nota1 => nota1,
		saiu => saiu,
		troco => troco
	);

	
	
	process is
		begin
			clk1 <= '0';
			wait for 1 ns;
			clk1 <= '1';
			wait for 1 ns;
	end process;
	
	
	process is
		begin	
			--Nota valor 3 (nao valida)
			--Refrigerante B - valor: 3
			--Troco sera 3
			--Nao vai sair refrigerante
			nota1 <= "00000011";
			refrigerante <= "01";
			wait for 4 ns;
			refrigerante <= "00";
			wait for 4 ns;
			estado <= "00";
			wait for 4 ns;
			estado <= "01";
			wait for 4 ns;
			estado <= "10";
			wait for 4 ns;
			estado <= "11";
			wait for 4 ns;
			estado <= "00";

			--Nota valor 2 (valida)
			--Refrigerante A - valor: 2
			--Troco sera 0
			--Vai sair refrigerante
			wait for 4 ns;
			nota1 <= "00000010";
			refrigerante <= "10";
			wait for 4 ns;
			estado <= "01";
			wait for 4 ns;
			estado <= "10";
			wait for 4 ns;
			estado <= "11";
			wait for 4 ns;
			estado <= "00";

			--Nota valor 5 (valida)
			--Refrigerante C - valor: 4
			--Troco sera 1
			--Vai sair refrigerante
			wait for 4 ns;
			nota1 <= "00000101";
			refrigerante <= "11";
			wait for 4 ns;
			estado <= "01";
			wait for 4 ns;
			estado <= "10";
			wait for 4 ns;
			estado <= "11";
			wait for 4 ns;
			estado <= "11";
			wait for 4 ns;
			estado <= "00";
			wait for 4 ns;
			wait;
	end process;


end architecture;

