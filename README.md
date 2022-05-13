# Maquina_de_bebidas_VHDL

Esse projeto tem como objetivo a criação de um controlador eletrônico para uma
máquina de bebidas. A máquina aceita apenas cédulas nos seguintes valores: 1, 2,
5. Caso o usuário insira cédulas de outros valores, estas são simplesmente
devolvidas. O sistema funciona de modo que, caso não haja troco, a bebida não é
vendida, sendo o dinheiro inserido retornado ao usuário. Ao todo a máquina vende 3
tipos diferentes de refrigerante (A, B e C), com preços: 2, 3 e 4, respectivamente.

## Implementação
O projeto segue um fluxo de trabalho da seguinte forma:
1. O usuário coloca a nota na máquina
2. A nota é verificada
a. Se a nota for válida, o valor da nota é somado “dinheiro do usuário”
b. Se a nota for inválida o valor é devolvido como “Troco”
3. O usuário seleciona o refrigerante
4. O valor do refrigerante é checado
a. Se o valor do refrigerante for menor ou igual ao valor disponível em
“dinheiro do usuário” então o troco é calculado e o refrigerante é
entregue
b. Se o valor do refrigerante for maior que o valor disponível em “Dinheiro
do usuário” então o dinheiro é devolvido e a bebida não é entregue
5. Fim!
