indexing
	description: "[
		A code token to represent a replacable (non-editable) code identifier reference.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	CODE_TOKEN_ID_REF

inherit
	CODE_TOKEN
		redefine
			printable_text,
			out
		end

create
	make

feature {NONE} -- Initialization

	make (a_token: like code_token_id)
			-- Initializes the code token reference using a code token id.
			--
			-- `a_token': A code token the current token references.
		do
			code_token_id := a_token
		ensure
			code_token_id_set: code_token_id = a_token
		end

feature -- Access

	printable_text: like text
			-- <Precursor>
		do
			Result := code_token_id.printable_text
		end

	text: !STRING_32
			-- <Precursor>
		do
			Result := code_token_id.text
		end

	code_token_id: !CODE_TOKEN_ID
			-- Reference code token id, use to extract the values

feature -- Status report

	frozen is_editable: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

feature -- Query

	is_valid_text (a_text: like text): BOOLEAN
			-- <Precursor>
		do
			Result := True
		end

feature -- Visitor

	process (a_visitor: !CODE_TOKEN_VISITOR_I)
			-- <Precursor>
		do
			a_visitor.process_code_token_id_ref (Current)
		end

feature -- Output

	out: STRING_8
			-- <Precursor>
		do
			Result := code_token_id.out
		end

invariant
	not_is_editable: not is_editable

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
