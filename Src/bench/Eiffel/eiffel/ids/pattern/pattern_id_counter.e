-- System level pattern id counter.

class PATTERN_ID_COUNTER

inherit

	COMPILER_COUNTER
		redefine
			next_id, current_subcounter
		end

creation

	make

feature -- Initialization

	new_subcounter (compilation_id: INTEGER): PATTERN_ID_SUBCOUNTER is
			-- New pattern id counter associated with `compilation_id'
		do
			if Compilation_modes.is_precompiling then
				!P_PATTERN_ID_SUBCOUNTER! Result.make (compilation_id)
			else
				!PATTERN_ID_SUBCOUNTER! Result.make
			end
		end

feature -- Access

	next_id: PATTERN_ID is
			-- Next pattern id
		do
			Result := current_subcounter.next_id
		end

feature {NONE} -- Implementation

	current_subcounter: PATTERN_ID_SUBCOUNTER;
			-- Current pattern id subcounter

end -- class PATTERN_ID_COUNTER
