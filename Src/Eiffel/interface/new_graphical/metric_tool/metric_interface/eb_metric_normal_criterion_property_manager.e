indexing
	description: "Property manager for normal metric criterion"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_NORMAL_CRITERION_PROPERTY_MANAGER

inherit
	EB_METRIC_CRITERION_PROPERTY_MANAGER
		redefine
			criterion_type
		end

create
	make

feature -- Access

	property_item: EV_GRID_ITEM is
			-- Grid item used to display properties
		do
			if property_item_internal = Void then
				create {EV_GRID_LABEL_ITEM} property_item_internal
			end
			Result := property_item_internal
		end

feature -- Properties management

	load_properties (a_criterion: like criterion_type) is
			-- Load porperties from `a_criterion' into current manager
		do
		end

	store_properties (a_criterion: like criterion_type) is
			-- Store properties in current manager into `a_criterion'.
		do
		end

feature{NONE} -- Implementation

	criterion_type: EB_METRIC_NORMAL_CRITERION
			-- Anchor type

	property_item_internal: like property_item;
			-- Implementation of `property_item'

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
