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

	generate_offset (file: INDENT_FILE) is
			-- Generate `offset' declaration into `file'.
		require
			file_not_void: file /= Void;
			file_open_write: file.is_open_write
		do
			-- Do nothing (offset not needed)
		end

	generate_extern_offset (file: INDENT_FILE) is
			-- Generate `offset' extern declaration into `file'.
		require
			file_not_void: file /= Void;
			file_open_write: file.is_open_write
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
