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

	WIZARD_WRITER_DICTIONARY
		export
			{NONE} all
		end

	WIZARD_VARIABLE_NAME_MAPPER
		export
			{NONE} all
		end

	WIZARD_REJECTED_TYPE_LIBRARIES

feature -- Basic Operations

	set_common_fields (a_descriptor: WIZARD_TYPE_DESCRIPTOR) is
			-- Set common feilds in `a_descriptor'
		require
			valid_descriptor: a_descriptor /= Void
		do
			a_descriptor.set_name (name)
			if description /= Void and then not description.empty then
				a_descriptor.set_description (description)
			else
				a_descriptor.set_description (clone (No_description_available))
			end
			a_descriptor.set_eiffel_class_name (eiffel_class_name)
			a_descriptor.set_c_header_file_name (c_header_file_name)
			a_descriptor.set_c_type_name (c_type_name)
			a_descriptor.set_type_kind (type_kind)
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

	type_kind: INTEGER 
			-- Kind of descriptor

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

