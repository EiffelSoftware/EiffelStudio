-- Routine id counter associated with a precompilation.

class P_ROUTINE_SUBCOUNTER

inherit

	P_COMPILER_SUBCOUNTER
		rename
			next_id as next_rout_id
		redefine
			make
		end;
	ROUTINE_SUBCOUNTER
		rename
			make as csc_make
		redefine
			next_attr_id, next_rout_id, prefix_name
		end

creation

	make

feature {NONE} -- Initialization

	make (comp_id: INTEGER) is
			-- Create a new counter associated with `comp_id'.
		do
			compilation_id := comp_id;
			prefix_name := "P";
			prefix_name.append_integer (comp_id)
		end

feature -- Access

	next_rout_id: P_ROUTINE_ID is
			-- Next routine id
		do
			count := count + 1;
			!! Result.make (count, compilation_id)
		end;

	next_attr_id: P_ATTRIBUTE_ID is
			-- Next attribute id
		do
			count := count + 1;
			!! Result.make (count, compilation_id)
		end;

feature {ROUTINE_ID} -- Implementation

	prefix_name: STRING;
			-- Prefix for generated C function and table names

end -- class P_ROUTINE_SUBCOUNTER
