-- Pattern id counter associated with a DC-set.

class DLE_PATTERN_ID_SUBCOUNTER

inherit

	DLE_COMPILER_SUBCOUNTER;
	PATTERN_ID_SUBCOUNTER
		redefine
			next_id
		end

creation

	make

feature -- Access

	next_id: DLE_PATTERN_ID is
			-- Next pattern id
		do
			count := count + 1;
			!! Result.make (count);
		end;

end -- class DLE_PATTERN_ID_SUBCOUNTER
