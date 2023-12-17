module verilog(SW, HEX4);
    input [14:17]SW; // Entrada de 4 bits representando um conjunto de chaves
    output [0:6]HEX4; // Saída de 7 bits representando o valor para um display de 7 segmentos
    reg [0:6] segmentos;  // Registrador de 7 bits para armazenar os segmentos do display
    always @ (*) // Sempre bloco sensível a qualquer alteração nas entradas
        case ({SW[17], SW[16], SW[15], SW[14] })
            4'b0000: segmentos=7'b0000001; // Caso esteja em 4'b0000
            4'b0001: segmentos=7'b1001111; // Caso esteja em 4'b0001
            4'b0010: segmentos=7'b0010010; // Caso esteja em 4'b0010
            4'b0011: segmentos=7'b0000110; // Caso esteja em 4'b0011
            4'b0100: segmentos=7'b1001100; // Caso esteja em 4'b0100
            4'b0101: segmentos=7'b0100100; // Caso esteja em 4'b0101
            4'b0110: segmentos=7'b0100000; // Caso esteja em 4'b0110
            4'b0111: segmentos=7'b0001111; // Caso esteja em 4'b0111
            4'b1000: segmentos=7'b0000000; // Caso esteja em 4'b1000
            4'b1001: segmentos=7'b0000100; // Caso esteja em 4'b1001
            default: segmentos = 7'b1111111; // Caso padrão para qualquer outra combinação
        endcase
    assign HEX4 = segmentos; // Atribuindo o valor de segmentos à saída HEX4
endmodule 