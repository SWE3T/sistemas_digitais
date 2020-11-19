


module testbench;

reg signed [7:0] x;
reg signed [15:0] a;
reg signed [15:0] b;
reg signed [15:0] c;
wire signed [15:0] y;
reg signed [15:0] expected;

reg clock = 0, enable = 0, reset = 0;

wire valid, ready;

fake fake1(clock, x, a, b, c, enable, reset, y, ready, valid);

always #1 clock <= ~clock;

integer file, test, r;

always @(posedge enable) begin
    r = $fscanf(file, "%d %d %d %d", x, a, b, c);
end

always @(posedge valid) begin
    r = $fscanf(test, "%d", expected);
    if (expected !== y) begin
        $display("Erro: esperava %d, recebi %d.", expected, y);
        $finish;
    end
end


initial begin
    $dumpvars;

    file = $fopenr("input.txt");
    test = $fopenr("output.txt");
    while (!$feof(file)) begin 
        reset <= 1;

        #10;

        reset <= 0;
        enable <= 1;

        #2
        enable <= 0;

        while(!valid)  #1;
        while(!ready)  #1;

    end
    $display("Resultado nota 10.");
    $finish;
end



endmodule