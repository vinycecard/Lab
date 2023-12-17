module contadorcresc( //contador assincrono
  input [17:0] SW,
  input [3:0] KEY,
  input CLK,
  output [0:6] HEX2
);

  reg [3:0] display;    // registrador de contagem
  reg [3:0] contrario;  // Contagem invertida

  always @(posedge KEY[3] or posedge SW[17]) begin
    if (SW[17]) begin
      display <= 4'b0000;
    end else if (display == 4'b0111) begin
      display <= 4'b0000;
    end else if (KEY[3]) begin
      display <= display + 1;
    end
  end

  always @* begin
    contrario[0] = display[3];
    contrario[1] = display[2];
    contrario[2] = display[1];
    contrario[3] = display[0];
  end


  verilog (.SW(contrario),.HEX2(HEX2));

endmodule 