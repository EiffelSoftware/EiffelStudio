-- Body id counter associated with a compilation unit.

class BODY_ID_SUBCOUNTER

inherit

	COMPILER_SUBCOUNTER
			
creation

	make

feature -- Access

	next_id: BODY_ID is
			-- Next body id
		do
			count := count + 1;
			!! Result.make (count)
		end

feature {BODY_ID} -- Implementation

	prefix_name: STRING is
			-- Prefix for generated C function names
		once
			Result := ""
		end

end -- class BODY_ID_SUBCOUNTER
