module cska_top #(parameter N = 16, BLOCK_SIZE = 4)(
  input  [N-1:0] A, B,
  input          Cin,
  output [N-1:0] Sum,
  output         Cout
);
  localparam BLOCKS = N / BLOCK_SIZE;
  
  wire [BLOCKS:0] carry;
  wire [BLOCKS-1:0] propagate;
  assign carry[0] = Cin;

  genvar i;
  generate
    for (i = 0; i < BLOCKS; i = i + 1) begin : cska_block
      wire [BLOCK_SIZE-1:0] sum_temp;
      wire block_carry, block_p;

      cla_block #(.WIDTH(BLOCK_SIZE)) cla_inst (
        .A    (A[i*BLOCK_SIZE +: BLOCK_SIZE]),
        .B    (B[i*BLOCK_SIZE +: BLOCK_SIZE]),
        .Cin  (carry[i]),
        .Sum  (sum_temp),
        .Cout (block_carry),
        .P_block (block_p)
      );
      
      assign Sum[i*BLOCK_SIZE +: BLOCK_SIZE] = sum_temp;
      assign propagate[i] = block_p;

      assign carry[i+1] = block_p ? carry[i] : block_carry;
    end
  endgenerate

  assign Cout = carry[BLOCKS];
endmodule

