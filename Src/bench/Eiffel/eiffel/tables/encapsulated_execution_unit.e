indexing
	description: "Execution unit for an Eiffel feature that needs a special encapsulation%
		%(eg attribute or constant)."
	date: "$Date$"
	revision: "$Revision$"

class
	ENCAPSULATED_EXECUTION_UNIT

inherit
	EXECUTION_UNIT
		redefine
			is_encapsulated
		end

create
	make

feature -- Access

	is_encapsulated: BOOLEAN is True
			-- Mark current has being encapsulated

end -- class ENCAPSULATED_EXECUTION_UNIT
