note
	description: "[
		Contains all information of a rfc2109 cookie that was read from the request header
	]"
	legal: "See notice at end of class."
	status: "Prototyping phase"
	date: "$Date$"
	revision: "$Revision$"

class
	XH_COOKIE

create
	make

feature {NONE} -- Initialization	

	make (a_name: STRING; a_value: STRING)
			-- Create current
		require
			a_name_not_empty: not a_name.is_empty
			a_value_not_empty: not a_Value.is_empty
		do
			name := a_name
			value := a_value
		ensure
			a_name_set: name = a_name
			a_value_set: value = a_value
		end

feature -- Access

	name: STRING
		-- The name of the cooklie

	value: STRING
		-- The value of the cookie

end
