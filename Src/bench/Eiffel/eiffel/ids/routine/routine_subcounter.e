-- Routine id counter associated with a compilation unit (i.e. precompilation,
-- normal compilation or dle compilation).

class ROUTINE_SUBCOUNTER

inherit

	COMPILER_SUBCOUNTER [ROUTINE_ID]
		rename
			next_id as next_rout_id
		end

creation

	make

feature -- Access

	next_rout_id: ROUTINE_ID is
			-- Next routine id
		do
			count := count + 1;
			!! Result.make (count)
		end;

	next_attr_id: ATTRIBUTE_ID is
			-- Next attribute id
		do
			count := count + 1;
			!! Result.make (count)
		ensure
			next_attr_id_not_void: Result /= Void
		end;

end -- class ROUTINE_SUBCOUNTER
