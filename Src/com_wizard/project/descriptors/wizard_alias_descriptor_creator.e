indexing
	description: "Creator of Alias Descriptor"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_ALIAS_DESCRIPTOR_CREATOR

inherit
	WIZARD_TYPE_DESCRIPTOR_CREATOR

	WIZARD_SHARED_DESCRIPTOR_FACTORIES
		export
			{NONE} all
		end

	ECOM_TYPE_KIND

	WIZARD_SHARED_GENERATION_ENVIRONMENT
		export
			{NONE} all
		end

	WIZARD_SHARED_MAPPER_HELPERS
		export
			{NONE} all
		end

feature -- Basic operations

	create_descriptor (a_documentation: ECOM_DOCUMENTATION; a_type_info: ECOM_TYPE_INFO): WIZARD_ALIAS_DESCRIPTOR is
			-- Create descriptor.
		require
			valid_documentation: a_documentation /= Void and then
				a_documentation.name /= Void
			valid_type_info: a_type_info /= Void and then a_type_info.type_attr.type_kind = Tkind_alias
		local
			type_desc: ECOM_TYPE_DESC
			tmp_type_lib: ECOM_TYPE_LIB
			tmp_guid: ECOM_GUID
			tmp_lib_descriptor: WIZARD_TYPE_LIBRARY_DESCRIPTOR
		do
			name := a_documentation.name.twin
			description := a_documentation.doc_string.twin
			type_kind := a_type_info.type_attr.type_kind

			tmp_type_lib := a_type_info.containing_type_lib
			tmp_guid := tmp_type_lib.library_attributes.guid
			tmp_lib_descriptor := system_descriptor.library_descriptor (tmp_guid)
			add_type_lib_description (tmp_lib_descriptor)
			if name = Void or else name.count = 0 then
				create name.make (30)
				name.append ("alias_")
				name.append (tmp_lib_descriptor.name)
				name.append ("_")
				name.append_integer (a_type_info.index_in_type_lib + 1)
			end
			if prefixed_libraries.has (tmp_guid) then
				name.prepend (Underscore)
				name.prepend (tmp_lib_descriptor.name)
			end

			namespace := namespace_name (tmp_lib_descriptor.name)

			add_c_type
			create eiffel_class_name.make (50)
			eiffel_class_name.append (name_for_class (name, type_kind, False))
			eiffel_class_name.to_upper

			create c_type_name.make (30)
			c_type_name.append (name)
			
			create c_header_file_name.make (30)
			if not Non_generated_type_libraries.has (tmp_lib_descriptor.guid) then
				c_header_file_name.append ("ecom_aliases.h")
			end

			type_desc := a_type_info.type_attr.type_alias
			type_descriptor := data_type_descriptor_factory.create_data_type_descriptor 
					(a_type_info, type_desc, system_descriptor)

			if vartype_namer.is_basic (type_descriptor.type) then
				eiffel_class_name := vartype_namer.eiffel_name (type_descriptor.type).twin
			end

			create Result.make (Current)
		ensure
			valid_descriptor: Result /= Void
		end

	initialize_descriptor (a_descriptor: WIZARD_ALIAS_DESCRIPTOR) is
				-- Initialize `a_descriptor' attributes
			require
				valid_descriptor: a_descriptor /= Void
			do
				set_common_fields (a_descriptor)
				a_descriptor.set_type_descriptor (type_descriptor)
			end

feature {NONE} -- Implementation

	type_descriptor: WIZARD_DATA_TYPE_DESCRIPTOR;
			-- Description of data type to which this type is alias

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
end -- class WIZARD_ALIAS_DESCRIPTOR_CREATOR

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

