-- Counter associated with a precompilation.

deferred class P_COMPILER_SUBCOUNTER

inherit

	COMPILER_SUBCOUNTER
		rename
			make as csc_make
		end

feature {NONE} -- Initialization

	make (comp_id: INTEGER) is
			-- Create a new counter associated with `comp_id'.
		do
			compilation_id := comp_id
		end;

feature -- Access

	next_id: P_COMPILER_ID is
			-- Next id
		deferred
		end

	compilation_id: INTEGER;
			-- Compilation id associated with counter

end -- class P_COMPILER_SUBCOUNTER
