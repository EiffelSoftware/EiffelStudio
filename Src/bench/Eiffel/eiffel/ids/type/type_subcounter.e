-- Static type id counter associated with a compilation unit.

class TYPE_SUBCOUNTER

inherit

	COMPILER_SUBCOUNTER
			
creation

	make

feature -- Access

	next_id: TYPE_ID is
			-- Next static type id
		do
			count := count + 1;
			!! Result.make (count)
		end

feature -- Generation

	generate_offset (buffer: GENERATION_BUFFER) is
			-- Generate `offset' declaration into `buffer'.
		require
			file_not_void: buffer /= Void;
		do
			-- Do nothing (offset not needed)
		end

	generate_extern_offset (buffer: GENERATION_BUFFER) is
			-- Generate `offset' extern declaration into `buffer'.
		require
			buffer_not_void: buffer /= Void;
		do
			-- Do nothing (offset not needed)
		end

feature {TYPE_ID} -- Implementation

	prefix_name: STRING is
			-- Prefix for generated C function names
		once
			Result := ""
		end

end -- class TYPE_SUBCOUNTER
