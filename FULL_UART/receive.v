//****************************************************************//
// File name: receive.v
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

module receive(clk, rst, clr, rx, eight, parity_en, ohel, k, data, RXRDY, PERR, FERR, OVF);

   input    clk, rst;
   input    clr;
   input    rx;
   input    eight, parity_en, ohel;
   input    [18:0] k;
   output reg   RXRDY, PERR, FERR, OVF;
   output   [7:0] data;

   reg [3:0] bitCountReg, bc, count;

   reg [18:0] bitTimeCountReg, btc, bitTime;

   reg p_gen, reg p_bit, p_discrepency;

   reg [1:0] pres_s, next_s;
   reg start, doit;

   always @ (posedge clk, posedge rst)
      if (rst) pres_s <= 2'b0;
      else     pres_s <= next_s;

   always @ (*)
      case(pres_s)
         2'b00: begin
               start = 0;
               doit  = 0;
               if (~rx) next_s = 2'b01;
               else next_s = 2'b00;
            end
         2'b01: begin
               start = 1;
               doit  = 1;
               if (rx) next_s = 2'b00;
               else if (~rx && ~btu) next_s = 2'b01;
               else if (~rx && btu) next_s = 2'b10;
               else next_s = 2'b01;
            end
         2'b10: begin
               start = 0;
               doit  = 1;
               if (done) next_s = 2'b00;
               else next_s = 2'b10;
            end
         default: begin
               next_s = 2'b00;
               start  = 0;
               doit   = 0;
            end
      endcase



   always @(*)
      case ({doit, btu})
         2'b00 : bc = 4'b0;
         2'b01 : bc = 4'b0;
         2'b10 : bc = bitCountReg;
         2'b11 : bc = bitCountReg + 1;
   endcase

   always @ (posedge clk, posedge rst)
      if (rst)
         bitCountReg <= 4'b0;
      else
         bitCountReg <= bc;

   always @ (*)
      case ({eight, parity_en})
         2'b00 : count = 9;       // start, 7 data bits and stop bit
         2'b01 : count = 10;      // start, 7 data bits, parity bit, and stop bit
         2'b10 : count = 10;      // start, 8 data bits, and stop bit
         2'b11 : count = 11;      // start, 8 data bits, parity bit, and stop bit
         default: count = 9;
      endcase

   assign done = (bitCountReg == count);





   always @(*)
      case({doit, btu})
         2'b00 : btc = 19'b0;
         2'b01 : btc = 19'b0;
         2'b10 : btc = bitTimeCountReg + 1;
         2'b11 : btc = 19'b0;
      endcase

   always @(posedge clk, posedge rst)
      if (rst)
         bitTimeCountReg <= 19'b0;
      else
         bitTimeCountReg <= btc;

   always @ (*)
      if (start) bitTime = k >> 1;
      else       bitTime = k;

   assign btu = (bitTimeCountReg == bitTime);


   reg [9:0] shiftRegister;
   assign sh = btu & ~start;

   always @ (posedge clk, posedge rst)
      if (rst)
         shiftRegister <= 10'b0;
      else if (sh)
         shiftRegister <= {rx, shiftRegister[9:1]};

   reg [9:0] remap_r;

   always @ (*)
      case ({eight, parity_en})
         2'b00: remap_r   =  {2'b11, shiftRegister[9:2]};
         2'b01: remap_r   =  {1'b1,  shiftRegister[9:1]};
         2'b10: remap_r   =  {1'b1,  shiftRegister[9:1]};
         2'b11: remap_r   =  shiftRegister;
      endcase


   always @(posedge clk, posedge rst)
      if (rst)
         RXRDY <= 0;
      else if (done)
         RXRDY <= 1;
      else if (clr)
         RXRDY <= 0;
      else
         RXRDY <= RXRDY;


   always @ (*)
      begin
         if (eight) p_bit = remap_r[8];
         else       p_bit = remap_r[7];

         case ({eight, ohel})
            2'b00: p_gen = ^remap_r[6:0];    //7E1
            2'b01: p_gen = ~^remap_r[6:0];   //7O1
            2'b10: p_gen = ^remap_r[7:0];    //8E1
            2'b11: p_gen = ~^remap_r[7:0];   //8O1
         endcase

         p_discrepency = (p_bit ^ p_gen);

      end


   always @(posedge clk, posedge rst)
      if (rst)
         PERR <= 0;
      else if (p_discrepency & done & parity_en)
         PERR <= 1;
      else if (clr)
         PERR <= 0;
      else
         PERR <= PERR;

   always@ (posedge clk, posedge rst)
      if (rst)
         OVF <= 0;
      else if (RXRDY & done)
         OVF <= 1;
      else if (clr)
         OVF <= 0;
      else
         OVF <= OVF;


   reg stop_bit;
   always @(*)
      case({eight, parity_en})
         2'b00 : stop_bit = remap_r[7];
         2'b01 : stop_bit = remap_r[8];
         2'b10 : stop_bit = remap_r[8];
         2'b11 : stop_bit = remap_r[9];
      endcase

   always@ (posedge clk, posedge rst)
      if (rst)
         FERR <= 0;
      else if (~stop_bit & done)
         FERR <= 1;
      else if (clr)
         FERR <= 0;
      else
         FERR <= FERR;

   assign data = (eight) ? remap_r[7:0] : {1'b0, remap_r[6:0]};

endmodule
