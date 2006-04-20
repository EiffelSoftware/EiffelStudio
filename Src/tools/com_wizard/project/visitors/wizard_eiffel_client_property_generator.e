indexing
	description: "Generate Eiffel Client code from property"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_EIFFEL_CLIENT_PROPERTY_GENERATOR

inherit
	WIZARD_EIFFEL_EFFECTIVE_PROPERTY_GENERATOR

create
	generate

feature -- Basic operations

	generate (a_component_descriptor: WIZARD_COMPONENT_DESCRIPTOR; a_descriptor: WIZARD_PROPERTY_DESCRIPTOR) is
			-- Generate client access and setting features.
		local
			l_visitor: WIZARD_DATA_TYPE_VISITOR
		do
			l_visitor := a_descriptor.data_type.visitor 
			create changed_names.make (2)
			define_feature_names (a_component_descriptor, a_descriptor)
			generate_access_feature (l_visitor, a_descriptor)
			generate_external_access_feature (l_visitor, a_component_descriptor, a_descriptor)
			if a_descriptor.is_read_only then
				generate_setting_feature (l_visitor)
				generate_external_setting_feature (l_visitor, a_component_descriptor)
			end
		ensure then
			external_access_feature_exist: external_access_feature /= Void
			external_setting_feature_exist: a_descriptor.is_read_only  implies external_setting_feature /= Void
		end

