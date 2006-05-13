indexing
	description: "Object contains sorting information for a column in EV_GRID"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EVS_GRID_SORTING_INFO

create
	make

feature{NONE} -- Implementation

	make (a_column: like column; a_sort_order_change_func: like sort_order_change_function; a_sorter: like sorter; a_current_order: INTEGER) is
			-- Initialize `column' with `a_column', `sort_order_change_function with `a_sort_order_change_funct',
			-- `sorter' with `a_sorter' and `current_order' with `a_current_order'.
		require
			a_column_attached: a_column /= Void
			a_sort_order_change_func_attached: a_sort_order_change_func /= Void
			a_sorter_attached: a_sorter /= Void
		do
			column := a_column
			create indicator.make (1)
			set_sort_order_change_function (a_sort_order_change_func)
			set_sorter (a_sorter)
			set_current_order (a_current_order)
		ensure
			column_set: column = a_column
			current_order_set: current_order = a_current_order
		end

feature -- Sort

	sort is
			-- Sort, do not change `current_order'.
		local
			l_indicator: EV_PIXMAP
		do
			sorter.call ([current_order])
			if is_auto_indicator_enabled and then indicator.has (current_order) then
				l_indicator := indicator.item (current_order)
				if l_indicator /= Void then
					column.set_pixmap (l_indicator)
				else
					column.remove_pixmap
				end
			end
		end

	change_order_and_sort is
			-- Change `current_order' using `sort_order_change_function' and sort.
		do
			sort_order_change_function.call ([current_order])
			current_order := sort_order_change_function.last_result
			sort
		end

feature -- Access

	column: EV_GRID_COLUMN
			-- Grid column to which current is attached

	current_order: INTEGER
			-- Current sorting order

	sort_order_change_function: FUNCTION [ANY, TUPLE [INTEGER], INTEGER]
			-- Function to decide next sorting order
			-- Parameter of the function is the original sort order, return value of the function is
			-- new sort order.

	sorter: PROCEDURE [ANY, TUPLE [INTEGER]]
			-- Agent to perform sorting, parameter is `current_order'.

	indicator: HASH_TABLE [EV_PIXMAP, INTEGER]
			-- Pixmap indicators for every sorting order

feature -- Status reporting

	is_auto_indicator_enabled: BOOLEAN
			-- Should sort order indicator be set automatically?

feature -- Setting

	enable_auto_indicator is
			-- Enable auto indicator.
		do
			is_auto_indicator_enabled := True
		ensure
			auto_indicator_enabled: is_auto_indicator_enabled
		end

	disable_auto_indicator is
			-- Disable auto indicator setting.
		do
			is_auto_indicator_enabled := False
		ensure
			auto_indicator_disabled: not is_auto_indicator_enabled
		end

	set_sort_order_change_function (a_func: like sort_order_change_function) is
			-- Set `sort_order_change_function' with `a_func'.
		require
			a_func_attached: a_func /= Void
		do
			sort_order_change_function := a_func
		ensure
			sort_order_change_function_set: sort_order_change_function = a_func
		end

	set_sorter (a_sorter: like sorter) is
			-- Set `sorter' with `a_sorter'.
		require
			a_sorter_attached: a_sorter /= Void
		do
			sorter := a_sorter
		ensure
			sorter_set: sorter = a_sorter
		end

	set_current_order (a_order: INTEGER) is
			-- Set `current_order' with `a_order'.
		do
			current_order := a_order
		ensure
			current_order_set: current_order = a_order
		end

invariant
	column_attached: column /= Void
	indicator_attached: indicator /= Void
	sorter_attached: sorter /= Void
	sort_order_change_function_attached: sort_order_change_function /= Void

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
