-- Precompiled server file ids.

class P_FILE_ID

inherit

	P_COMPILER_ID;
	FILE_ID
		rename
			make as make_id
		undefine
			compilation_id, is_precompiled
		end

creation

	make

end -- class P_FILE_ID
