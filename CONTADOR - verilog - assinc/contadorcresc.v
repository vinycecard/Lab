module contadorcresc( //sincrono
    input [17:0]SW,
    input [3:0]KEY,
    input CLK,
    output [0:6]HEX4
);

    reg [3:0] display; // registrador de 4 bits usado para armazenar o valor do contador
    reg [3:0] contrario; // registrador de 4 bits usado para armazenar o valor invertido do contador

    always @(posedge CLK) //Lista de sensibilidade (clock chama o laço sempre para a execução, quanto mais variaveis tiver aqui, mais quando elas forem acionadas o laço será chamado a execução)
    begin
        if (SW[17])
        begin
            display <= 4'b0000;
        end
        else if (KEY[0])
        begin
            if (display == 4'b0111)
            begin
                display <= 4'b0000;
            end
            else
            begin
                display <= display + 1;
            end
        end

        contrario[0] = display[3];
        contrario[1] = display[2];
        contrario[2] = display[1];
        contrario[3] = display[0];
    end

    verilog (.SW(contrario),.HEX4(HEX4));

endmodule 