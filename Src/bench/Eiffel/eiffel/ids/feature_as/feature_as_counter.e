-- System level FEATURE_AS counter.

class FEATURE_AS_COUNTER

inherit

	COMPILER_COUNTER
		redefine
			next_id, current_subcounter
		end

creation

	make

feature -- Initialization

	new_subcounter (compilation_id: INTEGER): FEATURE_AS_SUBCOUNTER is
			-- New FEATURE_AS id counter associated with `compilation_id'
		do
			if Compilation_modes.is_precompiling then
				!P_FEATURE_AS_SUBCOUNTER! Result.make (compilation_id)
			else
				!FEATURE_AS_SUBCOUNTER! Result.make
			end
		end

feature -- Access

	next_id: FEATURE_AS_ID is
			-- Next FEATURE_AS id
		do
			Result := current_subcounter.next_id
		end

feature {NONE} -- Implementation

	current_subcounter: FEATURE_AS_SUBCOUNTER;
			-- Current feature_as id subcounter

end -- class FEATURE_AS_COUNTER
