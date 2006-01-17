indexing
	description: "Text item to represent a class syntax error."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class CL_SYNTAX_ITEM
