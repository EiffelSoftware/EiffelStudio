note
	description: "[
			Objects that ...
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	FILE

feature -- Element change

	put_string (s: STRING)
			-- Write `s' at end of default output.
		require
			string_not_void: s /= Void
		do
			{SYSTEM_CONSOLE}.write_line (s)
		end

end
