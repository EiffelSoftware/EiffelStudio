indexing

	description:

		"General messages"

	library: "Gobo Eiffel Utility Library"
	copyright: "Copyright (c) 1999, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class UT_MESSAGE

inherit

	UT_ERROR

create

	make

feature {NONE} -- Initialization

	make (msg: STRING) is
			-- Create a new message object.
		require
			msg_not_void: msg /= Void
		do
			create parameters.make (1, 1)
			parameters.put (msg, 1)
		end

feature -- Access

	default_template: STRING is "$1"
			-- Default template used to built the error message

	code: STRING is "UT0008"
			-- Error code

invariant

	-- dollar0: $0 = program name
	-- dollar1: $1 = message

end
