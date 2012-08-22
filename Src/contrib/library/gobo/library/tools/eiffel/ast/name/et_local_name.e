note

	description:

		"Eiffel local names"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2002, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

deferred class ET_LOCAL_NAME

inherit

	ET_EXPRESSION

feature -- Access

	identifier: ET_IDENTIFIER
			-- Identifier
		deferred
		ensure
			identifier_not_void: Result /= Void
		end

end
