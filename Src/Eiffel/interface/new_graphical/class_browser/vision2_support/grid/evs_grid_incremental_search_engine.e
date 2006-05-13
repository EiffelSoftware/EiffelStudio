indexing
	description: "Object that represents an incremental search engine"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EVS_GRID_INCREMENTAL_SEARCH_ENGINE

inherit
	EVS_GRID_SEARCH_ENGINE

feature -- Setting

	enable_wrap_search is
			-- Enable case sensitive match.
		do
			is_wrap_search_enabled := True
		ensure
			wrap_search_enabled: is_wrap_search_enabled
		end

	disable_wrap_search is
			-- Disable case sensitive match.
		do
			is_wrap_search_enabled := False
		ensure
			wrap_search_disabled: not is_wrap_search_enabled
		end

	ensure_search_by_row is
			-- Ensure search by rows.
		do
			is_search_by_row := True
		ensure
			search_by_rows_enabled: is_search_by_row
		end

	ensure_search_by_column is
			-- Ensure search by columns.
		do
			is_search_by_row := False
		ensure
			search_by_columns_enabled: not is_search_by_row
		end

	ensure_search_foreward is
			-- Ensure search foreward.
		do
			is_search_foreward := True
		ensure
			search_forewards_enabled: is_search_foreward
		end

	ensure_search_backward is
			-- Ensure search backward.
		do
			is_search_foreward := False
		ensure
			search_backwards_enabled: not is_search_foreward
		end

feature -- Status report

	is_wrap_search_enabled: BOOLEAN
			-- Is wrap search enabled

	is_search_by_column: BOOLEAN is
			-- Is search by columns?
		do
			Result := not is_search_by_row
		ensure
			good_result: Result implies not is_search_by_row
		end

	is_search_by_row: BOOLEAN
			-- Is search by rows?

	is_search_foreward: BOOLEAN
			-- Is search foreward?

	is_search_backward: BOOLEAN is
			-- Is search backward?
		do
			Result := not is_search_foreward
		ensure
			good_result: Result implies not is_search_foreward
		end

feature{NONE} -- Implementation

	grid_iterator (a_grid_wrapper: EVS_GRID_WRAPPER): EVS_GRID_ORDERED_ITERATOR is
			-- Grid iterator for `a_grid_wrapper' according to current search order.
			-- See `ensure_search_by_row' and `ensure_search_by_column' for search order information.
		local
			l_selected: ARRAYED_LIST [EV_GRID_ITEM]
			l_sortable_list: DS_LIST [EVS_GRID_COORDINATED]
			x, y: INTEGER
			l_row: EV_GRID_ROW
		do
			if is_search_by_row then
				if is_search_foreward then
					create {EVS_GRID_ROW_ITERATOR}Result.make_with_last_selected_item (a_grid_wrapper)
				else
					create {EVS_GRID_ROW_ITERATOR}Result.make_with_first_selected_item (a_grid_wrapper)
				end
			else
				if is_search_foreward then
					create {EVS_GRID_COLUMN_ITERATOR}Result.make_with_last_selected_item (a_grid_wrapper)
				else
					create {EVS_GRID_COLUMN_ITERATOR}Result.make_with_first_selected_item (a_grid_wrapper)
				end
			end
		ensure
			result_attached: Result /= Void
		end

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
