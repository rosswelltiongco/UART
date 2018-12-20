//****************************************************************//
// File name: transmit.v
//
// Created by       Rosswell Tiongco on <12/19/18>.
// Copyright © 2018 Rosswell Tiongco. All rights reserved.
//
//
// In submitting this file for class work at CSULB
// I am confirming that this is my work and the work
// of no one else. In submitting this code I acknowledge that
// plagiarism in student project work is subject to dismissal
// from the class.
//****************************************************************//
`timescale 1ns / 1ps

 module transmit(clk, rst, load, data, k, eight, parity_en, ohel, TXRDY, tx );

   input    clk, rst, load, eight, parity_en, ohel;
   input    [7:0] data;
   input    [18:0] k;

   output   tx, TXRDY;
   reg      TXRDY;
   reg loadd1;
   reg [7:0] ldata;
   reg      bit9, bit10;
   reg op, ep;
   reg [10:0] shiftRegister;

   always @ (posedge clk, posedge rst)
      if      (rst)  TXRDY <= 1'b1;
      else if (done) TXRDY <= 1'b1;
      else if (load) TXRDY <= 1'b0;
      else           TXRDY <= TXRDY;

   reg doit;
   always @ (posedge clk, posedge rst)
      if (rst) doit <= 1'b0;
      else if (loadd1) doit <= 1'b1;
      else if (done)   doit <= 1'b0;
      else             doit <= doit;

    reg [3:0] bitCountReg;
    reg [3:0] bc;

    always @(*)
       case ({doit, btu})
          2'b00: bc = 4'b0;
          2'b01: bc = 4'b0;
          2'b10: bc = bitCountReg;
          2'b11: bc = bitCountReg + 1;
          2'b11: bc = bitCountReg + 1;
       endcase

    always @(posedge clk, posedge rst)
       if (rst)
          bitCountReg <= 4'b0;
       else
          bitCountReg <= bc;

       assign done = (bitCountReg == 11);

   always @ (posedge clk, posedge rst)
      if (rst) loadd1 <= 1'b0;
      else     loadd1 <= load;



   always @ (posedge clk, posedge rst)
      if(rst)
         ldata <= 8'b0;
      else if (load)
         ldata <= data;



   always @(*) begin
      ep = (eight) ? ^ldata[7:0]: ^ldata[6:0];
      op = (eight) ? ~(^ldata[7:0]) : ~(^ldata[6:0]);
      end

   always @(*)
      case({eight, parity_en, ohel})
         3'b000 : {bit10, bit9} = 2'b11;                 // 7N1
         3'b001 : {bit10, bit9} = 2'b11;                 // 7N1
         3'b010 : {bit10, bit9} = {1'b1, ep};            // 7E1
         3'b011 : {bit10, bit9} = {1'b1, op};            // 7O1
         3'b100 : {bit10, bit9} = {1'b1, ldata[7]};      // 8N1
         3'b101 : {bit10, bit9} = {1'b1, ldata[7]};      // 8N1
         3'b110 : {bit10, bit9} = {ep, ldata[7]};        // 8E1
         3'b111 : {bit10, bit9} = {op, ldata[7]};        // 8O1
         default: {bit10, bit9} = 2'b00;
      endcase




   always @ (posedge clk, posedge rst)
      if (rst)
         shiftRegister <= 11'b11111111111;              // reset to all 1's
      else if (loadd1)
         shiftRegister <= {bit10, bit9, ldata[6:0], 1'b0, 1'b1};
      else if (btu)
         shiftRegister <= {1'b1, shiftRegister[10:1]}; // serial-data-in is always a 1

   assign tx = shiftRegister[0];



   reg [18:0] bitTimeCountReg;
   reg [18:0] btc;

   always @(*)
      case({doit, btu})
         2'b00: btc = 19'b0;
         2'b01: btc = 19'b0;
         2'b10: btc = bitTimeCountReg + 1;
         2'b11: btc = 19'b0;
      endcase

   always @(posedge clk, posedge rst)
      if (rst) bitTimeCountReg <= 19'b0;
      else bitTimeCountReg <= btc;

   assign btu = (bitTimeCountReg == k);
endmodule
