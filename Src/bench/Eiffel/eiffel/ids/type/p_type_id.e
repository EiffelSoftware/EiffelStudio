-- Precompiled static type ids.

class P_TYPE_ID

inherit

	P_COMPILER_ID;
	TYPE_ID
		rename
			make as make_id
		undefine
			compilation_id, is_precompiled
		end

creation

	make

end -- class P_TYPE_ID
