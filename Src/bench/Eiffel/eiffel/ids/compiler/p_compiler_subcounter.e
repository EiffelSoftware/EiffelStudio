-- Counter associated with a precompilation.

deferred class P_COMPILER_SUBCOUNTER [G -> COMPILER_ID]

inherit

	COMPILER_SUBCOUNTER [G]
		rename
			make as csc_make
		redefine
			prefix_string
		end

feature {NONE} -- Initialization

	make (comp_id: INTEGER) is
			-- Create a new counter associated with `comp_id'.
		do
			compilation_id := comp_id;
			prefix_string := "P";
			prefix_string.append_integer (comp_id)
		end;

feature -- Access

	compilation_id: INTEGER;
			-- Compilation id associated with counter

	prefix_string: STRING;
			-- Prefix for generated C function and table names

end -- class P_COMPILER_SUBCOUNTER
