-- DC-set FEATURE_AS ids

class DLE_FEATURE_AS_ID

inherit

	DLE_COMPILER_ID;
	FEATURE_AS_ID
		undefine
			is_dynamic, compilation_id
		redefine
			counter
		end

creation

	make

feature {NONE} -- Implementation

	counter: FEATURE_AS_SUBCOUNTER is
			-- Counter associated with the id
		once
			Result := Feature_as_counter.item (Dle_compilation)
		end

end -- class DLE_FEATURE_AS_ID
