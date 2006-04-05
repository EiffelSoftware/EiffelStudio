indexing
	description: "Creator of Type Descriptor"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_TYPE_DESCRIPTOR_CREATOR

inherit
	WIZARD_SHARED_GENERATION_ENVIRONMENT
		export
			{NONE} all
		end

	WIZARD_FORBIDDEN_NAMES
		export
			{NONE} all
		end

	WIZARD_WRITER_DICTIONARY
		export
			{NONE} all
		end

	WIZARD_VARIABLE_NAME_MAPPER
		export
			{NONE} all
		end

	WIZARD_SPECIAL_TYPE_LIBRARIES

	WIZARD_UNIQUE_IDENTIFIER_FACTORY
		export
			{NONE} all
		end

feature -- Basic Operations

	add_c_type is
			-- Add `c_type_name' to system's list.
			-- Modify it to avoid name clashes in system if it's not a standard structure.
		do
			c_type_name := unique_identifier (name, agent has_c_type_or_is_forbidden)
			system_descriptor.add_c_type (c_type_name.twin)
		end

	add_type_lib_description (a_type_lib: WIZARD_TYPE_LIBRARY_DESCRIPTOR) is
			-- Add Type Library description to type descriptor.
		require
			non_void_type_lib: a_type_lib /= Void
		do
			if description = Void then
				create description.make (100)
			end
			if not description.is_empty then
				description.append (" ")
			end
			description.append (a_type_lib.description)
		end

	set_common_fields (a_descriptor: WIZARD_TYPE_DESCRIPTOR) is
			-- Set common fields in `a_descriptor'
		require
			valid_descriptor: a_descriptor /= Void
		do
			a_descriptor.set_name (name)
			if description /= Void then
				a_descriptor.set_description (description)
			else
				a_descriptor.set_description ("")
			end
			a_descriptor.set_eiffel_class_name (eiffel_class_name)
			a_descriptor.set_c_header_file_name (c_header_file_name)
			a_descriptor.set_c_type_name (c_type_name)
			a_descriptor.set_namespace (namespace)
			a_descriptor.set_type_kind (type_kind)
			if guid /= Void then
				a_descriptor.set_guid (guid)
			end
		ensure
			name_set: a_descriptor.name /= Void
		end

feature {NONE} -- Implementation

	has_c_type_or_is_forbidden (a_name: STRING): BOOLEAN is
			-- Does `system_descriptor.c_types' have `a_name' or `is_forbidden_c_word'?
		do
			Result := is_forbidden_c_word (a_name)
			if not Result then
				Result := system_descriptor.c_types.has (a_name)
			end
		ensure
			definition: Result = (system_descriptor.c_types.has (a_name) or is_forbidden_c_word (a_name))
		end

	name: STRING
			-- Type name

	description: STRING
			-- Type description

	eiffel_class_name: STRING
			-- Name of Eiffel class

	c_header_file_name: STRING
			-- Name of "C" header file

	c_type_name: STRING
			-- Name of "C" type

	namespace: STRING
			-- Namespace 

	type_kind: INTEGER 
			-- Kind of descriptor

	guid: ECOM_GUID;
			-- GUID of type

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
end -- class WIZARD_TYPE_DESCRIPTOR_CREATOR

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

