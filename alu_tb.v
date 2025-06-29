module ram_tb;
    reg clk;
    reg we;
    reg [3:0] addr;
    reg [7:0] din;
    wire [7:0] dout;

    // Instantiate the RAM module
    simple_sync_ram uut (
        .clk(clk),
        .we(we),
        .addr(addr),
        .din(din),
        .dout(dout)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk; // 10 time units period

    initial begin
        // Initialize signals
        we = 0; addr = 0; din = 0;

        // Write data to address 0x1
        #10; we = 1; addr = 4'h1; din = 8'hA5;
        #10; we = 0;

        // Write data to address 0x2
        #10; we = 1; addr = 4'h2; din = 8'h5A;
        #10; we = 0;

        // Read from address 0x1
        #10; addr = 4'h1;
        #10;

        // Read from address 0x2
        #10; addr = 4'h2;
        #10;

        // Done
        #20;
        $finish;
    end

    // Monitor signals
    initial begin
        $monitor("Time=%0t, WE=%b, Addr=0x%0h, Din=0x%0h, Dout=0x%0h", $time, we, addr, din, dout);
    end
endmodule
