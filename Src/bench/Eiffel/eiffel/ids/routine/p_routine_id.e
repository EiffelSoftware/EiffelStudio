-- Precompiled Routine Ids

class P_ROUTINE_ID

inherit

	P_COMPILER_ID;
	ROUTINE_ID
		rename
			make as make_id
		undefine
			compilation_id
		end

creation

	make

end -- class P_ROUTINE_ID
