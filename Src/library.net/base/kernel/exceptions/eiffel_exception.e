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
		end

create
	make

feature {NONE} -- Initialization

	make (a_code: INTEGER; a_tag: STRING) is
			-- Create an exception with the given Eiffel code.
		require
			valid_code: (create {EXCEP_CONST}).valid_code (a_code)
		local
			default: STRING
		do
			code := a_code
			if a_tag /= default then
				create tag.make_from_string (a_tag)
			end
		ensure
			code_set: code = a_code
			tag_set: tag /= a_tag implies tag.is_equal (a_tag)
		end

feature -- Access

	code: INTEGER
			-- Eiffel code describing the type of exception
			-- (see EXCEPT_CONST for more information).

	tag: STRING
			-- Additional information concerning current exception.

invariant
	valid_code: (create {EXCEP_CONST}).valid_code (code)

end -- class EIFFEL_EXCEPTION