feature {NONE} -- Implementation

	access_feature_name: STRING
			-- Name of access feature.

	set_feature_name: STRING
			-- Name of set feature.

	external_access_feature_name: STRING
			-- Name of external access feature.

	external_set_feature_name: STRING 
			-- Name of external set feature.

	c_type (a_component_descriptor: WIZARD_COMPONENT_DESCRIPTOR): STRING is
			-- C type of component.
		require
			non_void_component_descriptor: a_component_descriptor /= Void
		do
			create Result.make (50)
			if a_component_descriptor.namespace /= Void and then not a_component_descriptor.namespace.is_empty then
				Result.append (a_component_descriptor.namespace)
				Result.append ("::")
			end
			Result.append (a_component_descriptor.c_type_name)
		ensure
			non_void_c_type: Result /= Void
			valid_c_type: not Result.is_empty
		end
		
	define_feature_names (a_component_descriptor: WIZARD_COMPONENT_DESCRIPTOR; a_descriptor: WIZARD_PROPERTY_DESCRIPTOR) is
			-- Define feature names.
		require
			non_void_component: a_component_descriptor /= Void
			non_void_descriptor: a_descriptor /= Void
		local
			l_string: STRING
		do
			if a_descriptor.is_renamed_in (a_component_descriptor) then
				property_renamed := True
				access_feature_name := a_descriptor.component_eiffel_name (a_component_descriptor)
				changed_names.put (access_feature_name, a_descriptor.interface_eiffel_name)

				create l_string.make (100)
				l_string.append (Set_clause)
				l_string.append (a_descriptor.interface_eiffel_name)
				
				create set_feature_name.make (100)
				set_feature_name.append (Set_clause)
				set_feature_name.append (access_feature_name)
				changed_names.put (set_feature_name, l_string)
			else
				access_feature_name := a_descriptor.interface_eiffel_name
				
				create set_feature_name.make (100)
				set_feature_name.append (Set_clause)
				set_feature_name.append (access_feature_name)
			end
			external_access_feature_name := external_feature_name (access_feature_name)
			external_set_feature_name := external_feature_name (set_feature_name)
		ensure
			non_void_access_feature_name: access_feature_name /= Void
			valid_access_feature_name: not access_feature_name.is_empty
			non_void_set_feature_name: set_feature_name /= Void
			valid_set_feature_name: not set_feature_name.is_empty
			non_void_external_access_feature_name: external_access_feature_name /= Void
			valid_external_access_feature_name: not external_access_feature_name.is_empty
			non_void_external_set_feature_name: external_set_feature_name /= Void
			valid_external_set_feature_name: not external_set_feature_name.is_empty
		end

	generate_access_feature (a_visitor: WIZARD_DATA_TYPE_VISITOR; a_descriptor: WIZARD_PROPERTY_DESCRIPTOR) is
			-- Generate access feature.
		require
			non_void_visitor: a_visitor /= Void
			non_void_descriptor: a_descriptor /= Void
			non_void_access_feature_name: access_feature_name /= Void
			valid_access_feature_name: not access_feature_name.is_empty
		do
			create access_feature.make
			access_feature.set_name (access_feature_name)
			access_feature.set_result_type (a_visitor.eiffel_type)
			access_feature.set_comment (a_descriptor.description)
			access_feature.set_body (access_body)
			access_feature.set_effective
		ensure
			non_void_access_feature: access_feature /= Void
			non_void_access_feature_name: access_feature.name /= Void
			valid_access_feature_name: access_feature.name.is_equal (access_feature_name)
			non_void_access_feature_body: access_feature.body /= Void
		end

	generate_setting_feature (a_visitor: WIZARD_DATA_TYPE_VISITOR) is
			-- Generate setting feature.
		require
			non_void_visitor: a_visitor /= Void
			non_void_set_feature_name: set_feature_name /= Void
			valid_set_feature_name: not set_feature_name.is_empty
		local
			l_argument: STRING
		do
			create setting_feature.make
			setting_feature.set_name (set_feature_name)

			-- Set arguments
			create l_argument.make (100)
			l_argument.append ("a_value: ")
			l_argument.append (a_visitor.eiffel_type)
			setting_feature.add_argument (l_argument)
			setting_feature.set_comment (setting_feature_comment (access_feature_name))
			setting_feature.set_effective
			setting_feature.set_body (setting_body (a_visitor))
		ensure
			non_void_setting_feature: setting_feature /= Void
			non_void_setting_feature_name: setting_feature.name /= Void
			valid_setting_feature_name: setting_feature.name.is_equal (set_feature_name)
			non_void_setting_feature_body: setting_feature.body /= Void
			valid_setting_feature_arguments: not setting_feature.arguments.is_empty
		end

	generate_external_access_feature (a_visitor: WIZARD_DATA_TYPE_VISITOR; a_component_descriptor: WIZARD_COMPONENT_DESCRIPTOR; a_descriptor: WIZARD_PROPERTY_DESCRIPTOR) is
			-- Generate external access feature.
		require
			non_void_visitor: a_visitor /= Void
			non_void_external_access_feature_name: external_access_feature_name /= Void
			valid_external_access_feature_name: not external_access_feature_name.is_empty
			non_void_component: a_component_descriptor /= Void
			non_void_descriptor: a_descriptor /= Void
		do
			create external_access_feature.make
			external_access_feature.set_name (external_access_feature_name)
			external_access_feature.set_result_type (a_visitor.eiffel_type)
			external_access_feature.set_comment (a_descriptor.description)
			external_access_feature.add_argument (Default_pointer_argument.twin)
			external_access_feature.set_body (external_access_body (c_type (a_component_descriptor), a_component_descriptor.c_definition_header_file_name, a_visitor))
			external_access_feature.set_external
		ensure
			non_void_external_access_feature: external_access_feature /= Void
			non_void_external_access_feature_name: external_access_feature.name /= Void
			valid_external_access_feature_name: external_access_feature.name.is_equal (external_access_feature_name)
			non_void_external_access_feature_body: external_access_feature.body /= Void
			valid_external_access_feature_arguments: not external_access_feature.arguments.is_empty
		end

	generate_external_setting_feature (a_visitor: WIZARD_DATA_TYPE_VISITOR; a_component_descriptor: WIZARD_COMPONENT_DESCRIPTOR) is
			-- Generate external set feature.
		require
			non_void_visitor: a_visitor /= Void
			non_void_external_set_feature_name: external_set_feature_name /= Void
			valid_external_set_feature_name: not external_set_feature_name.is_empty
			non_void_component: a_component_descriptor /= Void
		local
			l_argument: STRING
		do
			create external_setting_feature.make
			external_setting_feature.set_name (external_set_feature_name)
			external_setting_feature.add_argument (Default_pointer_argument.twin)
		
			create l_argument.make (100)
			l_argument.append ("a_value: ")
			if a_visitor.is_array_basic_type or a_visitor.is_interface or a_visitor.is_structure or 
					a_visitor.is_structure_pointer or a_visitor.is_interface_pointer or a_visitor.is_coclass_pointer then
				l_argument.append (Pointer_type)
			else
				l_argument.append (a_visitor.eiffel_type)
			end
			external_setting_feature.add_argument (l_argument)			
			external_setting_feature.set_comment (setting_feature_comment (access_feature_name))
			external_setting_feature.set_external
			external_setting_feature.set_body (external_setting_body (c_type (a_component_descriptor), a_component_descriptor.c_definition_header_file_name, a_visitor))
		ensure
			non_void_external_setting_feature: external_setting_feature /= Void
			non_void_external_setting_feature_name: external_setting_feature.name /= Void
			valid_external_setting_feature_name: external_setting_feature.name.is_equal (external_set_feature_name)
			non_void_external_setting_feature_body: external_setting_feature.body /= Void
			valid_external_setting_feature_arguments: not external_setting_feature.arguments.is_empty
		end

	setting_feature_comment (a_name: STRING): STRING is
			-- Comment for setting feature.
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
		do
			create Result.make (100)
			Result.append ("Set `")
			Result.append (a_name)
			Result.append ("' with `value'.")
		ensure
			non_void_comment: Result /= Void
			valid_comment: not Result.is_empty
		end

	setting_body (a_visitor: WIZARD_DATA_TYPE_VISITOR): STRING is
			-- Coclass client setting body code
		require
			non_void_visitor: a_visitor /= Void
			non_void_external_set_feature_name: external_set_feature_name /= Void
			valid_external_set_feature_name: not external_set_feature_name.is_empty
		local
			l_string, local_variable: STRING
		do
			create Result.make (1000)
			Result.append ("%T%T%T")

			create l_string.make (100)
			l_string.append (external_set_feature_name)
			l_string.append (" (initializer, ")

			if a_visitor.is_array_basic_type then
				create local_variable.make (100)
				local_variable.append ("l_c_pointer: ANY")
				setting_feature.add_local_variable (local_variable)
				Result.append ("l_c_pointer := a_value.to_c")
				l_string.append ("$l_c_pointer")
			elseif a_visitor.is_interface or a_visitor.is_interface_pointer or a_visitor.is_structure or 
						a_visitor.is_structure_pointer or a_visitor.is_coclass or a_visitor.is_coclass_pointer then
				l_string.append ("a_value.item")
			else
				l_string.append ("a_value")
			end
			l_string.append (")")
			Result.append (l_string)
		ensure
			non_void_body: Result /= Void
			valid_body: not Result.is_empty		
		end

	access_body: STRING is
			-- Coclass client access body
		require
			non_void_external_access_feature_name: external_access_feature_name /= Void
			valid_external_access_feature_name: not external_access_feature_name.is_empty
		do
			create Result.make (100)
			Result.append ("%T%T%TResult := ")
			Result.append (external_access_feature_name)
			Result.append (" (initializer)")
		ensure
			non_void_body: Result /= Void
			valid_body: not Result.is_empty		
		end

	external_access_body (a_class_name, a_header_file_name: STRING; a_visitor: WIZARD_DATA_TYPE_VISITOR): STRING is
			-- External access feature body
		require
			non_void_class_name: a_class_name /= Void
			valid_class_name: not a_class_name.is_empty
			non_void_header_file_name: a_header_file_name /= Void
			valud_header_file_name: not a_header_file_name.is_empty
			non_void_visitor: a_visitor /= Void
		do
			create Result.make (1000)
			Result.append ("%T%T%T%"C++ [")
			Result.append (a_class_name)
			Result.append (" %%%"")
			Result.append (a_header_file_name)
			Result.append ("%%%"]():")
			if a_visitor.is_basic_type or a_visitor.vt_type = Vt_bool or a_visitor.is_enumeration then
				Result.append (a_visitor.cecil_type)
			else
				Result.append ("EIF_REFERENCE")
			end
			Result.append ("%"")
		ensure
			non_void_body: Result /= Void
			valid_body: not Result.is_empty		
		end

	external_setting_body (a_class_name, a_header_file_name: STRING; a_visitor: WIZARD_DATA_TYPE_VISITOR): STRING is
			-- External setting body
		require
			non_void_class_name: a_class_name /= Void
			valid_class_name: not a_class_name.is_empty
			non_void_header_file_name: a_header_file_name /= Void
			valud_header_file_name: not a_header_file_name.is_empty
			non_void_visitor: a_visitor /= Void
		do
			create Result.make (1000)
			Result.append ("%T%T%T%"C++ [")
			Result.append (a_class_name)
			Result.append (" %%%"")
			Result.append (a_header_file_name)
			Result.append ("%%%"](")
			if a_visitor.is_array_basic_type or a_visitor.is_interface or a_visitor.is_structure then
				Result.append (a_visitor.c_type)
				Result.append (" *")
			elseif a_visitor.is_structure_pointer then
				Result.append (a_visitor.c_type)
			elseif a_visitor.is_interface_pointer or a_visitor.is_coclass_pointer then
				Result.append ("IUnknown *")
			elseif a_visitor.is_basic_type or a_visitor.vt_type = Vt_bool or a_visitor.is_enumeration then
				Result.append (a_visitor.cecil_type)
			else
				Result.append ("EIF_OBJECT")
			end
			Result.append (")%"")
		ensure
			non_void_body: Result /= Void
			valid_body: not Result.is_empty		
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
end -- class WIZARD_EIFFEL_CLIENT_PROPERTY_GENERATOR

--+----------------------------------------------------------------
--| EiffelCOM Wizard
--| Copyright (C) 1999-2005 Eiffel Software. All rights reserved.
--| Eiffel Software Confidential
--| Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+----------------------------------------------------------------

