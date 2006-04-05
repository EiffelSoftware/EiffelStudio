indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EC_CHECKED_REASON_CONSTANTS

feature -- Access

		-- Entity marks
	reason_assembly_marked_non_cls_compliant: STRING is "Assembly was marked with 'ClsCompliantAttribute (false)'"
	reason_type_marked_non_cls_compliant: STRING is "Type was marked with 'ClsCompliantAttribute (false)'"
	reason_constructor_marked_non_cls_compliant: STRING is "Constructor was marked with 'ClsCompliantAttribute (false)'"
	reason_method_marked_non_cls_compliant: STRING is "Method was marked with 'ClsCompliantAttribute (false)'"
	reason_property_marked_non_cls_compliant: STRING is "Property was marked with 'ClsCompliantAttribute (false)'"
	reason_field_marked_non_cls_compliant: STRING is "Field was marked with 'ClsCompliantAttribute (false)'"
	reason_event_marked_non_cls_compliant: STRING is "Event was marked with 'ClsCompliantAttribute (false)'"
	reason_member_marked_non_cls_compliant: STRING is "Member was marked with 'ClsCompliantAttribute (false)'"
	reason_assembly_marked_non_eiffel_consumable: STRING is "Assembly was marked with 'EIFFEL_CONSUMABLE_ATTRIBUTE (false)'"
	reason_type_marked_non_eiffel_consumable: STRING is "Type was marked with 'EIFFEL_CONSUMABLE_ATTRIBUTE (false)'"
	reason_constructor_marked_non_eiffel_consumable: STRING is "Assembly was marked with 'EIFFEL_CONSUMABLE_ATTRIBUTE (false)'"
	reason_method_marked_non_eiffel_consumable: STRING is "Assembly was marked with 'EIFFEL_CONSUMABLE_ATTRIBUTE (false)'"
	reason_property_marked_non_eiffel_consumable: STRING is "Assembly was marked with 'EIFFEL_CONSUMABLE_ATTRIBUTE (false)'"
	reason_field_marked_non_eiffel_consumable: STRING is "Assembly was marked with 'EIFFEL_CONSUMABLE_ATTRIBUTE (false)'"
	reason_event_marked_non_eiffel_consumable: STRING is "Assembly was marked with 'EIFFEL_CONSUMABLE_ATTRIBUTE (false)'"
	reason_member_marked_non_eiffel_consumable: STRING is "Assembly was marked with 'EIFFEL_CONSUMABLE_ATTRIBUTE (false)'"

		-- Entity name
	reason_type_name_is_non_compliant: STRING is "Type name is non-compliant"
	reason_method_name_is_non_compliant: STRING is "Method name is non-compliant"
	reason_property_name_is_non_compliant: STRING is "Property name is non-compliant"
	reason_field_name_is_non_compliant: STRING is "Field name is non-compliant"
	reason_event_name_is_non_compliant: STRING is "Event name is non-compliant"

		-- Interface
	reason_interface_contains_non_cls_compliant_members: STRING is "Interface contains non-CLS-compliant members"
	reason_interface_contains_non_eiffel_compliant_members: STRING is "Interface contains non-Eiffel-compliant members"

		-- Using non-compliant types
	reason_field_uses_non_complaint_type: STRING is "Field uses non-compliant type"
	reason_event_uses_non_complaint_type: STRING is "Event uses non-compliant type"
	reason_property_uses_non_complaint_type: STRING is "Property uses non-compliant type"
	reason_method_returns_non_complaint_type: STRING is "Method returns a non-compliant type"
	reason_parameters_uses_non_complaint_types: STRING is "One or more parameters use non-compliant types"

		-- Varargs
	reason_constructor_uses_var_args: STRING is "Constructor accepts variable number of parameters"
	reason_method_uses_var_args: STRING is "Method accepts variable number of parameters"

		-- Generics
	reason_type_is_generic: STRING is "Type is a generic type"
	reason_member_is_generic: STRING is "Member is a generic member";


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
end -- class EC_CHECKED_REASON_CONSTANTS
