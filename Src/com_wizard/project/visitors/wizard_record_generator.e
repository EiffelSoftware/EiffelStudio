indexing
	description: "Record generator"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_RECORD_GENERATOR

inherit
	WIZARD_VARIABLE_NAME_MAPPER

feature {NONE} -- Implementation

	impl_header_file_name (a_header_file_name: STRING): STRING is
			-- Name of implementation header file.
		require
			non_void_header_file_name: a_header_file_name /= Void
			non_empty_header_file_name: not a_header_file_name.empty
			valid_header_file_name: a_header_file_name.substring_index (".h", 1) = 
								a_header_file_name.count - 1
		do
			Result := clone (a_header_file_name)
			Result.insert ("_impl", Result.count - 1)
		ensure
			non_void_header_file_name: Result /= Void
			non_empty_header_file_name: not Result.empty
			valid_header_file_name: Result.substring_index (".h", 1) = Result.count - 1
		end

	macro_accesser_name (record_name: STRING; 
				field_descriptor: WIZARD_RECORD_FIELD_DESCRIPTOR): STRING is
			-- Name of accesser function.
		require
			non_void_record_name: record_name /= Void
			valid_record_name: not record_name.empty
			non_void_field_descriptor: field_descriptor /= Void
			non_void_field_name: field_descriptor.name /= Void
			valid_field_name: not field_descriptor.name.empty
		do
			create Result.make (100)

			Result.append ("ccom_")
			Result.append (name_for_feature (record_name))
			Result.append (Underscore)
			Result.append (name_for_feature (field_descriptor.name))
			Result.to_lower
		ensure
			non_void_accesser_name: Result /= Void
			valid_accesser_name: not Result.empty
		end

	macro_setter_name (record_name: STRING; 
				field_descriptor: WIZARD_RECORD_FIELD_DESCRIPTOR): STRING is
			-- Name of setter function.
		require
			non_void_record_name: record_name /= Void
			valid_record_name: not record_name.empty
			non_void_field_descriptor: field_descriptor /= Void
			non_void_field_name: field_descriptor.name /= Void
			valid_field_name: not field_descriptor.name.empty
		do
			create Result.make (100)

			Result.append ("ccom_")
			Result.append (name_for_feature (record_name))
			Result.append ("_set_")
			Result.append (name_for_feature (field_descriptor.name))
			Result.to_lower
		ensure
			non_void_accesser_name: Result /= Void
			valid_accesser_name: not Result.empty
		end

end -- class WIZARD_RECORD_GENERATOR

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

