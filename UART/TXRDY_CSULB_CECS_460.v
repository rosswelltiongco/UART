`timescale 1ns / 1ps
//****************************************************************//
// File name: TXRDY_CSULB_CECS_460.v
//
// Created by       Rosswell Tiongco on <11/01/18>. 
// Copyright © 2018 Rosswell Tiongco. All rights reserved.
// 
// 
// In submitting this file for class work at CSULB
// I am confirming that this is my work and the work
// of no one else. In submitting this code I acknowledge that
// plagiarism in student project work is subject to dismissal
// from the class. 
//****************************************************************//
module TXRDY_CSULB_CECS_460(clk, rst, 
                            baud,  eight, parity_en, odd_n_even, 
                            LED,tx);
									 
	input        clk, rst, eight, parity_en, odd_n_even; 
	input  [3:0] baud; 
    output tx; 
	output [15:0] LED; 
	
	reg [15:0] LED_store; 

	wire        read_strobe, write_strobe,
                load, reset_s, txrdy_w, s_w,
                ped_w, ack_w, srq_w, wire_0;     
	wire [15:0] port_id,
                reads0, reads1, reads2, reads3,
                writes0, writes1, writes2, writes3,
                out_port; 
	
	AISO sync_r(.clk(clk), .reset(rst), .reset_s(reset_s));
	
	transmit_engine txeng(.clk(clk), .reset(reset_s), .baud(baud), .eight(eight), .parity_en(parity_en),
					    .odd_n_even(odd_n_even), .tx(tx), .txrdy(txrdy_w), .out_port(out_port[7:0]), 
						 .load(writes0[0]));
					
	 
	ped  pulse (.clk(clk), .reset(reset_s), .level(txrdy_w), .tick(ped_w)); 
	
	SRQ_FLOP srq (.clk(clk), .reset(reset_s),.S(ped_w), .R(ack_w), .Q(srq_w));
	
	tramelblaze_top tBlaze (.CLK(clk), .RESET(reset_s), .IN_PORT(16'b0), .INTERRUPT(srq_w), 
                            .OUT_PORT(out_port), .PORT_ID(port_id), .READ_STROBE(read_strobe), 
                            .WRITE_STROBE(write_strobe), .INTERRUPT_ACK(ack_w));

	ADDR_DECODE addr(.ADHI(port_id[15:14]), .ADIO(port_id[3:0]), .READ(read_strobe), .WRITE(write_strobe),
                     .READS0(reads0),       .WRITES0(writes0),   .READS1(reads1),    .WRITES1(reads1), 
                     .READS2(reads2),       .WRITES2(writes2),   .READS3(reads2),    .WRITES3(writes3));
								
	assign LED = writes0[1];  
endmodule
