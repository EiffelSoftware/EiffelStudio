-- FEATURE_AS id counter associated with a DC-set.

class DLE_FEATURE_AS_SUBCOUNTER

inherit

	DLE_COMPILER_SUBCOUNTER;
	FEATURE_AS_SUBCOUNTER
		redefine
			next_id
		end

creation

	make

feature -- Access

	next_id: DLE_FEATURE_AS_ID is
			-- Next FEATURE_AS id
		do
			count := count + 1;
			!! Result.make (count)
		end;

end -- class DLE_FEATURE_AS_SUBCOUNTER
