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
		do
			generated_file.putstring ("RTER;");
			generated_file.new_line;
		end;

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for a retry instruction
		do
			ba.append (Bc_retry);
			ba.write_retry;
		end;

end
