-- Body index counter associated with a precompilation.

class P_BODY_INDEX_SUBCOUNTER

inherit

	P_COMPILER_SUBCOUNTER
		redefine
			make
		end
	BODY_INDEX_SUBCOUNTER
		rename
			make as csc_make
		redefine
			next_id
		end

creation

	make

feature {NONE} -- Initialization

	make (comp_id: INTEGER) is
			-- Create a new counter associated with `comp_id'.
		do
			compilation_id := comp_id
		end

feature -- Access

	next_id: P_BODY_INDEX is
			-- Next body index
		do
			count := count + 1;
			!! Result.make (count, compilation_id)
		end

end -- class P_BODY_INDEX_SUBCOUNTER
