note
	description: "[
		A base token for implementing tokens located in a tokenized code template token list.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	CODE_TOKEN

inherit
	DEBUG_OUTPUT
		redefine
			out
		end

feature -- Query

	is_valid_text (a_text: READABLE_STRING_GENERAL): BOOLEAN
			-- Determines if a token string representation is a valid text for the code token.
			--
			-- `a_text': A string representation of the token.
			-- `Result': True if the text is valid for the current token; False otherwise.
		require
			a_text_attached: attached a_text
		deferred
		end

feature -- Access

	printable_text: like text
			-- Printable representation of `text'.
		do
			Result := text
		ensure
			result_attached: attached Result
		end

	text: STRING_32
			-- The token text.
		deferred
		ensure
			result_attached: attached Result
			result_is_valid_text: is_valid_text (Result)
		end

feature -- Status report

	is_editable: BOOLEAN
			-- Is the token editable.
		deferred
		end

feature -- Visitor

	process (a_visitor: CODE_TOKEN_VISITOR_I)
			-- Visit's the current token and processes it.
		require
			a_visitor_attached: attached a_visitor
			a_visitor_is_interface_usable: a_visitor.is_interface_usable
		deferred
		end

feature -- Output

	out: STRING
			-- <Precursor>
		do
			Result :=
				if attached {STRING} text as t then
					t
				else
					{UTF_CONVERTER}.string_32_to_utf_8_string_8 (text)
				end
		end

	debug_output: READABLE_STRING_32
			-- <Precursor>
		do
			Result := text
		end

invariant
	text_attached: attached text
	text_is_valid_text: is_valid_text (text)

;note
	copyright:	"Copyright (c) 1984-2023, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
