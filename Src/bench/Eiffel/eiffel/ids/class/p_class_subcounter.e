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

	generate_offset (buffer: GENERATION_BUFFER) is
			-- Generate `offset' declaration into `buffer'.
		local
			buff: STRING
		do
			buff := Offset_buffer;
			eif011 ($buff, compilation_id);
			buffer.putstring ("int32 ");
			buffer.putstring (buff);
			buffer.putstring (" = ");
			buffer.putint (offset);
			buffer.putstring (";%N");
		end

	generate_extern_offset (buffer: GENERATION_BUFFER) is
			-- Generate `offset' declaration into `buffer'.
		local
			buff: STRING
		do
			buff := Offset_buffer;
			eif011 ($buff, compilation_id);
			buffer.putstring ("extern int32 ");
			buffer.putstring (buff);
			buffer.putstring (";%N")
		end

end -- class P_CLASS_SUBCOUNTER
