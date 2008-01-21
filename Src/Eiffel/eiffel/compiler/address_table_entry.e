indexing
	description: "Address table entry indexed by feature reordering"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ADDRESS_TABLE_ENTRY

inherit
	SEARCH_TABLE [FEATURE_REORDERING]
		rename
			make as make_search_table
		end

create
	make

feature -- Initialize

	make is
		do
			make_search_table (2)
		end

feature -- Access

	force_reordering (a_is_target_closed: BOOLEAN; a_open_map: ARRAYED_LIST [INTEGER]; a_frozen_age: INTEGER) is
		local
			reordering: FEATURE_REORDERING
		do
			create reordering.make (a_is_target_closed, a_open_map, a_frozen_age)
			search (reordering)
			if found then
				found_item.set_frozen_age (a_frozen_age)
			else
				put (reordering)
			end
		end

	has_dollar_op: BOOLEAN

	set_has_dollar_op is
		do
			has_dollar_op := True
			create dollar_ids.make (0)
		end

	dollar_ids: HASH_TABLE [INTEGER, INTEGER];
		-- Id of dollar operator for a given static type-id

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
