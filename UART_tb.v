`timescale 1ns / 1ps

module tb_uart;

  // Define parameters
  reg clk;
  reg rst;
  wire rx;
  wire tx;
  wire [7:0] doutrx;
  wire donetx;
  wire donerx;

  // Create a separate signal to provide stimulus to uart_top
  reg [7:0] tx_data;
  reg newd;

  // Instantiate the UART top module
  uart_top
  #(
    .clk_freq(1000000),
    .baud_rate(9600)
  )
  uart_top_inst (
    .clk(clk),
    .rst(rst),
    .rx(rx),
    .dintx(tx_data),
    .newd(newd),
  
  );

  // Clock generation
  always begin
    #5 clk = ~clk; // Create a 1MHz clock (500ns period)
  end

  // Initialize signals and test cases
  initial begin
    clk = 0;
    rst = 1;
    newd = 0;
    tx_data = 8'b0;
    

    #50 rst = 0;

    // Test cases
    // Case 1: Transmitter sends data, Receiver receives it
    newd = 1;
    tx_data = 8'b10101010; // Example data
    // You may need to add a delay here to allow for communication to complete
    #100;
    newd = 0;

    // Case 2: Additional test cases can be added here
    // Example: Sending a different set of data

    // You can add more test cases to cover various scenarios

    $finish; // Finish simulation
  end

  // Display results
  always @(posedge clk) begin
    $display("Transmitter: tx=%b, donetx=%b", tx, donetx);
    $display("Receiver: doutrx=%b, donerx=%b", doutrx, donerx);
  end

   initial begin
      $dumpfile("dump.vcd");
      $dumpvars;
    end


endmodule
