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
			class_c: CLASS_C
			workbench_mode: BOOLEAN
			buf: GENERATION_BUFFER
		do
			buf := buffer
			generate_line_info

				-- Clean up the trace and profiling stacks
			workbench_mode := Context.workbench_mode
			class_c := Context.associated_class
			if workbench_mode or else class_c.trace_level.is_yes then
					-- Trace clean-up
				buf.putstring ("RTTS;")
				buf.new_line
			end
			if workbench_mode or else class_c.profile_level.is_yes then
					-- Profiling clean-up
				buf.putstring ("RTPS;")
				buf.new_line
			end

			buf.putstring ("RTER;")
			buf.new_line
		end

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a retry instruction
		do
			make_breakable (ba)
			ba.append (Bc_retry)
			ba.write_retry
		end

end
