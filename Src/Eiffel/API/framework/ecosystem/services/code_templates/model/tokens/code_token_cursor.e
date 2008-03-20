indexing
	description: "[
		A special code token to represent the complete rendered code template's cursor final position.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

frozen class
	CODE_TOKEN_CURSOR

inherit
	CODE_TOKEN_ID
		rename
			make as make_token_id
		redefine
			printable_text,
			process
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initializes a cursor place-holder code token.
		do
			make_token_id (create {!STRING_32}.make_from_string ({CODE_TEMPLATE_ENTITY_NAMES}.cursor_token_name))
		end

feature -- Access

	printable_text: like text
			-- <Precursor>
		do
				-- No printable text.
			create Result.make_empty
		end

feature -- Visitor

	process (a_visitor: !CODE_TOKEN_VISITOR_I)
			-- <Precursor>
		do
			a_visitor.process_code_token_cursor (Current)
		end

;indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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

end
