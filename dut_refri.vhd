library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.my_package.all;


entity dut_refrigerante is
	port(
		--Relogio para mudança de estado da maquina
	    	clk1        : in std_logic;
		--Estado em que a maquina se encontra
       		estado      : in std_logic_vector(1 downto 0);
		--Tipo de bebida selecionada
		refrigerante: in std_logic_vector(1 downto 0);
		--Valor da nota colocada na maquina
       	 	nota1	    : in std_logic_vector(7 downto 0);
		--Indica se o refrigerante saiu ou nao
		saiu	    : out std_logic;
		--Valor que a maquina retornou ao cliente
	    	troco       : out std_logic_vector(7 downto 0)
    );
end dut_refrigerante;

architecture basic of dut_refrigerante is
	
	--Indica o estado da maquina
	type my_control is (valida, calcula, saida, zera);
	signal estado_atual : my_control;
	signal proximo_estado : my_control;

    	--Tipos de refrigerante
    	type my_refri is (A, B, C, nenhum);
    	signal refrigerante_selecionado   : my_refri;

	--Indica se a nota foi aceita pela maquina
    	signal NotaValida     : std_logic;
	
	--auxilia a escolha do refrigerante
	signal tipo_refrigerante : std_logic_vector(1 downto 0);
	--auxilia a escolha do estado
	signal processo : std_logic_vector(1 downto 0);

	--valor do refrigerante
   	signal valor : unsigned(7 downto 0);

  
    

	begin
	--Recebe o estado da maquina
	processo <= std_logic_vector(estado);
	--Recebe o refrigerante
	tipo_refrigerante <= std_logic_vector(refrigerante);
	
	--Faz a escolha do estado da maquina
	process(estado)
        begin
		case processo is
                	when "00" => proximo_estado <= valida;	
                 	when "01" => proximo_estado <= calcula;
                 	when "10" => proximo_estado <= saida;
			when "11" => proximo_estado <= zera;
                 	when others =>  proximo_estado <= estado_atual;
	 	end case;
	end process;
	
	--Faz a selecao do refrigerante e seu valor
     	process(refrigerante)
        begin
            	case tipo_refrigerante is
                	when "00" => 
				refrigerante_selecionado <= A;
				valor <= to_unsigned(2, valor'length);	
                	when "01" => 
				refrigerante_selecionado <= B;
				valor <= to_unsigned(3, valor'length);
                	when "10" => 
				refrigerante_selecionado <= C;
				valor <= to_unsigned(4, valor'length);
                	when "11" => 
				refrigerante_selecionado <= nenhum;
				valor <= to_unsigned(0, valor'length);
                	when others => 
				refrigerante_selecionado <= nenhum;
				valor <= to_unsigned(0, valor'length);
            	end case;
	end process;

   	--Realiza os processos para cada estado da maquina
    	process(clk1)
	--Variavel interna para o dinheiro do usuario na maquina
	variable usuario : unsigned(7 downto 0):= "00000000";
	--Variavel para a contagem de quanto vai ser devolvido para o usuario
	variable devolver: unsigned(7 downto 0):= "00000000";
	
		begin
	        	if rising_edge(clk1) then
				estado_atual <= proximo_estado;
				case estado_atual is
					--Verifica se a nota e valida
					when valida =>
						usuario := to_unsigned(0,usuario'length);
						devolver := to_unsigned(0,devolver'length);
        					NotaValida <= VerificaNotaCorreta(nota1);
					--Calcula se a nota vai ser devolvida ou somado ao dinheiro do usuario
					when calcula =>
						if (NotaValida = '1') then
							usuario := unsigned(nota1);
						else
							devolver := unsigned(nota1);
							troco <= std_logic_vector(devolver);
						end if;
					--Verifica o troco e se e possivel a bebida ser retirada
	    				when saida => 
						case refrigerante_selecionado is
							when A =>
								if (NotaValida = '1') then
									if(usuario >= valor) then
										troco <= std_logic_vector(usuario - valor);
										saiu <= '1';
									else
										saiu <= '0';
									end if;

								else
									saiu <= '0';
								end if;
							when B =>
								if (NotaValida = '1') then
									if(usuario >= valor) then
										troco <= std_logic_vector(usuario - valor);
										saiu <= '1';
									else
										saiu <= '0';
									end if;

								else
									saiu <= '0';
								end if;
							when C =>
								if (NotaValida = '1') then
									if(usuario >= valor) then
										troco <= std_logic_vector(usuario - valor);
										saiu <= '1';
									else
										saiu <= '0';
									end if;

								else
									saiu <= '0';
								end if;
							when nenhum =>
								saiu <= '0';
							when others =>
								saiu <= '0';
						end case;
					--Zera a saida e o troco
					when zera =>
						saiu <= '0';
						troco <= std_logic_vector(to_unsigned(0,troco'length));
					when others =>
						saiu <= '0';
						troco <= std_logic_vector(to_unsigned(0,troco'length));
                        	end case;  
	                end if;
	end process;
	


	
		

end basic;