-- Real body id counter associated with a compilation unit.

class REAL_BODY_ID_SUBCOUNTER

inherit

	COMPILER_SUBCOUNTER
			
creation

	make

feature -- Access

	next_id: REAL_BODY_ID is
			-- Next real body id
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

end -- class REAL_BODY_ID_SUBCOUNTER
