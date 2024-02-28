module signext(
    input   logic [15:0] a,
    output  logic [31:0] y,
    output  logic [31:0] yy
    );
    
    assign y = {{16{a[15]}}, a};
    assign yy = {16'b0, a};
endmodule