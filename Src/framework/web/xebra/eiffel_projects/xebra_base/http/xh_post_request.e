note
	description: "[
		{XH_POST_REQUEST}.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	XH_POST_REQUEST

inherit
	XH_REQUEST
		redefine
			make_from_string
		end

create
	make_from_string,
	make_empty

feature {NONE} -- Initialization

	make_from_string (a_string: STRING)
			-- <Precursor>
		require else
			is_post: a_string.item (1).is_equal (Method_post)
		do
			Precursor (a_string)
		ensure then
			arguments_set: attached arguments
		end

feature -- Access

	Method_post: CHARACTER = 'P'

feature -- Implementation

	key_params: STRING
		do
			Result := "#P#"
		end

	read_uri (a_the_request: STRING): STRING
		require else
			is_get: a_the_request.item (1).is_equal (Method_post)
		local
			l_i: INTEGER
		do
			l_i := a_the_request.substring_index ("HTTP",1)
			Result := a_the_request.substring (6, l_i-2)
		end
end
