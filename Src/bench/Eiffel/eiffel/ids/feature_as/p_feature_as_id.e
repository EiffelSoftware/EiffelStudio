-- Precompiled FEATURE_AS ids.

class P_FEATURE_AS_ID

inherit

	P_COMPILER_ID;
	FEATURE_AS_ID
		rename
			make as make_id
		undefine
			compilation_id, is_precompiled
		redefine
			counter
		end

creation

	make

feature {NONE} -- Implementation

	counter: FEATURE_AS_SUBCOUNTER is
			-- Counter associated with the id
		do
			Result := Feature_as_counter.item (compilation_id)
		end

end -- class P_FEATURE_AS_ID
