module contadorcresc(
  input [17:0] SW,
  input [3:0] KEY,
  input CLK,
  output [0:6]HEX1
);

  reg [3:0] display;    // registrador de contagem
  reg [3:0] contrario;  // Contagem invertida

  reg [28:0] contador_clk;   // Contador para controlar a frequência de clock

  always @(posedge CLK) begin
    // Lógica de seleção de frequência de clock
    contador_clk <= contador_clk + 1;
	 
	 if (SW[0]) 
		 begin
			display <= 4'b0000;
		 end 
		 
	case({SW[17], SW[16]})
	 2'b00: if (display == 4'b1000) 
				begin
				  display <= 4'b0000;
				end 
			  else if (contador_clk == 25000000) 
				begin
				  display <= display + 1;
				  contador_clk <= 0;
				end
	 2'b01: if (display == 4'b1000) 
				begin
				  display <= 4'b0000;
				end 
			  else if (contador_clk == 50000000) 
				begin
				  display <= display + 1;
				  contador_clk <= 0;
				end		  
	 2'b10: if (display == 4'b1000) 
				begin
				  display <= 4'b0000;
				end
			  else if (contador_clk == 100000000) 
				begin
				  display <= display + 1;
				  contador_clk <= 0;
				end
    2'b11: if (display == 4'b1000) 
				begin
				  display <= 4'b0000;
				end 
			  else if (contador_clk == 300000000) 
				begin
				  display <= display + 1;
				  contador_clk <= 0;
				end
	 endcase
end

  always @* begin
    contrario[0] = display[3];
    contrario[1] = display[2];
    contrario[2] = display[1];
    contrario[3] = display[0];
  end

 verilog (.SW(contrario),.HEX1(HEX1));

endmodule