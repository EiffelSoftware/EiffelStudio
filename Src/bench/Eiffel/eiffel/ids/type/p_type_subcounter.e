-- Static type counter associated with a precompilation.

class P_TYPE_SUBCOUNTER

inherit

	P_COMPILER_SUBCOUNTER
		redefine
			make
		end
	TYPE_SUBCOUNTER
		rename
			make as csc_make
		redefine
			next_id, prefix_name
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

	next_id: P_TYPE_ID is
			-- Next static type id
		do
			count := count + 1;
			!! Result.make (count, compilation_id)
		end

feature {TYPE_ID} -- Implementation

	prefix_name: STRING;
			-- Prefix for generated C function names

end -- class P_TYPE_SUBCOUNTER
