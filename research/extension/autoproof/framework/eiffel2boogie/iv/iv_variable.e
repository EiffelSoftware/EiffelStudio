note
	description: "[
		TODO
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	IV_VARIABLE

inherit

	IV_DECLARATION

	IV_ENTITY_DECLARATION

create
	make

feature -- Visitor

	process (a_visitor: IV_UNIVERSE_VISITOR)
			-- <Precursor>
		do
			a_visitor.process_variable (Current)
		end

end
