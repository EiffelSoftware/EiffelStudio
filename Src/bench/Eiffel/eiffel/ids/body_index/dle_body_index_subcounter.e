-- Body index counter associated with a DC-set.

class DLE_BODY_INDEX_SUBCOUNTER

inherit

	DLE_COMPILER_SUBCOUNTER;
	BODY_INDEX_SUBCOUNTER
		redefine
			next_id
		end

creation

	make

feature -- Access

	next_id: DLE_BODY_INDEX is
			-- Next body index
		do
			count := count + 1;
			!! Result.make (count);
		end;

end -- class DLE_BODY_INDEX_SUBCOUNTER
