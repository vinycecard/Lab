module contadorcresc(
  input wire [17:0] SW,
  input wire [3:0] KEY,
  input wire CLK,
  output reg [0:6] HEX1
);

  reg [3:0] display;    // registrador de contagem
  reg [3:0] contrario;  // Contagem invertida
  reg [3:0] next_display;  // próximo valor de display após debouncing
  reg [3:0] reset_value;

  reg [3:0] debounced_SW;
  reg [3:0] SW_reg, SW_next;
  parameter DEBOUNCE_TIME = 25; // Pode ser ajustado conforme necessário
  reg [6:0] debounce_counter;

  always @(posedge CLK) begin
    if (debounce_counter < DEBOUNCE_TIME) begin
      debounce_counter <= debounce_counter + 1;
    end else begin
      SW_reg <= SW_next;
      debounce_counter <= 0;
    end
  end

  always @(posedge CLK) begin
    if (SW_reg == debounced_SW) begin
      SW_next <= SW;
    end else begin
      SW_next <= SW_reg;
    end
  end

  always @(posedge CLK) begin
    if (KEY[0]) begin
      reset_value <= 4'b0000;
    end
  end

  always @(posedge CLK) begin
    if (KEY[3] || SW[17]) begin
      next_display <= reset_value;
    end else if (display == 4'b1001) begin
      next_display <= 4'b0000;
    end else if (KEY[2] || SW[16]) begin
      next_display <= display + 1;
    end
  end

  always @* begin
    contrario[0] = next_display[3];
    contrario[1] = next_display[2];
    contrario[2] = next_display[1];
    contrario[3] = next_display[0];
  end

  always @(posedge CLK) begin
    display <= next_display;
  end

  verilog(.SW(contrario), .HEX1(HEX1));

endmodule
