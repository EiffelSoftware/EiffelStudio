-- Encapsulation of integer values into ids

class INTEGER_ID

inherit

	COMPILER_ID
		redefine
			id
		end

creation

	make

feature -- Access

	id: INTEGER is
			-- System-level unique value for the current id
		do
			Result := internal_id
		end;

feature {NONE} -- Not applicable

	counter: COMPILER_SUBCOUNTER is
			-- Counter associated with the id
		do
		end;

end -- class INTEGER_ID
