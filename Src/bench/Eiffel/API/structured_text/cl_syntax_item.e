indexing
	description: "Text item to represent a class syntax error."
	date: "$Date$"
	revision: "$Revision$"

class CL_SYNTAX_ITEM

inherit
	ERROR_TEXT
		rename
			make as error_make
		redefine
			append_to
		end

create
	make

feature -- Initialization

	make (a_syntax_message: like syntax_message; c: like e_class; str: like error_text) is
			-- Create Current for `a_syntax_message' in `c' with
			-- `str' as representation.
		require
			a_syntax_message_not_void: a_syntax_message /= Void
			c_not_void: c /= Void
			str_not_void: str /= Void
		do
			syntax_message := a_syntax_message
			e_class := c
			error_text := str
		ensure
			syntax_error_set: equal (syntax_message, a_syntax_message)
			e_class_set: equal (e_class, c)
			erro_text_set: equal (error_text, str)
		end

feature -- Properties

	e_class: CLASS_C
			-- Class where syntax issue has been detected.

	syntax_message: SYNTAX_MESSAGE
			-- Syntax issue that has been detected.

feature {TEXT_FORMATTER} -- Implementation

	append_to (text: TEXT_FORMATTER) is
			-- Append Current to `text'.
		do
			text.process_cl_syntax (Current)
		end

end -- class CL_SYNTAX_ITEM
