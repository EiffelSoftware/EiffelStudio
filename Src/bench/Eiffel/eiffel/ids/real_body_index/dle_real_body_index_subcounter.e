-- Real body index counter associated with a DC-set.

class DLE_REAL_BODY_INDEX_SUBCOUNTER

inherit

	DLE_COMPILER_SUBCOUNTER;
	REAL_BODY_INDEX_SUBCOUNTER
		redefine
			next_id
		end

creation

	make

feature -- Access

	next_id: DLE_REAL_BODY_INDEX is
			-- Next real body index
		do
			count := count + 1;
			!! Result.make (count);
		end;

end -- class DLE_REAL_BODY_INDEX_SUBCOUNTER
