`timescale 1ns / 1ps

module tb_cska;

  parameter N = 4;
  parameter BLOCK_SIZE = 2;

  reg  [N-1:0] A, B;
  reg         Cin;
  wire [N-1:0] Sum;
  wire        Cout;

  // DUT Instance
  cska_top #(.N(N), .BLOCK_SIZE(BLOCK_SIZE)) dut (
    .A(A), .B(B), .Cin(Cin), .Sum(Sum), .Cout(Cout)
  );

  // Task for printing output
  task show_result;
    begin
      $display("Time=%0t | A=%0h B=%0h Cin=%b => Sum=%0h Cout=%b", 
                $time, A, B, Cin, Sum, Cout);
    end
  endtask

  initial begin
    if ($test$plusargs("zeros")) begin
      A = 0; B = 0; Cin = 0; #10; show_result();
    end
    if ($test$plusargs("ones")) begin
      A = {N{1'b1}}; B = {N{1'b1}}; Cin = 0; #10; show_result();
    end
    if ($test$plusargs("carry_in")) begin
      A = 16'h00FF; B = 16'h0001; Cin = 1; #10; show_result();
    end
    if ($test$plusargs("random")) begin
      repeat (5) begin
        A = $random; B = $random; Cin = $random % 2; #10; show_result();
      end
    end
    if ($test$plusargs("max")) begin
      A = 16'hFFFF; B = 16'h0001; Cin = 0; #10; show_result();
    end
//     else begin
//       $display("No valid +arg found. Use +zeros, +ones, +carry_in, +random, or +max");
//     end

    $finish;
  end
  
  
endmodule

