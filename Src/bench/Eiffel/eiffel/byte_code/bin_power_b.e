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
			power_nb: INT_CONST_B
			power_value: INTEGER
			done: BOOLEAN
			queue: like shared_include_queue
		do
			buf := buffer
			power_nb ?= right
			if power_nb /= Void then
				power_value := power_nb.value
				if power_value = 2 or power_value = 3 then
					done := True
					buf.putstring ("(EIF_DOUBLE) (")
					left.print_register
					buf.putstring (" * ")
					left.print_register
					if power_value = 3 then
						buf.putstring (" * ")
						left.print_register
					end
					buf.putchar (')')
				end
			end

			if not done then
					-- No optimization could have been done, so we generate the
					-- call to `pow'.
				queue := shared_include_queue
				if not queue.has (math_header_file) then
					queue.extend (math_header_file)
				end
				buf.putstring ("(EIF_DOUBLE) pow ((EIF_DOUBLE)");
				left.print_register;
				buf.putstring (",(EIF_DOUBLE)");
				right.print_register;
				buf.putchar (')');
			end
		end;

feature {NONE} -- Implementation

	math_header_file: STRING is "<math.h>"

end
