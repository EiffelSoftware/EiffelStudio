indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_EXCEPTION

inherit
	APPLICATION_EXCEPTION
		rename
			make as exc_make
		end

	EXCEP_CONST
		undefine
			finalize,
			equals,
			to_string,
			get_hash_code
			
		end

create
	make

feature {NONE} -- Initialization

	make (l_code: INTEGER; l_tag: STRING) is
			-- Create an exception with the given Eiffel code.
		require
			valid_code: valid_code (code)
		do
			exc_make
			code := l_code
			tag := l_tag
		end

feature -- Access

	code: INTEGER
			-- Eiffel code describing the type of exception
			-- (see EXCEPT_CONST for more information).

	tag: STRING
			-- Additional information concerning current exception.

end -- class EIFFEL_EXCEPTION
