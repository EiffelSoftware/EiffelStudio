-- Body id counter associated with a precompilation.

class P_BODY_ID_SUBCOUNTER

inherit

	P_COMPILER_SUBCOUNTER
		redefine
			make
		end
	BODY_ID_SUBCOUNTER
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
			compilation_id := comp_id
		end

feature -- Access

	next_id: P_BODY_ID is
			-- Next body id
		do
			count := count + 1;
			!! Result.make (count, compilation_id)
		end

feature {BODY_ID} -- Implementation

	prefix_name (type_id: TYPE_ID): STRING is
			-- Prefix for generated C function names
		local
			p_type_id: P_TYPE_ID
		do
			p_type_id ?= type_id;
			if p_type_id /= Void then
				Result := P_buffer;
				eif000 ($Result, type_id.compilation_id, compilation_id)
			else
				Result := C_buffer;
				eif011 ($Result, compilation_id)
			end
		end

end -- class P_BODY_ID_SUBCOUNTER
