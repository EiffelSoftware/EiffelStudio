-- Class id counter associated with a compilation unit.

class CLASS_SUBCOUNTER

inherit

	COMPILER_SUBCOUNTER
			
creation

	make

feature -- Access

	next_id: CLASS_ID is
			-- Next class id
		do
			count := count + 1;
			!! Result.make (count)
		end

	next_protected_id: CLASS_ID is
			-- Next protected class id
		do
			count := count + 1
			!PROTECTED_CLASS_ID! Result.make (count)
		ensure
			id_not_void: Result /= Void;
			protected: Result.protected
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

end -- class CLASS_SUBCOUNTER
