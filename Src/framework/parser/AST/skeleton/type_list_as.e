note
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
	make, make_filled_with

feature -- Roundtrip/Token

	first_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			if a_list /= Void and opening_bracket_as_index /= 0 then
				Result := opening_bracket_as (a_list)
			else
				Result := Precursor {EIFFEL_LIST} (a_list)
			end
		end

	last_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			if a_list /= Void and closing_bracket_as_index /= 0 then
				Result := closing_bracket_as (a_list)
			else
				Result := Precursor {EIFFEL_LIST} (a_list)
			end
		end

feature -- Visitor

	process (a_visitor: AST_VISITOR)
			-- Process current node.
		do
			a_visitor.process_type_list_as (Current)
		end

feature -- Setting

	set_positions (a_opener, a_closer: detachable SYMBOL_AS)
			-- Set `start_location' and `end_location' with `a_opener' and `a_closer'
			-- if not Void, nothing otherwise
		do
			if a_opener /= Void then
				opening_bracket_as_index := a_opener.index
			end
			if a_closer /= Void then
				closing_bracket_as_index := a_closer.index
			end
		ensure
			opening_bracket_as_set: a_opener /= Void implies opening_bracket_as_index = a_opener.index
			closing_bracket_as_set: a_closer /= Void closing_bracket_as_index = a_closer.index
		end

feature

	opening_bracket_as_index: INTEGER
			-- Index of `[' token if present.

	closing_bracket_as_index: INTEGER
			-- Location of `]' if present.

	opening_bracket_as (a_list: LEAF_AS_LIST): detachable SYMBOL_AS
			-- Location of `[' if present.
		require
			a_list_not_void: a_list /= Void
		do
			Result := symbol_from_index (a_list, opening_bracket_as_index)
		end

	closing_bracket_as (a_list: LEAF_AS_LIST): detachable SYMBOL_AS
			-- Location of `]' if present.
		require
			a_list_not_void: a_list /= Void
		do
			Result := symbol_from_index (a_list, closing_bracket_as_index)
		end

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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
