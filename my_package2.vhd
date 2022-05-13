library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package my_package is
	--Funcao que recebe uma nota e retorna o valor da nota caso seja valida
	function VerificaNotaCorreta(	nota : std_logic_vector(7 downto 0))
			return std_logic;

end package my_package;

package body my_package is

    	--Funcao que recebe uma nota e retorna o valor da nota caso seja valida
	function VerificaNotaCorreta(nota : std_logic_vector(7 downto 0))
		return std_logic is
		variable correto : std_logic;
		begin
			case nota is
                                    when "00000101" => correto := '1';
                                    when "00000010" => correto := '1';
                                    when "00000001" => correto := '1';
                                    when others => correto := '0';
                        end case; 

	return correto;		
	end function;


end;