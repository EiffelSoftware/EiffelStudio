-- Class counter associated with a precompilation.

class P_CLASS_SUBCOUNTER

inherit

	P_COMPILER_SUBCOUNTER;

	CLASS_SUBCOUNTER
		rename
			make as csc_make
		redefine
			next_id, next_protected_id,
			generate_offset, generate_extern_offset
		end;

	ENCODER
		export
			{NONE} all
		end

creation

	make

feature -- Access

	next_id: P_CLASS_ID is
			-- Next class id
		do
			count := count + 1;
			!! Result.make (count, compilation_id)
		end

	 next_protected_id: P_CLASS_ID is
			-- Next protected class id
		do
			count := count + 1;
			!P_PROTECTED_CLASS_ID! Result.make (count, compilation_id)
		end

feature -- Generation

	generate_offset (file: INDENT_FILE) is
			-- Generate `offset' declaration into `file'.
		local
			buff: STRING
		do
			buff := Offset_buffer;
			eif011 ($buff, compilation_id);
			file.putstring ("int32 ");
			file.putstring (buff);
			file.putstring (" = ");
			file.putint (offset);
			file.putstring (";%N");
		end

	generate_extern_offset (file: INDENT_FILE) is
			-- Generate `offset' declaration into `file'.
		local
			buff: STRING
		do
			buff := Offset_buffer;
			eif011 ($buff, compilation_id);
			file.putstring ("extern int32 ");
			file.putstring (buff);
			file.putstring (";%N")
		end

end -- class P_CLASS_SUBCOUNTER
