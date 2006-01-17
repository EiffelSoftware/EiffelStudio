indexing
	description: "Compiler representation of feature renaming."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class RENAMING

inherit
	EIFFEL_SYNTAX_CHECKER
	PREFIX_INFIX_NAMES
	SHARED_NAMES_HEAP

create
	make

feature {NONE} -- Initialization

	make (name_id: like feature_name_id; alias_id: like alias_name_id; convert_mark: like has_convert_mark) is
			-- Initialize `Current'.
		require
			valid_name_id: names_heap.valid_index (name_id)
			valid_alias_id: alias_id /= 0 implies names_heap.valid_index (alias_id)
			valid_convert_mark: convert_mark implies alias_id /= 0
		do
			feature_name_id := name_id
			alias_name_id := alias_id
			has_convert_mark := convert_mark
		ensure
			feature_name_id_set: feature_name_id = name_id
			alias_name_id_set: alias_name_id = alias_id
			has_convert_mark_set: has_convert_mark = convert_mark
		end

feature -- Access

	feature_name_id: INTEGER
			-- ID of new feature name

	alias_name_id: INTEGER
			-- ID of new alias name or 0

	has_convert_mark: BOOLEAN
			-- Does new feature have a convert mark?

feature -- Modification

	set_alias_name_id (alias_id: like alias_name_id) is
			-- Set `alias_name_id' to `alias_id'.
		require
			valid_alias_id: alias_id /= 0 and then names_heap.valid_index (alias_id)
			is_operator:
				is_valid_binary_operator (extract_alias_name (names_heap.item (alias_id))) or else
				is_valid_unary_operator (extract_alias_name (names_heap.item (alias_id)))
		do
			alias_name_id := alias_id
		ensure
			alias_name_id_set: alias_name_id = alias_id
		end

invariant
	valid_feature_name_id: names_heap.valid_index (feature_name_id)
	valid_alias_name_id: alias_name_id /= 0 implies names_heap.valid_index (alias_name_id)
	valid_has_convert_mark: has_convert_mark implies alias_name_id /= 0

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
