-- Server file id counter associated with a DC-set.

class DLE_FILE_SUBCOUNTER

inherit

	DLE_COMPILER_SUBCOUNTER;
	FILE_SUBCOUNTER
		redefine
			next_id
		end

creation

	make

feature -- Access

	next_id: DLE_FILE_ID is
			-- Next server file id
		do
			count := count + 1;
			!! Result.make (count)
		end;

end -- class DLE_FILE_SUBCOUNTER
