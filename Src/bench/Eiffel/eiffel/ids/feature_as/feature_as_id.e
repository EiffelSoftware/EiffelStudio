-- FEATURE_AS ids.

class FEATURE_AS_ID

inherit

	COMPILER_ID

creation

	make

feature {NONE} -- Implementation

	counter: FEATURE_AS_SUBCOUNTER is
			-- Counter associated with the id
		do
			Result := System.feature_as_counter.item (compilation_id)
		end

end -- class FEATURE_AS_ID
