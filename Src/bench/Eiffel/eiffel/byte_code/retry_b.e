-- Byte code for retry instruction

class RETRY_B 

inherit

	INSTR_B
		redefine
			generate, make_byte_code
		end
	
feature 

	generate is
			-- Generate the retry instruction
		local
			c: like Context
			workbench_mode: BOOLEAN
		do
				-- Clean up the trace and profiling stacks
			c := Context
			workbench_mode := c.workbench_mode
			if
				workbench_mode or else
				c.associated_class.trace_level.is_yes
			then
					-- Trace clean-up
				generated_file.putstring ("RTTS;");
				generated_file.new_line;
			end
			if
				workbench_mode or else
				c.associated_class.profile_level.is_yes
			then
					-- Profiling clean-up
				generated_file.putstring ("RTPS;");
				generated_file.new_line;
			end

			generated_file.putstring ("RTER;");
			generated_file.new_line;
		end;

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a retry instruction
		do
			make_breakable (ba);
			ba.append (Bc_retry);
			ba.write_retry;
		end;

end
