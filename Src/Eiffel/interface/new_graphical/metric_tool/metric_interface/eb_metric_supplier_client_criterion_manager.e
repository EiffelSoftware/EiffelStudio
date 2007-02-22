indexing
	description: "Dialog to setup supplier/client domain"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_METRIC_SUPPLIER_CLIENT_CRITERION_MANAGER
inherit
	EB_METRIC_DOMAIN_PROPERTY_MANAGER
		redefine
			criterion_type,
			load_properties,
			store_properties,
			property_item
		end

create
	make

feature -- Access

	property_item: EB_METRIC_GRID_DOMAIN_ITEM [TUPLE [BOOLEAN, BOOLEAN, BOOLEAN]] is
			-- Grid item used to display properties
		do
			if property_item_internal = Void then
				create property_item_internal.make (create {EB_METRIC_DOMAIN}.make)
				property_item_internal.pointer_button_press_actions.force_extend (agent activate_grid_item (?, ?, ?, ?, ?, ?, ?, ?, property_item_internal))
				property_item_internal.dialog_ok_actions.extend (agent grid.resize_column (2, 0))
				property_item_internal.dialog_ok_actions.extend (agent change_actions.call (Void))
				property_item_internal.set_tooltip (metric_names.f_pick_and_drop_items)
				property_item_internal.set_dialog_function (agent dialog_function)
			end
			Result := property_item_internal
		end

feature -- Properties management

	load_properties (a_criterion: like criterion_type) is
			-- Load porperties from `a_criterion' into current manager
		do
			Precursor (a_criterion)
			if a_criterion.indirect_referenced_class_retrieved then
			end
			property_item.set_value (
				[a_criterion.indirect_referenced_class_retrieved,
				 a_criterion.normal_referenced_class_retrieved,
				 a_criterion.only_syntactically_referencedd_class_retrieved]
			)
			is_for_supplier := a_criterion.is_for_supplier
		end

	store_properties (a_criterion: like criterion_type) is
			-- Store properties in current manager into `a_criterion'.
		local
			l_value: TUPLE [BOOLEAN, BOOLEAN, BOOLEAN]
			l_indirect: BOOLEAN_REF
			l_normal: BOOLEAN_REF
			l_syntactical: BOOLEAN_REF
		do
			Precursor (a_criterion)
			l_value := property_item.value
			if l_value /= Void then
				l_indirect ?= l_value.item (1)
				l_normal ?= l_value.item (2)
				l_syntactical ?= l_value.item (3)
				check
					l_indirect /= Void
					l_normal /= Void
					l_syntactical /= Void
				end
				a_criterion.set_indirect_referenced_class_retrieved (l_indirect.item)
				a_criterion.set_normal_referenced_class_retrieved (l_normal.item)
				a_criterion.set_only_syntactically_referencedd_class_retrieved (l_syntactical.item)
			else
				a_criterion.set_indirect_referenced_class_retrieved (False)
				a_criterion.set_normal_referenced_class_retrieved (True)
				a_criterion.set_only_syntactically_referencedd_class_retrieved (False)
			end
		end

feature{NONE} -- Implementation

	criterion_type: EB_METRIC_SUPPLIER_CLIENT_CRITERION
			-- Anchor type

	is_for_supplier: BOOLEAN
			-- Is Current criterion for suppiers?

	dialog_function: EB_METRIC_GRID_DOMAIN_ITEM_DIALOG [TUPLE [BOOLEAN, BOOLEAN, BOOLEAN]] is
			-- Dialog used for domain setup
		do
			if is_for_supplier then
				Result := supplier_domain_setup_dialog
			else
				Result := client_domain_setup_dialog
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
