module ulaverilog(SW, HEX1,LEDR);

    input [0:17]SW;
    reg [0:3]a;
    reg [0:3]b;
    
    reg [0:3]inbcd;
    
    output [0:6] HEX1;
	 output [0:3]LEDR;
    
    always @(*)
        begin
            a ={SW[17], SW[16], SW[15], SW[14]};
            b ={SW[13], SW[12], SW[11], SW[10]};
				
            case({SW[2], SW[1], SW[0]})
                3'b000: inbcd = a&b;
                3'b001: inbcd = a|b;
                3'b010: inbcd = a+b;
                3'b011: inbcd = a-b;
                3'b100: inbcd = a*b;
                3'b101: inbcd = a/b;
					 default inbcd = 4'b0000;
            endcase
        end
		  
		  
	assign {LEDR[3],LEDR[2],LEDR[1],LEDR[0]} = inbcd;
 
    verilog(.SW(inbcd), .HEX0(HEX1));
endmodule