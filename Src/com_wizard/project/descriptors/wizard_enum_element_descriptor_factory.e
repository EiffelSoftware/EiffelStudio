indexing
	description: "Factory of Enumeration Element Descriptors"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_ENUM_ELEMENT_DESCRIPTOR_FACTORY

feature -- Basic operations

	create_descriptor (a_documentation: ECOM_DOCUMENTATION; 
					a_value: INTEGER): WIZARD_ENUM_ELEMENT_DESCRIPTOR is
			-- Create description of element of enumerartion
		require
			valid_documentaion: a_documentation /= Void and then
				a_documentation.name /= Void
		do
			name := a_documentation.name
			value := a_value
			description := a_documentation.doc_string

			create Result.make (Current)
		ensure
			valid_name: name = a_documentation.name
			valid_value: value = a_value
		end

	initialize_descriptor (a_descriptor: WIZARD_ENUM_ELEMENT_DESCRIPTOR) is
			-- Initialize `a_descriptor' fields
		require
			valid_descriptor: a_descriptor /= Void
		do
			a_descriptor.set_name (name)
			a_descriptor.set_value (value)
			a_descriptor.set_description (description)
		end

feature {NONE} -- Implementation

	name: STRING
			-- element name

	value: INTEGER
			-- element value

	description: STRING
			-- help string

end -- class WIZARD_ENUM_ELEMENT_DESCRIPTOR_FACTORY

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
