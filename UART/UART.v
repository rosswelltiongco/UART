`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:01:38 10/12/2018 
// Design Name: 
// Module Name:    UART 
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
module UART(clk, reset, baud, load, out_port, eight, parity_en, odd_n_even, 
				txrdy, tx);
		
		input 		clk, reset, load, eight, parity_en, odd_n_even; 
		input [3:0] baud; 
		input [7:0]	out_port; 
		
		output 		txrdy, tx; 
		
		wire doned1_w, write_w, done_w, doit_w, writed1_w, b10_w, b9_w, btu_w;
				
		wire [7:0]	load_data_w;
		 
		
		Right_Regs right (.clk(clk), .reset(reset), .DONED1(doned1_w), .WRITE(write_w), 
								.DONE(done_w), .OUT_PORT(out_port),.TXRDY(txrdy), .DOIT(doit_w), 
								.LOAD_DATA(load_data_w), .writeD1(writed1_w)); 
								
		Bit_Decoder encode(.Load_Data(load_data_w), .bit_8(eight), .parity_en(parity_en), 
								 .odd_n_even(odd_n_even), .b10(b10_w),.b9(b9_w));
								 
		Shift_Register shift(.reset(reset), .clk(clk), .ld(writed1_w), .sh(btu_w), 
								   .sdi(1'b1), .bit_10(b10_w), .bit_9(b9_w), 
									.LData(load_data_w[6:0]), .bit_1(1'b0), .bit_0(1'b1), .sdo(tx));
									
		Bit_Counter bitCount (.clk(clk), .reset(reset), .BTU(btu_w), .DOIT(doit_w), 
									 .DONE(done_w),.DONED1(doned1_w)); 
									 
		Bit_Time_Counter timeCount(.clk(clk), .reset(reset), .BAUD_VAL(baud), .DOIT(doit_w), 
											.BTU(btu_w)); 
		
endmodule
