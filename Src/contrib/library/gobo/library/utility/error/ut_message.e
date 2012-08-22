note

	description:

		"General messages"

	library: "Gobo Eiffel Utility Library"
	copyright: "Copyright (c) 1999-2011, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class UT_MESSAGE

inherit

	UT_ERROR

create

	make

feature {NONE} -- Initialization

	make (msg: STRING)
			-- Create a new message object.
		require
			msg_not_void: msg /= Void
		do
			create parameters.make_filled (empty_string, 1, 1)
			parameters.put (msg, 1)
		end

feature -- Access

	default_template: STRING = "$1"
			-- Default template used to built the error message

	code: STRING = "UT0008"
			-- Error code

invariant

	-- dollar0: $0 = program name
	-- dollar1: $1 = message

end
