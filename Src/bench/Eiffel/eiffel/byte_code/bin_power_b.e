class BIN_POWER_B 

inherit
	NUM_BINARY_B
		rename
			Bc_power as operator_constant
		redefine
			print_register
		end

	SHARED_INCLUDE

feature

	print_register is
			-- Print expression value
		local
			left_type: TYPE_I;
			right_type: TYPE_I;
			result_type: TYPE_I;
			buf: GENERATION_BUFFER
			queue: like shared_include_queue
		do
			queue := shared_include_queue
			if not queue.has (math_header_file) then
				queue.extend (math_header_file)
			end
			buf := buffer
			buf.putstring ("(EIF_DOUBLE) pow ((EIF_DOUBLE)");
			left.print_register;
			buf.putstring (",(EIF_DOUBLE)");
			right.print_register;
			buf.putchar (')');
		end;

feature {NONE} -- Implementation

	math_header_file: STRING is "<math.h>"

end
