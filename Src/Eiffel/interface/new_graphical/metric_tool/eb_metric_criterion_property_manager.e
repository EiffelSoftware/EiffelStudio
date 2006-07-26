indexing
	description: "Criterion property manager"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_METRIC_CRITERION_PROPERTY_MANAGER

feature{NONE} -- Initialization

	make (a_grid: like grid) is
			-- Initialize `grid' with `a_grid'.
		require
			a_grid_attached: a_grid /= Void
		do
			grid := a_grid
			create change_actions
		ensure
			grid_set: grid = a_grid
			change_actions_attached: change_actions /= Void
		end

feature -- Access

	property_item: EV_GRID_ITEM is
			-- Grid item used to display properties
		deferred
		ensure
			result_attached: Result /= Void
		end

	grid: EB_METRIC_CRITERION_GRID
			-- Grid to which `property_item' is binded

	change_actions: ACTION_SEQUENCE [TUPLE]
			-- Actions to be performed when any kind of change occurs in current

feature -- Properties management

	load_properties (a_criterion: like criterion_type) is
			-- Load porperties from `a_criterion' into current manager
		require
			a_criterion_attached: a_criterion /= Void
		deferred
		end

	store_properties (a_criterion: like criterion_type) is
			-- Store properties in current manager into `a_criterion'.
		require
			a_criterion_attached: a_criterion /= Void
		deferred
		end

feature{NONE} -- Implementation

	criterion_type: EB_METRIC_CRITERION
			-- Anchor type

invariant
	grid_attached: grid /= Void
	change_actions_attached: change_actions /= Void

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
