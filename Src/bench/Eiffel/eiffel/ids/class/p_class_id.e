-- Precompiled class ids.

class P_CLASS_ID

inherit

	P_COMPILER_ID;
	CLASS_ID
		rename
			make as make_id
		undefine
			compilation_id, is_precompiled
		end

creation

	make

end -- class P_CLASS_ID
