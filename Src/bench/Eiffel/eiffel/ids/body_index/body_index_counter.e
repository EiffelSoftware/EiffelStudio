-- System level body index counter.

class BODY_INDEX_COUNTER

inherit

	COMPILER_COUNTER
		redefine
			next_id, current_subcounter
		end

creation

	make

feature -- Initialization

	new_subcounter (compilation_id: INTEGER): BODY_INDEX_SUBCOUNTER is
			-- New body index counter associated with `compilation_id'
		do
			if Compilation_modes.is_precompiling then
				!P_BODY_INDEX_SUBCOUNTER! Result.make (compilation_id)
			else
				!BODY_INDEX_SUBCOUNTER! Result.make
			end
		end

feature -- Access

	next_id: BODY_INDEX is
			-- Next body index
		do
			Result := current_subcounter.next_id
		end

feature {NONE} -- Implementation

	current_subcounter: BODY_INDEX_SUBCOUNTER;
			-- Current body index subcounter

end -- class BODY_INDEX_COUNTER
