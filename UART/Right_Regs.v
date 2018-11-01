`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:48:46 10/11/2018 
// Design Name: 
// Module Name:    Right_Regs 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Right_Regs(clk, reset, DONED1, WRITE, DONE, OUT_PORT,
						TXRDY, DOIT, LOAD_DATA, writeD1);
						
		input clk, reset, DONE, DONED1, WRITE; 
		input [7:0] OUT_PORT; 
		
		output reg TXRDY, DOIT, writeD1; 
		output reg [7:0] LOAD_DATA; 
		
		// 8 BIT WIDE LOAD REGISTER
		always @ (posedge clk, posedge reset)
			if (reset) LOAD_DATA <= 8'b0; else
			if (WRITE) LOAD_DATA <= OUT_PORT; 
			else       LOAD_DATA <= LOAD_DATA; 
			
		// WRITED1 FLOP
		always @(posedge clk, posedge reset)
			if (reset) writeD1 <= 1'b0; 
			else 		  writeD1 <= WRITE; 
				
		// TXRDY SRQ FLOP	
		always @(posedge clk, posedge reset)
			 if (reset)  TXRDY <= 1'b0; else 
			 if (DONED1) TXRDY <= 1'b1; else
			 if (WRITE)  TXRDY <= 1'b0; else
							 TXRDY <= TXRDY; 
		
		// DOIT SRQ FLOP
		always @(posedge clk, posedge reset)
			 if (reset)  DOIT <= 1'b0; else 
			 if (WRITE)  DOIT <= 1'b1; else
			 if (DONE)   DOIT <= 1'b0; else
							 DOIT <= DOIT;	

endmodule
