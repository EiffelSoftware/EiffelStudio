-- Server file counter associated with a precompilation.

class P_FILE_SUBCOUNTER

inherit

	P_COMPILER_SUBCOUNTER
	FILE_SUBCOUNTER
		rename
			make as csc_make
		redefine
			next_id
		end

creation

	make

feature -- Access

	next_id: P_FILE_ID is
			-- Next server file id
		do
			count := count + 1;
			!! Result.make (count, compilation_id)
		end

end -- class P_FILE_SUBCOUNTER
