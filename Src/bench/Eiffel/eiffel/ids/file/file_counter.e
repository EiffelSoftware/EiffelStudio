-- System level server file counter.

class
	FILE_COUNTER

inherit
	COMPILER_COUNTER
		redefine
			next_id, current_subcounter
		end

creation

	make

feature -- Initialization

	new_subcounter (compilation_id: INTEGER): FILE_SUBCOUNTER is
			-- New file id counter associated with `compilation_id'
		do
			if Compilation_modes.is_precompiling then
				!P_FILE_SUBCOUNTER! Result.make (compilation_id)
			else
				!FILE_SUBCOUNTER! Result.make
			end
		end

feature -- Access

	next_id: FILE_ID is
			-- Next server file id
		do
			Result := current_subcounter.next_id
		end

feature {NONE} -- Implementation

	current_subcounter: FILE_SUBCOUNTER;
			-- Current file id subcounter

end -- class FILE_COUNTER
