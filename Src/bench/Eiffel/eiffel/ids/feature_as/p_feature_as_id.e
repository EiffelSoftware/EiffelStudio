-- Precompiled FEATURE_AS ids.

class P_FEATURE_AS_ID

inherit

	P_COMPILER_ID;
	FEATURE_AS_ID
		rename
			make as make_id
		undefine
			compilation_id, is_precompiled
		end

creation

	make

end -- class P_FEATURE_AS_ID
