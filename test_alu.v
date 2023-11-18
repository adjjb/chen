`timescale 1ns/1ps
`define HALF_CLOCK_PERIOD #5
`define QSIM_OUT_FN "./qsim.out"
`define MATLAB_OUT_FN "../../matlab/fir/alu.results"

module testbench();

    reg clk, resetn;
	reg [15:0] a;
    reg [15:0] b;
    reg [1:0] op;

    integer alu_a, alu_b, alu_op, alu_res, alu_out_qsim;

    wire [15:0] result;
    wire valid;

    integer i, ret_write,ret_read, qsim_out_file, matlab_out_file;
    integer error_count = 0;
    
    alu alu_0(
        .a(a),
        .b(b),
        .op(op),
        .clk(clk),
        .result(result)
    );
    
    always begin
        `HALF_CLOCK_PERIOD
        clk = ~clk;
    end
    
    initial begin
        qsim_out_file = $fopen(`QSIM_OUT_FN,"w");
        if (!qsim_out_file)
        begin
            $display("Couldn't create the output file.");
            $finish;
        end
        matlab_out_file = $fopen(`MATLAB_OUT_FN,"r");
        if (!matlab_out_file)
        begin
            $display("Couldn't open the Matlab file.");
            $finish;
        end

        $dumpfile("./alu.vcd");
        $dumpvars(0,testbench.alu_0);

        clk = 0;
        resetn = 0;
        @(posedge clk);

        @(negedge clk);  
        resetn = 1;    

        @(posedge clk);  
        for (i=0 ; i<8; i=i+1)
            begin
            ret_read = $fscanf(matlab_out_file, "%d %d %d %d", alu_a, alu_b, alu_op, alu_res);
            a = alu_a;
            b = alu_b;
            op = alu_op;
            alu_out_qsim=result;
            if(alu_out_qsim != alu_res)
            begin
                error_count = error_count + 1;
            end

          @(posedge clk);
        end

        if(error_count>0) $display("The results do not match");
        else $display("The results are OK");
        
        $fclose(qsim_out_file);
        $fclose(matlab_out_file);

        $dumpall;
        $dumpflush;

        $finish;


    end

endmodule


































