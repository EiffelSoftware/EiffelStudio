indexing
	description: "Type descriptor"
	status: "See notice at end of class"
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

feature -- Basic Operations

	set_name (a_name: STRING) is
			-- Set `name' with `a_name'
		require
			valid_name: a_name /= Void and then not a_name.is_empty
		do
			name := clone (a_name)
		ensure
			valid_name: name /= Void and name.is_equal (a_name)
		end

	set_description (a_description: STRING) is
			-- Set `description' with `a_description'
		require
			non_void_description: a_description /= Void
		do
			if not a_description.is_empty then
				description := clone (a_description)
			else
				description := clone (No_description_available)
			end
		ensure
			non_void_description: description /= Void
			valid_description: not a_description.is_empty
		end

	set_eiffel_class_name (a_name: STRING) is
			-- Set `eiffel_class_name' with `a_name'
		require
			valid_name: a_name /= Void and then not a_name.is_empty
		do
			eiffel_class_name := clone (a_name)
		ensure
			valid_eiffel_class_name: eiffel_class_name /= Void and then not eiffel_class_name.is_empty
						and eiffel_class_name.is_equal (a_name)
		end

	set_c_header_file_name (a_name: STRING) is
			-- Set `c_header_file_name' with `a_name'
		require
			non_void_name: a_name /= Void
		do
			c_header_file_name := clone (a_name)
		ensure
			valid_c_header_file_name: c_header_file_name /= Void
			valid_c_header_file_name: c_header_file_name.is_equal (a_name)
		end

	set_c_type_name (a_name: STRING) is
			-- Set `c_type_name' with `a_name'
		require
			non_void_name: a_name /= Void
		do
			c_type_name := clone (a_name)
		ensure
			valid_c_type_name: c_type_name /= Void
			valid_c_type_name: c_type_name.is_equal (a_name)
		end

	set_namespace (a_namespace : STRING) is
			-- Set `namespace' with `a_namespace'.
		require
			non_void_namespace: a_namespace /= Void
		do
			namespace  := clone (a_namespace )
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

end -- class WIZARD_TYPE_DESCRIPTOR

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-1999 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

