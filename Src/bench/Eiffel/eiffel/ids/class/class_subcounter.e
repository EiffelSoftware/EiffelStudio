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

	generate_offset (buffer: GENERATION_BUFFER) is
			-- Generate `offset' declaration into `file'.
		require
			buffer_not_void: buffer /= Void;
		do
			-- Do nothing (offset not needed)
		end

	generate_extern_offset (buffer: GENERATION_BUFFER) is
			-- Generate `offset' extern declaration into `buffer'.
		require
			buffer_not_void: buffer /= Void
		do
			-- Do nothing (offset not needed)
		end

end -- class CLASS_SUBCOUNTER
