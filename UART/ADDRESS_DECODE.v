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
module ADDRESS_DECODE(  
	 input [15:0] port_id,
    input write_strobe,
    input read_strobe,
    output reg [15:0] reads,
    output reg [15:0] writes
    );

    always@ (*) begin
        if (read_strobe)
            reads <= port_id;
        else if (write_strobe)
            writes <= port_id;
        else begin
            reads <= 16'h0000; writes <=16'h0000; end
    end

endmodule

