//****************************************************************//
// File name: transmit_top.v
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

module transmit_top( clk, rst, baud, eight, parity_en, ohel, Tx, led);

   input clk, rst, eight, parity_en, ohel;
   input [3:0] baud;

   output Tx;
   output [15:0] led;
   reg    [15:0] led;

   wire rst_s;
   wire interrupt_ack;
   wire write_strobe;
   wire [15:0] port_id;
   wire [15:0] out_port;
   wire TxRDY;
   wire TxRDY_pulse;
   wire interrupt;

   reg [65535:0] writes;
   reg [65535:0] reads;
   always @ (*)
      begin
         writes = 0;
         writes[port_id] = write_strobe;
      end


   reg [18:0] k;



   aiso_rst           u0 ( .clk(clk),
                           .reset(rst),
                           .reset_s(rst_s) );


   sr_flop            u4 ( .clk(clk),
                           .rst_s(rst_s),
                           .S(TxRDY_pulse),
                           .R(interrupt_ack),
                           .Q(interrupt) );

   tramelblaze_top    u1 ( .CLK(clk),
                           .RESET(rst_s),
                           .IN_PORT(16'b0),       //GND
                           .INTERRUPT(interrupt),
                           .OUT_PORT(out_port),
                           .PORT_ID(port_id),
                           .READ_STROBE(),   //GND
                           .WRITE_STROBE(write_strobe),
                           .INTERRUPT_ACK(interrupt_ack) );


   transmit           u2 ( .clk(clk),
                           .rst(rst_s),
                           .load(writes[0]),
                           .data(out_port[7:0]),
                           .k(k),
                           .eight(eight),
                           .parity_en(parity_en),
                           .ohel(ohel),
                           .TxRDY(TxRDY),
                           .Tx(Tx) );


   ped                u3 ( .clk(clk),
                           .rst(rst_s),
                           .ped_in(TxRDY),
                           .ped_out(TxRDY_pulse) );





   always @ (posedge clk, posedge rst_s)
      if (rst_s)
         led <= 16'b0;
      else if (writes[1])
         led <= out_port;

   always @(*)
      case(baud)
         4'b0000: k = 333333 - 1;   // baud rate = 300
         4'b0001: k = 83333  - 1;   // baud rate = 1200
         4'b0010: k = 41677  - 1;   // baud rate = 2400
         4'b0011: k = 20833  - 1;   // baud rate = 4800
         4'b0100: k = 10417  - 1;   // baud rate = 9600
         4'b0101: k = 5208   - 1;   // baud rate = 19200
         4'b0110: k = 2604   - 1;   // baud rate = 38400
         4'b0111: k = 1736   - 1;   // baud rate = 57600
         4'b1000: k = 868    - 1;   // baud rate = 115300
         4'b1001: k = 434    - 1;   // baud rate = 230400
         4'b1010: k = 217    - 1;   // baud rate = 460800
         4'b1011: k = 109    - 1;   // baud rate = 921600
         default: k = 333333 - 1;   // baud rate = 300
      endcase

endmodule
