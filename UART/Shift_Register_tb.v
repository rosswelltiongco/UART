`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:16:35 10/11/2018
// Design Name:   Shift_Register
// Module Name:   D:/SCHOOL WORK/CECS 460 Labs/UART/Shift_Register_tb.v
// Project Name:  UART
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Shift_Register
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Shift_Register_tb;

	// Inputs
	reg reset;
	reg clk;
	reg ld;
	reg sh;
	reg sdi;
	reg bit_10;
	reg bit_9;
	reg [7:0] LData;
	reg bit_1;
	reg bit_0;

	// Outputs
	wire sdo;

	// Instantiate the Unit Under Test (UUT)
	Shift_Register uut (
		.reset(reset), 
		.clk(clk), 
		.ld(ld), 
		.sh(sh), 
		.sdi(sdi), 
		.bit_10(bit_10), 
		.bit_9(bit_9), 
		.LData(LData), 
		.bit_1(bit_1), 
		.bit_0(bit_0), 
		.sdo(sdo)
	);

always #5 clk = ~clk; 
always #5 sh = ~sh; 
	initial begin
		// Initialize Inputs
		reset = 1;
		clk = 0;
		ld = 0;
		sh = 0;
		sdi = 1;
		bit_10 = 0;
		bit_9 = 0;
		LData = 0;
		bit_1 = 0;
		bit_0 = 1;

		// Wait 100 ns for global reset to finish
		#100;
		reset = 0; 
		#100; 
        
		// Add stimulus here
		ld = 1; 	
		LData = 8'b00111100; 
		#100;
		ld = 0;
		#10;

	end
      
endmodule

