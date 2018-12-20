//****************************************************************//
// File name: tsi.v
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

module tsi(clk_i, rst_i, baud_i, eight_i, parity_en_i, ohel_i, rx_i, tx_i, led_i,
           clk_o, rst_o, baud_o, eight_o, parity_en_o, ohel_o, rx_o, tx_o, led_o);

   input clk_i;
   input rst_i;
   input [3:0] baud_i;
   input eight_i, parity_en_i, ohel_i;
   input rx_i;
   input tx_i;
   input [15:0] led_i;
   output  clk_o;
   output  rst_o;
   output  [3:0] baud_o;
   output  eight_o, parity_en_o, ohel_o;
   output  rx_o, tx_o;
   output  [15:0] led_o;

   BUFG BUFG_inst( .O(clk_o),//1-bitoutput:Clockoutput
                   .I(clk_i)//1-bitinput:Clockinput
                  );

   IBUF#(
      .IBUF_LOW_PWR("TRUE"),//Lowpower(TRUE)vs.perforrmance(FALSE)settingforrreferencedI/Ostandards
      .IOSTANDARD("DEFAULT")//SpecifytheinputI/Ostandard
      ) baud[3:0](
         .O(baud_o[3:0]),//Bufferoutput
         .I(baud_i[3:0]) //Bufferinput(connectdirectlytotop-levelport)
      );

    IBUF#(
       .IBUF_LOW_PWR("TRUE"),//Lowpower(TRUE)vs.perforrmance(FALSE)settingforrreferencedI/Ostandards
       .IOSTANDARD("DEFAULT")//SpecifytheinputI/Ostandard
       ) rst(
          .O(rst_o),//Bufferoutput
          .I(rst_i) //Bufferinput(connectdirectlytotop-levelport)
       );

   IBUF#(
      .IBUF_LOW_PWR("TRUE"),//Lowpower(TRUE)vs.perforrmance(FALSE)settingforrreferencedI/Ostandards
      .IOSTANDARD("DEFAULT")//SpecifytheinputI/Ostandard
      ) eight(
         .O(eight_o),//Bufferoutput
         .I(eight_i) //Bufferinput(connectdirectlytotop-levelport)
      );

   IBUF#(
      .IBUF_LOW_PWR("TRUE"),//Lowpower(TRUE)vs.perforrmance(FALSE)settingforrreferencedI/Ostandards
      .IOSTANDARD("DEFAULT")//SpecifytheinputI/Ostandard
      ) pen(
         .O(parity_en_o),//Bufferoutput
         .I(parity_en_i) //Bufferinput(connectdirectlytotop-levelport)
      );

   IBUF#(
      .IBUF_LOW_PWR("TRUE"),//Lowpower(TRUE)vs.perforrmance(FALSE)settingforrreferencedI/Ostandards
      .IOSTANDARD("DEFAULT")//SpecifytheinputI/Ostandard
      ) ohel(
         .O(ohel_o),//Bufferoutput
         .I(ohel_i) //Bufferinput(connectdirectlytotop-levelport)
      );

   IBUF#(
      .IBUF_LOW_PWR("TRUE"),//Lowpower(TRUE)vs.perforrmance(FALSE)settingforrreferencedI/Ostandards
      .IOSTANDARD("DEFAULT")//SpecifytheinputI/Ostandard
      ) rx(
         .O(rx_o),//Bufferoutput
         .I(rx_i) //Bufferinput(connectdirectlytotop-levelport)
      );

   OBUF#(
      .DRIVE(12),//Specifytheoutputdrivestrength
      .IOSTANDARD("DEFAULT"),//SpecifytheoutputI/Ostandard
      .SLEW("SLOW")//Specifytheoutputslewrate
      ) tx(
         .O(tx_o),//Bufferoutput(connectdirectlytotop-levelport)
         .I(tx_i)//Bufferinput
      );

   OBUF#(
      .DRIVE(12),//Specifytheoutputdrivestrength
      .IOSTANDARD("DEFAULT"),//SpecifytheoutputI/Ostandard
      .SLEW("SLOW")//Specifytheoutputslewrate
      ) led[15:0](
         .O(led_o[15:0]),//Bufferoutput(connectdirectlytotop-levelport)
         .I(led_i[15:0])//Bufferinput
      );

endmodule
