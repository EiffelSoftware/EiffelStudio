-- Precompiled body indexes.

class P_BODY_INDEX

inherit

	P_COMPILER_ID;
	BODY_INDEX
		rename
			make as make_id
		undefine
			compilation_id, is_precompiled
		end

creation

	make

end -- class P_BODY_INDEX
