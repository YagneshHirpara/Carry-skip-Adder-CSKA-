module cla_block #(parameter WIDTH = 4)(
  input  [WIDTH-1:0] A, B,
  input              Cin,
  output [WIDTH-1:0] Sum,
  output             Cout,
  output             P_block   // Propagate block signal
);
  wire [WIDTH-1:0] P, G, C;
  
  assign P = A ^ B;
  assign G = A & B;
  
  assign C[0] = Cin;
  
  genvar i;
  generate
    for (i = 1; i < WIDTH; i = i + 1) begin
      assign C[i] = G[i-1] | (P[i-1] & C[i-1]);
    end
  endgenerate
  
  assign Sum = P ^ C;
  assign Cout = G[WIDTH-1] | (P[WIDTH-1] & C[WIDTH-1-1]);
  assign P_block = &P;  
  
endmodule
