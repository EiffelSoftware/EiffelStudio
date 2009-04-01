note
	description: "[
		{XH_GET_REQUEST}.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XH_GET_REQUEST

inherit
	XH_REQUEST
		redefine
			make_from_string
		end

create
	make_from_string,
	make_empty

feature -- Initialization

	make_from_string (a_string: STRING)
			-- <Precursor>
		require else
			is_get: a_string.item (1).is_equal (Method_get)
		do
			Precursor (a_string)
		ensure then
			parameters_set: attached parameters
		end

feature -- Access

	Method_get: CHARACTER = 'G'

feature -- Implementation

	key_params: STRING
		do
			Result := "#G#"
		end

	read_uri (a_the_request: STRING): STRING
		require else
			is_get: a_the_request.item (1).is_equal (Method_get)
		local
			l_i: INTEGER
		do
			if a_the_request.has_substring ("?") then
				l_i := a_the_request.substring_index ("?",1)
				Result := a_the_request.substring (5, l_i-1)
			else
				l_i := a_the_request.substring_index ("HTTP",1)
				Result := a_the_request.substring (5, l_i-2)
			end
		end

end
