-- Server file id counter associated with a compilation unit.

class FILE_SUBCOUNTER

inherit

	COMPILER_SUBCOUNTER
			
creation

	make

feature -- Access

	next_id: FILE_ID is
			-- Next server file id
		do
			count := count + 1;
			!! Result.make (count)
		end

end -- class FILE_SUBCOUNTER
