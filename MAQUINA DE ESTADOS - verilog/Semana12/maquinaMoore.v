module maquinaMoore (SW, CLOCK_50, HEX0);

input CLOCK50; // Declaração da entrada de clock
input [17:15]SW; // Declaração das entradas usando uma fatia do vetor SW (bits 15 a 17)
output [0:6]HEX0; // Declaração da saída para um display de 7 segmentos
wire clock; // Declaração de um sinal de clock intermediário
reg [3:0]z; // Declaração de um registrador para armazenar a saída intermediária

divisor(.CLK(CLOCK50), .S(clock)); // Instância do módulo divisor que gera um clock mais lento

wire [0:1]w;// Declaração de um sinal de 2 bits para armazenar partes da entrada SW

assign w[0:1] = SW[17:16]; // Associação dos bits 17 e 16 de SW ao vetor w
reg [3:0] y, Y; // Declaração dos registradores para o estado atual (y) e próximo estado (Y)
// Definição dos estados possíveis com valores binários
parameter A = 4'b0000, B= 4'b0001, C= 4'b0010, D=4'b0011, E=4'b0100;
parameter F= 4'b0101, G= 4'b0110, H=4'b0111, I=4'b1000, J=4'b1001, K=4'b1111;

always @(w or y) // Bloco always para lógica combinacional: determina o próximo estado
begin
    case (y)  // Lógica de transição de estados para cada estado atual
    A:  if (w[0]==0 && w[1]==0 || SW[15])
            Y=A;
        else if(w[0]==1 && w[1]==0) 
            Y=B;
        else if(w[0]==0 && w[1]==1)
            Y=I;
        else 
            Y=J;
    
    B:  if (w[0]==0 && w[1]==0) 
            Y=B;
        else if(w[0]==1 && w[1]==0) 
            Y=C;
        else if(w[0]==0 && w[1]==1) 
            Y=A;
        else 
            Y=J;
    
    C:  if (w[0]==0 && w[1]==0) 
            Y=C;
        else if(w[0]==1 && w[1]==0) 
            Y=D;
        else if(w[0]==0 && w[1]==1) 
            Y=B;
        else 
            Y=J;
    
    D:  if (w[0]==0 && w[1]==0) 
            Y=D;
        else if(w[0]==1 && w[1]==0) 
            Y=E;
        else if(w[0]==0 && w[1]==1) 
            Y=C;
        else 
            Y=J;
    
    E:  if (w[0]==0 && w[1]==0) 
            Y=E;
        else if(w[0]==1 && w[1]==0) 
            Y=F;
        else if(w[0]==0 && w[1]==1) 
            Y=D;
        else 
            Y=J;
    
    F:  if (w[0]==0 && w[1]==0) 
            Y=F;
        else if(w[0]==1 && w[1]==0) 
            Y=G;
        else if(w[0]==0 && w[1]==1) 
            Y=E;
        else 
            Y=J;
    
    G:  if (w[0]==0 && w[1]==0) 
            Y=G;
        else if(w[0]==1 && w[1]==0) 
            Y=H;
        else if(w[0]==0 && w[1]==1) 
            Y=F;
        else 
            Y=J;
    
    H:  if (w[0]==0 && w[1]==0) 
            Y=H;
        else if(w[0]==1 && w[1]==0) 
            Y=I;
        else if(w[0]==0 && w[1]==1) 
            Y=G;
        else 
            Y=J;
    
    I:  if (w[0]==0 && w[1]==0) 
            Y=I;
        else if(w[0]==1 && w[1]==0) 
            Y=A;
        else if(w[0]==0 && w[1]==1) 
            Y=H;
        else 
            Y=J;
    
    J:	if (w[0]==1 && w[1]==1) 
            Y=J;
        else
            Y=A;
    		
    endcase
end

always @(posedge clock or posedge SW[15]) // Bloco always para lógica sequencial: atualização do estado atual na borda de subida do clock ou SW[15]
begin
    if (SW[15]==1) // Reset para o estado A se SW[15] estiver em alto
        y <= A;
    else // Transição para o próximo estado
        y <= Y; 
end

always@(Y) // Bloco always para definir a saída com base no estado atual
begin
    case(Y) // Mapeamento de estados para as saídas
        A: z = J;
        B: z = H;
        C: z = B;
        D: z = I;
        E: z = D;
        F: z = A;
        G: z = C;
        H: z = G;
        I: z = F;
        J: z = K;
    endcase
end
    

verilog(.SW(z), .HEX0(HEX0)); // Instância de um decodificador BCD para exibir a saída no display de 7 segmentos


endmodule