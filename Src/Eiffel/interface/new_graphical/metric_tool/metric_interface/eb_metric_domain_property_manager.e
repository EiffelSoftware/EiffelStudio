indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_DOMAIN_PROPERTY_MANAGER

inherit
	EB_METRIC_CRITERION_PROPERTY_MANAGER
		redefine
			criterion_type,
			property_item
		end

create
	make

feature -- Access

	property_item: EB_METRIC_DOMAIN_GRID_ITEM is
			-- Grid item used to display properties
		do
			if property_item_internal = Void then
				create property_item_internal.make (create {EB_METRIC_DOMAIN}.make)
				property_item_internal.set_padding (8)
				property_item_internal.set_spacing (2)
				property_item_internal.set_left_border (3)
				property_item_internal.set_right_border (3)
				property_item_internal.pointer_button_press_actions.force_extend (agent property_item_internal.activate)
				property_item_internal.dialog_ok_actions.extend (agent grid.resize_column (2, 0))
				property_item_internal.dialog_ok_actions.extend (agent change_actions.call ([]))
				property_item_internal.set_tooltip (metric_names.f_pick_and_drop_items)
				property_item_internal.dialog.set_grid (grid)
			end
			Result := property_item_internal
		end

feature -- Properties management

	load_properties (a_criterion: like criterion_type) is
			-- Load porperties from `a_criterion' into current manager
		local
			l_domain: EB_METRIC_DOMAIN
		do
			check a_criterion.domain /= Void end
			l_domain := a_criterion.domain.twin
			property_item.set_domain (l_domain)
		end

	store_properties (a_criterion: like criterion_type) is
			-- Store properties in current manager into `a_criterion'.
		do
			check property_item.domain /= Void end
			a_criterion.set_domain (property_item.domain.twin)
		end

feature{NONE} -- Implementation

	criterion_type: EB_METRIC_DOMAIN_CRITERION
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
