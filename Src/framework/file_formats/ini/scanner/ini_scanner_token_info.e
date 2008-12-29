note
	description: "Represents a token found when scanning a INI text buffer line."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	INI_SCANNER_TOKEN_INFO

inherit
	DEBUG_OUTPUT
		export
			{NONE}
		end

create
	make

feature {NONE} -- Initialization

	make (a_text: like text; a_type: like type; a_start_index: INTEGER)
			-- Initialize scanner token info.
		require
			a_text_attached: a_text /= Void
			not_a_text_is_empty: not a_text.is_empty
			a_start_index_positive: a_start_index > 0
		do
			text := a_text
			type := a_type
			start_index := a_start_index
		ensure
			text_set: text = a_text
			types_set: type = a_type
			start_index_set: start_index = a_start_index
		end

feature -- Access

	text: STRING
			-- Textual representation of token

	type: INI_SCANNER_TOKEN_TYPE
			-- Type of token

	start_index: INTEGER
			-- Start position index of token

	end_index: INTEGER
			-- End position index of token
		do
			Result := (start_index + text.count) - 1
		end

feature {NONE} -- Status report

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		local
			l_type: STRING
		do
			inspect type.to_integer
			when {INI_SCANNER_TOKEN_TYPE}.assigner then
				l_type := "assigner"
			when {INI_SCANNER_TOKEN_TYPE}.comment then
				l_type := "comment"
			when {INI_SCANNER_TOKEN_TYPE}.identifier then
				l_type := "identifier"
			when {INI_SCANNER_TOKEN_TYPE}.section_close then
				l_type := "section_close"
			when {INI_SCANNER_TOKEN_TYPE}.section_label then
				l_type := "section_label"
			when {INI_SCANNER_TOKEN_TYPE}.section_open then
				l_type := "section_open"
			when {INI_SCANNER_TOKEN_TYPE}.text then
				l_type := "text"
			when {INI_SCANNER_TOKEN_TYPE}.unknown then
				l_type := "unknown"
			when {INI_SCANNER_TOKEN_TYPE}.whitespace then
				l_type := "whitespace"
			else
				l_type := "???"
			end
			create Result.make (l_type.count + text.count + 6)
			Result.append_character ('{')
			Result.append (l_type)
			Result.append ("} : ")
			Result.append (text)
		end

invariant
	text_attached: text /= Void
	not_text_is_empty: not text.is_empty
	start_index_positive: start_index > 0
	end_index_big_enough: end_index >= start_index

note
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

end -- class {INI_SCANNER_TOKEN_INFO}
