note
	description: "Object contains sorting information for a column in EV_GRID"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EVS_GRID_SORTING_INFO [G]

create
	make

feature{NONE} -- Implementation

	make (a_sort_order_change_func: like sort_order_change_function; a_comparator: like comparator; a_current_order: INTEGER)
			-- Initialize `sort_order_change_function with `a_sort_order_change_funct',
			-- `comparator' with `a_comparator' and `current_order' with `a_current_order'.
		require
			a_sort_order_change_func_attached: a_sort_order_change_func /= Void
			a_comparator_attached: a_comparator /= Void
		do
			create indicator.make (1)
			set_sort_order_change_function (a_sort_order_change_func)
			set_comparator (a_comparator)
			set_current_order (a_current_order)
		end

feature -- Sort

	change_order
			-- Change `current_order' using `sort_order_change_function'.
		do
			current_order := sort_order_change_function.item ([current_order])
		end

feature -- Access

	column_index: INTEGER
			-- Index of grid column to which current is attached

	current_order: INTEGER
			-- Current sorting order

	sort_order_change_function: FUNCTION [INTEGER, INTEGER]
			-- Function to decide next sorting order
			-- Parameter of the function is the original sort order, return value of the function is
			-- new sort order.

	indicator: HASH_TABLE [EV_PIXMAP, INTEGER]
			-- Pixmap indicators for every sorting order

	comparator: FUNCTION [G, G, INTEGER, BOOLEAN]
			-- Comparator used to sort
			-- The first two arguments are rows to be compared with each other
			-- The third integer argument is current sorting order
			-- Return value of this comparator should be True if the first row is less thant the second one.

feature -- Status reporting

	is_auto_indicator_enabled: BOOLEAN
			-- Should sort order indicator be set automatically?

feature {EVS_GRID_WRAPPER} -- Setting

	set_column_index (a_index: INTEGER)
			-- Set `column_index' with `a_index'.
		do
			column_index := a_index
		ensure
			column_index_set: column_index = a_index
		end

feature -- Setting

	enable_auto_indicator
			-- Enable auto indicator.
		do
			is_auto_indicator_enabled := True
		ensure
			auto_indicator_enabled: is_auto_indicator_enabled
		end

	disable_auto_indicator
			-- Disable auto indicator setting.
		do
			is_auto_indicator_enabled := False
		ensure
			auto_indicator_disabled: not is_auto_indicator_enabled
		end

	set_sort_order_change_function (a_func: like sort_order_change_function)
			-- Set `sort_order_change_function' with `a_func'.
		require
			a_func_attached: a_func /= Void
		do
			sort_order_change_function := a_func
		ensure
			sort_order_change_function_set: sort_order_change_function = a_func
		end

	set_comparator (a_comparator: like comparator)
			-- Set `comparator' with `a_comparator'.
		require
			a_comparator_attached: a_comparator /= Void
		do
			comparator := a_comparator
		ensure
			comparator_set: comparator = a_comparator
		end

	set_current_order (a_order: INTEGER)
			-- Set `current_order' with `a_order'.
		do
			current_order := a_order
		ensure
			current_order_set: current_order = a_order
		end

invariant
	indicator_attached: indicator /= Void
	sort_order_change_function_attached: sort_order_change_function /= Void
	comparator_attached: comparator /= Void

note
        copyright:	"Copyright (c) 1984-2015, Eiffel Software and others"
        license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
