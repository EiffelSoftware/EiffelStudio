-- Real body id counter associated with a precompilation.

class P_REAL_BODY_ID_SUBCOUNTER

inherit

	P_COMPILER_SUBCOUNTER
		redefine
			make
		end
	REAL_BODY_ID_SUBCOUNTER
		rename
			make as csc_make
		redefine
			next_id, generate_offset, generate_extern_offset
		end
	ENCODER
		export
			{NONE} all
		end

creation

	make

feature {NONE} -- Initialization

	make (comp_id: INTEGER) is
			-- Create a new counter associated with `comp_id'.
		do
			compilation_id := comp_id
		end

feature -- Access

	next_id: P_REAL_BODY_ID is
			-- Next real body id
		do
			count := count + 1;
			!! Result.make (count, compilation_id)
		end

feature -- Generation

	generate_offset (file: INDENT_FILE) is
			-- Generate `offset' declaration into `file'.
		local
			buff: STRING
		do
			buff := Real_body_id_offset_buffer;
			eif011 ($buff, compilation_id);
			file.putstring ("int32 ");
			file.putstring (buff);
			file.putstring (" = ");
			file.putint (offset);
			file.putstring (";%N")
		end

	generate_extern_offset (file: INDENT_FILE) is
			-- Generate `offset' declaration into `file'.
		local
			buff: STRING
		do
			buff := Real_body_id_offset_buffer;
			eif011 ($buff, compilation_id);
			file.putstring ("extern int32 ");
			file.putstring (buff);
			file.putstring (";%N")
		end

end -- class P_REAL_BODY_ID_SUBCOUNTER
