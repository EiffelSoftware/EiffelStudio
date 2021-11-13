note
	description: "Compiler representation of feature renaming."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class RENAMING

inherit
	PREFIX_INFIX_NAMES
	SHARED_NAMES_HEAP
	INTERNAL_COMPILER_STRING_EXPORTER

create
	make

feature {NONE} -- Initialization

	make (name_id: like feature_name_id; alias_ids: like alias_name_id; convert_mark: like has_convert_mark)
			-- Initialize `Current'.
		require
			valid_name_id: names_heap.valid_index (name_id)
			valid_alias_id: attached alias_ids implies ∀ i: alias_ids ¦ is_alias_id (i)
			valid_convert_mark: convert_mark implies attached alias_ids
		do
			feature_name_id := name_id
			alias_name_id := alias_ids
			has_convert_mark := convert_mark
		ensure
			feature_name_id_set: feature_name_id = name_id
			alias_name_id_set: alias_name_id = alias_ids
			has_convert_mark_set: has_convert_mark = convert_mark
		end

feature -- Access

	feature_name_id: INTEGER
			-- ID of new feature name

	alias_name_id: detachable SPECIAL [like {OPERATOR_KIND}.alias_id]
			-- IDs of new alias names or Void

	has_convert_mark: BOOLEAN
			-- Does new feature have a convert mark?

feature {INTERNAL_COMPILER_STRING_EXPORTER} -- Modification

	set_alias_name_id (alias_ids: like alias_name_id)
			-- Set `alias_name_id' to `alias_id'.
		require
			alias_id_attached: attached alias_ids
			valid_alias_id: ∀ i: alias_ids ¦ is_alias_id (i)
		do
			alias_name_id := alias_ids
		ensure
			alias_name_id_set: alias_name_id = alias_ids
		end

invariant
	valid_feature_name_id: names_heap.has (feature_name_id)
	valid_alias_name_id: attached alias_name_id as a implies ∀ i: a ¦ is_alias_id (i)
	valid_has_convert_mark: has_convert_mark implies attached alias_name_id

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
