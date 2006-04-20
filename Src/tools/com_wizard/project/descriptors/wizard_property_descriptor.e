indexing
	description: "Dispinterface property description"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
class
	WIZARD_PROPERTY_DESCRIPTOR

inherit
	WIZARD_FEATURE_DESCRIPTOR
		redefine
			disambiguate_coclass_names,
			disambiguate_interface_names
		end

	ECOM_VAR_FLAGS
		export
			{WIZARD_PROPERTY_DESCRIPTOR_FACTORY} all
		end

creation
	make

feature -- Initialization

	make (a_creator: WIZARD_PROPERTY_DESCRIPTOR_FACTORY) is
			-- Initialize
		require
			valid_creator: a_creator /= Void
		do
			a_creator.initialize_descriptor (Current)
			create components_eiffel_names.make (5)
		ensure
			non_void_name: name /= Void 
			valid_name: not name.is_empty
			valid_data_type: data_type /= Void
			non_void_components_eiffel_names: components_eiffel_names /= Void
		end

feature -- Access

	data_type: WIZARD_DATA_TYPE_DESCRIPTOR
			-- Field's type

	is_read_only: BOOLEAN
			-- Is property read-only?

	to_string: STRING is
			-- String representation used for output
		do
			Result := name.twin
			Result.append (": ")
			Result.append (data_type.name)
			Result.append (" (")
			Result.append (Open_parenthesis)
			Result.append (member_id.out)
			Result.append (")")
		end

feature -- Status Report

	is_equal_property (other: WIZARD_PROPERTY_DESCRIPTOR): BOOLEAN is
			--
		require
			non_void_other: other /= Void
		do
			Result := name.is_equal (other.name) and 
				data_type.is_equal_data_type (other.data_type)
		ensure
			symmetric: Result implies other.is_equal_property (Current)
		end

feature -- Transformation

	disambiguate_coclass_names (a_interface_descriptor: WIZARD_INTERFACE_DESCRIPTOR; a_coclass_descriptor: WIZARD_COCLASS_DESCRIPTOR) is
			-- Disambiguate names for coclass.
		local
			l_name, l_coclass_name: STRING
			l_names: HASH_TABLE [WIZARD_INTERFACE_DESCRIPTOR, STRING]
			l_c_names: LIST [STRING]
		do
			Precursor {WIZARD_FEATURE_DESCRIPTOR} (a_interface_descriptor, a_coclass_descriptor)
			l_name := interface_eiffel_name.twin
			l_name.prepend ("set_")
			l_names := a_coclass_descriptor.feature_eiffel_names
			l_names.force (a_interface_descriptor, l_name)
			l_name:= interface_eiffel_name.twin
			l_name.prepend ("set_ref_")
			l_names.force (a_interface_descriptor, l_name)
			if is_renamed_in (a_coclass_descriptor) then
				l_coclass_name := components_eiffel_names.item (a_coclass_descriptor.name).twin
				create l_name.make (l_coclass_name.count + 4)
				l_name.append ("set_")
				l_name.append (l_coclass_name)
				l_names.force (a_interface_descriptor, l_name)
				create l_name.make (l_coclass_name.count + 8)
				l_name.append ("set_ref_")
				l_name.append (l_coclass_name)
				l_names.force (a_interface_descriptor, l_name)
			end
			create l_name.make (name.count + 4)
			l_name.append ("set_")
			l_name.append (name)
			l_c_names := a_coclass_descriptor.feature_c_names
			l_c_names.force (l_name)
			create l_name.make (name.count + 8)
			l_name.append ("set_ref_")
			l_name.append (name)
			l_c_names.force (l_name)
		end

	disambiguate_interface_names (a_interface_descriptor: WIZARD_INTERFACE_DESCRIPTOR) is
			-- Disambiguate names for interface.
		local
			l_name, l_setter: STRING
			l_names: LIST [STRING]
		do
			l_name := interface_eiffel_name.as_lower
			l_names := a_interface_descriptor.feature_eiffel_names
			l_name := unique_identifier (l_name, agent has_name_or_accessors (l_names, ?))
			l_names.force (l_name)
			l_setter := setter_feature_name (l_name)
			l_names.force (l_setter)
			l_setter := ref_setter_feature_name (l_name)
			l_names.force (l_setter)
		end

feature {WIZARD_PROPERTY_DESCRIPTOR_FACTORY} -- Basic operations

	set_description (a_description: STRING) is
			-- Set `description' with `a_description'.
		require
			valid_description: a_description /= Void
		do
			description := a_description
		ensure
			description_set: description = a_description
		end

	set_data_type (a_data_type: WIZARD_DATA_TYPE_DESCRIPTOR) is
			-- Set `data_type' with `a_data_type'.
		require
			valid_data_type: a_data_type /= Void
			do
				data_type := a_data_type
			ensure
				valid_data_type: data_type /= Void and data_type = a_data_type
			end

	set_member_id (a_member_id: INTEGER) is
			-- Set `member_id' with `a_member_id'.
		do
			member_id := a_member_id
		ensure
			valid_member_id: member_id = a_member_id
		end

	set_is_read_only (a_bool: BOOLEAN) is
			-- Set `is_read_only' with `a_bool'.
		do
			is_read_only := a_bool
		ensure
			is_read_only_set: is_read_only = a_bool
		end

feature {NONE} -- Implementation

	setter_feature_name (a_name: STRING): STRING is
			-- Property setter feature name of property with name `a_name'
		require
			non_void_name: a_name /= Void
		do
			create Result.make (a_name.count + 4)
			Result.append ("set_")
			Result.append (a_name)
		ensure
			non_void_setter_name: Result /= Void
		end
		
	ref_setter_feature_name (a_name: STRING): STRING is
			-- Property reference setter feature name of property with name `a_name'
		require
			non_void_name: a_name /= Void
		do
			create Result.make (a_name.count + 8)
			Result.append ("set_ref_")
			Result.append (a_name)
		ensure
			non_void_ref_setter_name: Result /= Void
		end

	has_name_or_accessors (a_list: LIST [STRING]; a_name: STRING): BOOLEAN is
			-- Does `a_list' or `Eiffel_keywords' have `a_name' or one of its derived accessors?
		require
			non_void_list: a_list /= Void
			non_void_name: a_name /= Void
		local
			l_setter: STRING
		do
			Result := Eiffel_keywords.has (a_name) or a_list.has (a_name)
			if not Result then
				l_setter := setter_feature_name (a_name)
				Result := a_list.has (l_setter)
				if not Result then
					l_setter := ref_setter_feature_name (a_name)
					Result := a_list.has (l_setter)
				end
			end
		ensure
			definition: Result = a_list.has (a_name)  or
								a_list.has (setter_feature_name (a_name)) or
								a_list.has (ref_setter_feature_name (a_name)) or
								Eiffel_keywords.has (a_name)
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
end -- class WIZARD_PROPERTY_DESCRIPTOR

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

