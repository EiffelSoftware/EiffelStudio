-- Routine id counter associated with a precompilation.

class P_ROUTINE_SUBCOUNTER

inherit

	P_COMPILER_SUBCOUNTER [ROUTINE_ID]
		rename
			next_id as next_rout_id
		end;
	ROUTINE_SUBCOUNTER
		rename
			make as csc_make
		undefine
			prefix_string
		redefine
			next_attr_id, next_rout_id
		end

creation

	make

feature -- Access

	next_rout_id: P_ROUTINE_ID is
			-- Next routine id
		do
			count := count + 1;
			!! Result.make (count, compilation_id)
		end;

	next_attr_id: P_ATTRIBUTE_ID is
			-- Next attribute id
		do
			count := count + 1;
			!! Result.make (count, compilation_id)
		end;

end -- class P_ROUTINE_SUBCOUNTER
