indexing
	description: "Description of element of enumeration"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_ENUM_ELEMENT_DESCRIPTOR

inherit
	WIZARD_DESCRIPTOR

	WIZARD_WRITER_DICTIONARY
		export
			{NONE} all
		end

creation
	make

feature {NONE} -- Initialization

	make (a_creator: WIZARD_ENUM_ELEMENT_DESCRIPTOR_FACTORY) is
			-- Initialize
		require
			valid_creator: a_creator /= Void
		do
			a_creator.initialize_descriptor (Current)
		ensure
			non_void_name: name /= Void
			valid_name: not name.is_empty
		end
	
feature -- Access

	name: STRING
			-- element name

	value: INTEGER
			-- element value

	description: STRING
			-- help string

feature -- Basic operations

	set_name (a_name: STRING) is
			-- Set `name' with `a_name'.
		require
			valid_name: a_name /= Void and then not a_name.is_empty
		do
			name := clone (a_name)
		ensure
			valid_name: name /= Void and then not name.is_empty and name.is_equal (a_name)
		end

	set_value (a_value: INTEGER) is
			-- Set `value' with `a_value'.
		do
			value := a_value
		ensure
			valid_value: value = a_value
		end

	set_description (a_description: STRING) is
			-- Set `description' with `a_description'.
		require
			non_void_description: a_description /= Void
		do
			if a_description.is_empty then
				description := clone (No_description_available)
			else
				description := clone (a_description)
			end
		ensure
			non_void_description: description /= Void
			valid_description: not description.is_empty
					and (not a_description.is_empty implies description.is_equal (a_description))
		end

end -- WIZARD_ENUM_ELEMENT_DESCRIPTOR

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


