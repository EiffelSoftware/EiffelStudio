-- FEATURE_AS ids.

class FEATURE_AS_ID

inherit

	COMPILER_ID

creation

	make

feature {NONE} -- Implementation

	counter: FEATURE_AS_SUBCOUNTER is
			-- Counter associated with the id
		once
			Result := Feature_as_counter.item (Normal_compilation)
		end

end -- class FEATURE_AS_ID
