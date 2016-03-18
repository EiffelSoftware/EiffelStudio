note
	description: "[
			Scorer for search relevance.
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_SEARCH_SCORER [G]

feature -- Access

	scored_list (a_query: READABLE_STRING_GENERAL; a_items: LIST [G]; a_keep_all: BOOLEAN): LIST [SCORED_VALUE [G]]
			-- Score `a_items' thanks to `a_query'.
			-- If `a_keep_all' is True, also keep items which don't matched.
		require
			a_query_attached: a_query /= Void
			a_items_attached: a_items /= Void
		deferred
		end

	sorted_scored_list (a_query: READABLE_STRING_GENERAL; a_items: LIST [G]; a_keep_all: BOOLEAN): LIST [SCORED_VALUE [G]]
			-- Score `a_items' thanks to `a_query', and return scored items sorted by score.
			-- If `a_keep_all' is True, also keep items which don't matched.
		require
			a_query_attached: a_query /= Void
			a_items_attached: a_items /= Void
		do
			Result := scored_list (a_query, a_items, a_keep_all)
			sorter.sort (Result)
		end

	sorter: SORTER [SCORED_VALUE [G]]
		do
			create {QUICK_SORTER [SCORED_VALUE [G]]} Result.make (create {SCORED_VALUE_COMPARATOR [G]})
		end

note
	copyright: "Copyright (c) 1984-2016, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
