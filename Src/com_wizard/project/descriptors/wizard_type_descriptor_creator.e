indexing
	description: "Creator of Type Descriptor"
	status: "See notice at end of class"
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

feature -- Basic Operations

	add_c_type is
			-- Add `c_type_name' to system's list.
			-- Modify it to avoid name clashes in system.
		do
			from
			until
				not system_descriptor.c_types.has (name) and
				not is_forbidden_c_word (name)
			loop
				name.append ("_2")
			end
			system_descriptor.add_c_type (clone (name))
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
				description.append (Space)
			end
			description.append (a_type_lib.description)
		end

	set_common_fields (a_descriptor: WIZARD_TYPE_DESCRIPTOR) is
			-- Set common fields in `a_descriptor'
		require
			valid_descriptor: a_descriptor /= Void
		do
			a_descriptor.set_name (name)
			if description /= Void and then not description.is_empty then
				a_descriptor.set_description (description)
			else
				a_descriptor.set_description (clone (No_description_available))
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

	guid: ECOM_GUID
			-- GUID of type

end -- class WIZARD_TYPE_DESCRIPTOR_CREATOR

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

