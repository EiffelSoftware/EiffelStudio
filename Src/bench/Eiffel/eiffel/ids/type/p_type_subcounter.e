-- Static type counter associated with a precompilation.

class P_TYPE_SUBCOUNTER

inherit

	P_COMPILER_SUBCOUNTER
		redefine
			make
		end;
	TYPE_SUBCOUNTER
		rename
			make as csc_make
		redefine
			next_id, prefix_name,
			generate_offset, generate_extern_offset
		end;
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
			compilation_id := comp_id;
			prefix_name := "P000000";
			eif011 ($prefix_name, comp_id)
		end

feature -- Access

	next_id: P_TYPE_ID is
			-- Next static type id
		do
			count := count + 1;
			!! Result.make (count, compilation_id)
		end

feature -- Generation

	generate_offset (buffer: GENERATION_BUFFER) is
			-- Generate `offset' declaration into `buffer'.
		local
			buff: STRING
		do
			buff := Type_offset_buffer;
			eif011 ($buff, compilation_id);
			buffer.putstring ("int32 ");
			buffer.putstring (buff);
			buffer.putstring (" = ");
			buffer.putint (offset);
			buffer.putstring (";%N")
		end

	generate_extern_offset (buffer: GENERATION_BUFFER) is
			-- Generate `offset' declaration into `buffer'.
		local
			buff: STRING
		do
			buff := Type_offset_buffer;
			eif011 ($buff, compilation_id);
			buffer.putstring ("extern int32 ");
			buffer.putstring (buff);
			buffer.putstring (";%N")
		end
			
feature {TYPE_ID} -- Implementation

	prefix_name: STRING;
			-- Prefix for generated C function names

end -- class P_TYPE_SUBCOUNTER
