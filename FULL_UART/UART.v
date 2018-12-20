//****************************************************************//
// File name: UART.v
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

module UART( clk, rst, baud, eight, parity_en, ohel,
             rx, tx, led);

   input clk, rst, eight, parity_en, ohel, rx;
   input [3:0] baud;

   output tx;
   output reg [15:0] led;

   wire rst_s, TXRDY, RXRDY, PERR, OVF, FERR, interrupt, interrupt_ack;
   wire read_strobe, write_strobe;
   wire [15:0] port_id, data;
   wire [7:0] in_port;

   reg [18:0] k;

   aiso_rst              u0 (.clk(clk), .reset(rst), .reset_s(rst_s));

   wire RXRDY_pulse, TXRDY_pulse;
   assign uart_int = RXRDY_pulse | TXRDY_pulse;

   ped                   ped_rx (.clk(clk), .rst(rst_s), .ped_in(RXRDY), .ped_out(RXRDY_pulse));
   ped                   ped_tx (.clk(clk), .rst(rst_s), .ped_in(TXRDY), .ped_out(TXRDY_pulse));

   sr_flop               u2 (.clk(clk), .rst_s(rst_s), .S(uart_int), .R(interrupt_ack), .Q(interrupt));


   transmit           u3 ( .clk(clk),.rst(rst_s),
                           .load((port_id == 16'h0000) && write_strobe), .data(data[7:0]),
                           .k(k), .eight(eight), .parity_en(parity_en), .ohel(ohel),
                           .TXRDY(TXRDY),.tx(tx) );


   receive            u4 ( .clk(clk), .rst(rst_s), .clr((port_id==16'h0000) && read_strobe),.rx(rx),
                           .eight(eight),.parity_en(parity_en),.ohel(ohel),
                           .k(k), .data(rxdata),.RXRDY(RXRDY),.PERR(PERR),.FERR(FERR),
                           .OVF(OVF));

   tramelblaze_top   u5 ( .CLK(clk),.RESET(rst_s), .IN_PORT({8'b0, in_port}),.INTERRUPT(interrupt),
                          .OUT_PORT(data), .PORT_ID(port_id), .READ_STROBE(read_strobe),
                          .WRITE_STROBE(write_strobe), .INTERRUPT_ACK(interrupt_ack) );


   always @(*)
      case(baud)
         4'b0000: k = 333333 - 1;
         4'b0001: k = 83333  - 1;
         4'b0010: k = 41677  - 1;
         4'b0011: k = 20833  - 1;
         4'b0100: k = 10417  - 1;
         4'b0101: k = 5208   - 1;
         4'b0110: k = 2604   - 1;
         4'b0111: k = 1736   - 1;
         4'b1000: k = 868    - 1;
         4'b1001: k = 434    - 1;
         4'b1010: k = 217    - 1;
         4'b1011: k = 109    - 1;
         default: k = 333333 - 1;
      endcase

   wire [7:0]rxdata;

   assign in_port = (port_id == 16'h0001) ? {3'b000, OVF, FERR, PERR, TXRDY, RXRDY} : rxdata;


   always @ (posedge clk, posedge rst_s)
      if (rst_s)
         led <= 16'b0;
      else if (port_id == 16'h0001 && write_strobe)
         led <= data;

endmodule
