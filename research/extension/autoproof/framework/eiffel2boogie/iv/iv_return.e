note
	description: "[
		TODO
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	IV_RETURN

inherit

	IV_STATEMENT

feature {NONE} -- Initialization

	make
			-- Initialize return statement.
		do
		end

feature -- Visitor

	process (a_visitor: IV_STATEMENT_VISITOR)
			-- <Precursor>
		do
			a_visitor.process_return (Current)
		end

end
