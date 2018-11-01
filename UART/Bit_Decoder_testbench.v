`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:17:04 10/12/2018
// Design Name:   Bit_Decoder
// Module Name:   D:/SCHOOL WORK/CECS 460 Labs/UART/Bit_Decoder_testbench.v
// Project Name:  UART
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Bit_Decoder
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Bit_Decoder_testbench;

	// Inputs
	reg [7:0] Load_Data;
	reg bit_8;
	reg parity_en;
	reg odd_n_even;

	// Outputs
	wire b10;
	wire b9;

	// Instantiate the Unit Under Test (UUT)
	Bit_Decoder uut (
		.Load_Data(Load_Data), 
		.bit_8(bit_8), 
		.parity_en(parity_en), 
		.odd_n_even(odd_n_even), 
		.b10(b10), 
		.b9(b9)
	);

	initial begin
		// Initialize Inputs
		Load_Data = 8'b00001111;
		#100; 

		bit_8 = 0; parity_en= 0; odd_n_even= 0;
		#100;
		
		bit_8 = 0; parity_en= 0; odd_n_even= 1;
		#100;
		
		bit_8 = 0; parity_en= 1; odd_n_even= 0;
		#100;
		
		bit_8 = 0; parity_en= 1; odd_n_even= 1;
		#100;
		
		bit_8 = 1; parity_en= 0; odd_n_even= 0;
		#100;
		
		bit_8 = 1; parity_en= 0; odd_n_even= 1;
		#100; 
		
		bit_8 = 1; parity_en= 1; odd_n_even= 0;
		#100;
		
		bit_8 = 1; parity_en= 1; odd_n_even= 1;
		#100;
		
	end
      
endmodule

