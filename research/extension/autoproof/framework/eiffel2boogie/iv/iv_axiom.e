note
	description: "[
		TODO
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	IV_AXIOM

inherit

	IV_DECLARATION

inherit {NONE}

	IV_ASSERTION

create
	make

feature -- Visitor

	process (a_visitor: IV_UNIVERSE_VISITOR)
			-- <Precursor>
		do
			a_visitor.process_axiom (Current)
		end

end
