indexing
	description: "Caller/callee criterion property manager used in metric criterion grid"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_VALUE_CRITERION_MANAGER

inherit
	EB_METRIC_DOMAIN_PROPERTY_MANAGER
		redefine
			property_item,
			criterion_type,
			load_properties,
			store_properties
		end

create
	make

feature -- Access

	property_item: EB_METRIC_GRID_VALUE_CRITERION_ITEM is
			-- Grid item used to display properties
		do
			if property_item_internal = Void then
				create property_item_internal.make (create {EB_METRIC_DOMAIN}.make, False)
				property_item_internal.pointer_button_press_actions.force_extend (agent activate_grid_item (?, ?, ?, ?, ?, ?, ?, ?, property_item_internal))
				property_item_internal.dialog_ok_actions.extend (agent grid.resize_column (2, 0))
				property_item_internal.dialog_ok_actions.extend (agent change_actions.call (Void))
				property_item_internal.set_tooltip (metric_names.f_pick_and_drop_metric_and_items)
				property_item_internal.set_dialog_function (agent value_criterion_dialog)
			end
			Result := property_item_internal
		end

feature -- Properties management

	load_properties (a_criterion: like criterion_type) is
			-- Load porperties from `a_criterion' into current manager
		do
			Precursor (a_criterion)
			property_item.set_value ([a_criterion.metric_name, a_criterion.should_delayed_domain_from_parent_be_used, a_criterion.value_tester])
		end

	store_properties (a_criterion: like criterion_type) is
			-- Store properties in current manager into `a_criterion'.
		local
			l_value: TUPLE [STRING, BOOLEAN, EB_METRIC_VALUE_TESTER]
			l_tester: EB_METRIC_VALUE_TESTER
			l_metric_name: STRING
			l_use_external: BOOLEAN_REF
		do
			Precursor (a_criterion)
			l_value := property_item.value
			if l_value = Void then
				l_value := ["", False, create {EB_METRIC_VALUE_TESTER}.make]
			end
			l_metric_name ?= l_value.item (1)
			if l_metric_name = Void then
				l_metric_name := ""
			end
			l_use_external ?= l_value.item (2)
			if l_use_external = Void then
				l_use_external := False
			end
			l_tester ?= l_value.item (3)
			if l_tester = Void then
				create l_tester.make
			end
			a_criterion.set_metric_name (l_metric_name)
			a_criterion.set_value_tester (l_tester)
			a_criterion.set_should_delayed_domain_from_parent_be_used (l_use_external.item)
		end

feature{NONE} -- Implementation

	criterion_type: EB_METRIC_VALUE_CRITERION;
			-- Anchor type

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
