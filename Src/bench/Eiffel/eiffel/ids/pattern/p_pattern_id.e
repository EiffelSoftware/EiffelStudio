-- Precompiled pattern ids

class P_PATTERN_ID

inherit

	P_COMPILER_ID;
	PATTERN_ID
		rename
			make as make_id
		undefine
			compilation_id, is_precompiled
		end

creation

	make

end -- class P_PATTERN_ID
