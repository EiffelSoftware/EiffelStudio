indexing
	description: "Representation of an Eiffel developer exception."
	date: "$Date$"
	revision: "$Revision$"

class
	EIFFEL_EXCEPTION

inherit
	APPLICATION_EXCEPTION
		rename
			make as exc_make
		undefine
			finalize,
			equals,
			to_string,
			get_hash_code
		end

	EXCEP_CONST

create
	make

feature {NONE} -- Initialization

	make (a_code: INTEGER; a_tag: STRING) is
			-- Create an exception with the given Eiffel code.
		require
			valid_code: valid_code (a_code)
		do
			code := a_code
			tag := clone (a_tag)
		ensure
			code_set: code = a_code
			tag_set: equal (tag, a_tag)
		end

feature -- Access

	code: INTEGER
			-- Eiffel code describing the type of exception
			-- (see EXCEPT_CONST for more information).

	tag: STRING
			-- Additional information concerning current exception.

invariant
	valid_code: valid_code (code)

end -- class EIFFEL_EXCEPTION
