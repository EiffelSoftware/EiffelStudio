-- System level real body index counter.

class REAL_BODY_INDEX_COUNTER

inherit

	COMPILER_COUNTER
		redefine
			next_id, current_subcounter
		end

creation

	make

feature -- Initialization

	new_subcounter (compilation_id: INTEGER): REAL_BODY_INDEX_SUBCOUNTER is
			-- New real body index counter associated with `compilation_id'
		do
			if Compilation_modes.is_precompiling then
				!P_REAL_BODY_INDEX_SUBCOUNTER! Result.make (compilation_id)
			elseif Compilation_modes.is_extending then
				!DLE_REAL_BODY_INDEX_SUBCOUNTER! Result.make
			else
				!REAL_BODY_INDEX_SUBCOUNTER! Result.make
			end
		end

feature -- Access

	next_id: REAL_BODY_INDEX is
			-- Next real body index
		do
			Result := current_subcounter.next_id
		end

feature {NONE} -- Implementation

	current_subcounter: REAL_BODY_INDEX_SUBCOUNTER;
			-- Current real body index subcounter

end -- class REAL_BODY_INDEX_COUNTER
