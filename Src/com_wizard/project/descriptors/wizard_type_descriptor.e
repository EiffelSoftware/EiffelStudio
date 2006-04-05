indexing
	description: "Type descriptor"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"


deferred class
	WIZARD_TYPE_DESCRIPTOR

inherit
	WIZARD_DESCRIPTOR

	ECOM_TYPE_KIND
		export
			{NONE} all
			{ANY} is_valid_type_kind
		end

	WIZARD_WRITER_DICTIONARY
		export
			{NONE} all
		end

	WIZARD_SHARED_GENERATION_ENVIRONMENT
		export
			{NONE} all
			{ANY} system_descriptor
		end

	WIZARD_GUIDS
		export
			{NONE} all
		end

feature -- Access

	eiffel_class_name: STRING
			-- Name of Eiffel class

	c_header_file_name: STRING
			-- Name of "C" header file

	c_type_name: STRING
			-- Name of "C" type

	namespace: STRING
			-- Namespace 

	guid: ECOM_GUID
			-- GUID of type

	type_kind: INTEGER 
			-- Kind of descriptor
			-- See class ECOM_TYPE_KIND for values

	name: STRING
			-- Type name

	description: STRING
			-- Type description

	creation_message: STRING is
			-- Creation message for wizard output
		deferred
		end

	data_type_visitor: WIZARD_DATA_TYPE_VISITOR
			-- Data type visitor.

	pointed_data_type_visitor: WIZARD_DATA_TYPE_VISITOR
			-- Pointed data type visitor.

	pointed_pointed_data_type_visitor: WIZARD_DATA_TYPE_VISITOR
			-- Pointed pointed data type visitor.

	is_iunknown: BOOLEAN
			-- Does this descriptor correspond to interface IUnknown?

	is_idispatch: BOOLEAN
			-- Does this descriptor correspond to interface IDispatch?
	
	is_well_known_interface: BOOLEAN is
			-- Does this descriptor correspond to a well known interface?
		do
			Result := is_iunknown or is_idispatch or (guid /= Void and then guid.is_equal (Itypeinfo_guid))
		end

feature -- Basic Operations

	set_name (a_name: STRING) is
			-- Set `name' with `a_name'
		require
			valid_name: a_name /= Void and then not a_name.is_empty
		do
			name := a_name.twin
		ensure
			valid_name: name /= Void and name.is_equal (a_name)
		end

	set_description (a_description: STRING) is
			-- Set `description' with `a_description'
		require
			non_void_description: a_description /= Void
		do
			description := a_description.twin
		ensure
			description_set: description.is_equal (a_description)
		end

	set_eiffel_class_name (a_name: STRING) is
			-- Set `eiffel_class_name' with `a_name'
		require
			valid_name: a_name /= Void and then not a_name.is_empty
		do
			eiffel_class_name := a_name.twin
		ensure
			valid_eiffel_class_name: eiffel_class_name /= Void and then not eiffel_class_name.is_empty
						and eiffel_class_name.is_equal (a_name)
		end

	set_c_header_file_name (a_name: STRING) is
			-- Set `c_header_file_name' with `a_name'
		require
			non_void_name: a_name /= Void
		do
			c_header_file_name := a_name.twin
		ensure
			valid_c_header_file_name: c_header_file_name /= Void
			valid_c_header_file_name: c_header_file_name.is_equal (a_name)
		end

	set_c_type_name (a_name: STRING) is
			-- Set `c_type_name' with `a_name' and initialize variable_name
		require
			non_void_name: a_name /= Void
		do
			c_type_name := a_name.twin
		ensure
			valid_c_type_name: c_type_name /= Void
			valid_c_type_name: c_type_name.is_equal (a_name)
		end

	set_namespace (a_namespace : STRING) is
			-- Set `namespace' with `a_namespace'.
		require
			non_void_namespace: a_namespace /= Void
		do
			namespace  := a_namespace.twin
		ensure
			valid_namespace: namespace  /= Void
			valid_namespace: namespace .is_equal (a_namespace )
		end

	set_type_kind (a_kind: INTEGER) is
			-- Set `type_kind' with `a_kind'
		require
			valid_kind: is_valid_type_kind (a_kind)
		do
			type_kind := a_kind
		ensure
			valid_type_kind: is_valid_type_kind (type_kind) and type_kind = a_kind
		end

	set_guid (a_guid: ECOM_GUID) is
			-- Set `guid' with `a_guid'.
		require
			non_void_guid: a_guid /= Void
		do
			guid := a_guid
		ensure
			non_void_guid: guid /= Void
			valid_guid: guid = a_guid
		end

	set_data_type_visitor (a_data_visitor: WIZARD_DATA_TYPE_VISITOR) is
			-- Set `data_type_visitor' with `a_data_visitor'
		do
			data_type_visitor := a_data_visitor
		end

	set_pointed_data_type_visitor (a_data_visitor: WIZARD_DATA_TYPE_VISITOR) is
			-- Set `data_type_visitor' with `a_data_visitor'
		do
			pointed_data_type_visitor := a_data_visitor
		end

	set_pointed_pointed_data_type_visitor (a_data_visitor: WIZARD_DATA_TYPE_VISITOR) is
			-- Set `data_type_visitor' with `a_data_visitor'
		do
			pointed_pointed_data_type_visitor := a_data_visitor
		end

feature -- Visitor

	visit (a_visitor: WIZARD_TYPE_VISITOR) is
			-- Call back `a_visitor' with appropriate feature.
		require
			non_void_visitor: a_visitor /= Void
		deferred
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
end -- class WIZARD_TYPE_DESCRIPTOR

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

