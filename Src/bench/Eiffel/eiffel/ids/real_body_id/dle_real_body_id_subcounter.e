-- Real body id counter associated with a DC-set.

class DLE_REAL_BODY_ID_SUBCOUNTER

inherit

	DLE_COMPILER_SUBCOUNTER;
	REAL_BODY_ID_SUBCOUNTER
		redefine
			next_id
		end

creation

	make

feature -- Access

	next_id: DLE_REAL_BODY_ID is
			-- Next real body id
		do
			count := count + 1;
			!! Result.make (count);
		end;

end -- class DLE_REAL_BODY_ID_SUBCOUNTER
