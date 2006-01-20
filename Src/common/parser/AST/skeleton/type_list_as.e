indexing
	description: "Specialized EIFFEL_LIST for a list of TYPE_AS, mostly used for the actual generics and %
		%find the location of `[' and `]'."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TYPE_LIST_AS

inherit
	EIFFEL_LIST [TYPE_AS]
		redefine
			first_token, last_token, process
		end

create
	make, make_filled

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			if opening_bracket_as /= Void then
				Result := opening_bracket_as.first_token (a_list)
			else
				Result := Precursor {EIFFEL_LIST} (a_list)
			end
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			if closing_bracket_as /= Void then
				Result := closing_bracket_as.last_token (a_list)
			else
				Result := Precursor {EIFFEL_LIST} (a_list)
			end
		end

feature -- Visitor

	process (a_visitor: AST_VISITOR) is
			-- Process current node.
		do
			a_visitor.process_type_list_as (Current)
		end

feature -- Setting

	set_positions (a_opener, a_closer: SYMBOL_AS) is
			-- Set `start_location' and `end_location' with `a_opener' and `a_closer'
			-- if not Void, nothing otherwise
		do
			opening_bracket_as := a_opener
			closing_bracket_as := a_closer
		ensure
			opening_bracket_as_set: opening_bracket_as = a_opener
			closing_bracket_as_set: closing_bracket_as = a_closer
		end

feature

	opening_bracket_as: SYMBOL_AS
			-- Location of `[' if present.

	closing_bracket_as: SYMBOL_AS;
			-- Location of `]' if present.

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

end
