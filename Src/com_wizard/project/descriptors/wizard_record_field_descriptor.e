indexing
	description: "Structure's field description"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
class
	WIZARD_RECORD_FIELD_DESCRIPTOR

inherit
	WIZARD_WRITER_DICTIONARY
		export
			{NONE} all
		undefine
			is_equal
		end

	COMPARABLE

creation
	make

feature -- Initialization

	make (a_creator: WIZARD_RECORD_FIELD_DESCRIPTOR_FACTORY) is
			-- Initialize
		require
			valid_creator: a_creator /= Void
		do
			a_creator.initialize_descriptor (Current)
		ensure
			valid_name: name /= Void and then name.count /= 0
			valid_data_type: data_type /= Void
		end

feature -- Access

	name: STRING
			-- Field name

	description: STRING
			-- Help string

	data_type: WIZARD_DATA_TYPE_DESCRIPTOR
			-- Field's type

	offset: INTEGER
			-- Offeset of field within structure

feature -- Basic Operations

	set_name (a_name: STRING) is
			-- Set `name' with `a_name'
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
		do
			name := clone (a_name)
		ensure
			valid_name: name /= Void and then not name.is_empty and name.is_equal (a_name)
		end

	set_description (a_description: STRING) is
			-- Set `description' with `a_description'.
		require
			non_void_description: a_description /= Void
		do
			if not a_description.is_empty then
				description := clone (a_description)
			else
				description := clone (No_description_available)
			end
		ensure
			valid_description: description /= Void and then not description.is_empty
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

	set_offset (an_offset: INTEGER) is
			-- Set `offset' with `an_offset'.
		do
			offset := an_offset
		ensure
			valid_offset: offset = an_offset
		end

feature -- Comparison

	infix "<" (other: like Current): BOOLEAN is
			-- Is current object less than `other'?
		do
			Result := offset < other.offset
		end;

end -- class WIZARD_RECORD_FIELD_DESCRIPTOR

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

