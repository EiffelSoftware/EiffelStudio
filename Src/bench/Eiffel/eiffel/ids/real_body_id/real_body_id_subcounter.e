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
			file_not_void: buffer /= Void;
		do
			-- Do nothing (offset not needed)
		end

end -- class REAL_BODY_ID_SUBCOUNTER
