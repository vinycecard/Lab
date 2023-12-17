module divisor(CLK, S);

input CLK;
output reg S;
reg [25:0] OUT;

always @ (posedge CLK)
    if (OUT == 26'd50000000)
    begin
        OUT<= 26'd0;
        S <= 1;
    end
    else
    begin
        OUT<= OUT+1;
        S <= 0;
    end
endmodule