module fake(
    input clock,
    input [ 7:0] x,
    input [15:0] a,
    input [15:0] b,
    input [15:0] c,
    input enable,
    input reset,
    output [15:0] result,
    output ready,
    output valid
);


reg [ 7:0] X;
reg [15:0] A;
reg [15:0] B;
reg [ 3:0] state;
reg debug;

assign valid = state == 6;
assign ready = state == 0;

reg soma;
assign result = soma;

always @(posedge clock) begin
    if (reset == 1) 
        debug <= 1;  

    else begin
        if (state == 0 && ~enable)
            state <= state;  

            else begin
                case(state)
                0: begin
                   state = 1;
                end
                1: begin
                    X <= x*x;
                    state = 2;
                end
                2: begin
                   A <= a*X;
                   state = 3;
                end
                3: begin
                   B <= b*x;
                   state = 4;
                end
                4: begin
                   soma <= B+A;    
                   state = 5;
                end
                5: begin
                   soma <= soma+c;
                   state = 6;
                end
                6: begin
                   state = 0;
                end        
            endcase
        end
    end
end
endmodule