-- Precompiled real body ids.

class P_REAL_BODY_ID

inherit

	P_COMPILER_ID;
	REAL_BODY_ID
		rename
			make as make_id
		undefine
			compilation_id, is_precompiled
		end

creation

	make

end -- class P_REAL_BODY_ID
