`timescale 1ns / 1ps
//****************************************************************//
// File name: transmit_engine.v
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
module transmit_engine(clk, reset,
                       baud, eight, parity_en, odd_n_even, tx, txrdy,
                       out_port, load);
	
	input       clk, reset, 
                eight, parity_en,
                odd_n_even, load; 
	input [3:0] baud; 
	input [7:0] out_port; 
	output      tx, txrdy; 
	
	wire       doneD1, doit, writeD1,
               done, b10, b9, btu; 
	wire [7:0] load_data; 

	//SRQ_FLOP            ( clk,       reset,
	SRQ_FLOP    txrdy_out (.clk(clk), .reset(reset),
    //                      S,          R,        Q);
                           .S(doneD1), .R(load), .Q(txrdy));
    //SRQ_FLOP            ( clk,       reset,
	SRQ_FLOP    doit_out  (.clk(clk), .reset(reset),
    //                      S,        R,        Q);
                           .S(load), .R(done), .Q(doit));
    //LD_REG                 (clk, reset, load, 
	LD_REG      ld_data_out (.clk(clk), .reset(reset), .load(load), 
    //                        D,            Q);	
                             .D(out_port), .Q(load_data)); 
	//D_FLOP                 (clk,       reset,
	D_FLOP      writeD1_out (.clk(clk), .reset(reset),
    //                        D,        Q);
                             .D(load), .Q(writeD1));
	//Bit_Decoder          (Load_Data, 
	Bit_Decoder decode_out(.Load_Data(load_data),
    //                      bit_8,         parity_en, 
                           .bit_8(eight), .parity_en(parity_en), 
    //                      odd_n_even, 
                           .odd_n_even(odd_n_even),
    //                      b10,      b9);
                           .b10(b10),.b9(b9));
    //Shift_Register     ( reset,         clk,       ld, 								 
	Shift_Register shift (.reset(reset), .clk(clk), .ld(writeD1), 
    //                     sh,       sdi, 
                          .sh(btu), .sdi(1'b1), 
    //                     bit_10, bit_9, LData,
                          .bit_10(b10), .bit_9(b9), .LData(load_data[6:0]),
    //                     bit_1,        bit_0,        sdo);
                          .bit_1(1'b0), .bit_0(1'b1), .sdo(tx));

    //Bit_Time_Counter          (clk,       reset,
	Bit_Time_Counter timeCount (.clk(clk), .reset(reset),
    //                           BAUD_VAL,        DOIT,        BTU);
                                .BAUD_VAL(baud), .DOIT(doit), .BTU(btu));
	
    //Bit_Counter        ( clk,       reset,
	Bit_Counter bitCount (.clk(clk), .reset(reset),
    //                     BTU,       DOIT, 
                          .BTU(btu), .DOIT(doit), 
    //                     DONE,       DONED1);
                          .DONE(done),.DONED1(doneD1)); 	
endmodule
