-- Static type id counter associated with a compilation unit.

class TYPE_SUBCOUNTER

inherit

	COMPILER_SUBCOUNTER
			
creation

	make

feature -- Access

	next_id: TYPE_ID is
			-- Next static type id
		do
			count := count + 1;
			!! Result.make (count)
		end

feature {TYPE_ID} -- Implementation

	prefix_name: STRING is
			-- Prefix for generated C function names
		once
			Result := ""
		end

end -- class TYPE_SUBCOUNTER
