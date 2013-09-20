note
	description: "Represents an error that doesn't fit into a category."
	author: "Roman Schmocker"
	date: "$Date$"
	revision: "$Revision$"

class
	PS_GENERAL_ERROR

inherit

	PS_ERROR
	redefine
		description
	end

create
	make

feature

	description: STRING
			-- A human-readable string containing an error description

	accept (a_visitor: PS_ERROR_VISITOR)
			-- `accept' function of the visitor pattern
		do
			a_visitor.visit_general_error (Current)
		end

	make (desc: STRING)
			-- Initialization for `Current'
		do
			description := desc
		end

end
