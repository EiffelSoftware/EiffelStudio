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
			non_empty_header_file_name: not a_header_file_name.is_empty
			valid_header_file_name: a_header_file_name.substring_index (".h", 1) = 
								a_header_file_name.count - 1
		do
			Result := a_header_file_name.twin
			Result.insert_string ("_impl", Result.count - 1)
		ensure
			non_void_header_file_name: Result /= Void
			non_empty_header_file_name: not Result.is_empty
			valid_header_file_name: Result.substring_index (".h", 1) = Result.count - 1
		end

	macro_accesser_name (record_name: STRING; 
				field_descriptor: WIZARD_RECORD_FIELD_DESCRIPTOR): STRING is
			-- Name of accesser function.
		require
			non_void_record_name: record_name /= Void
			valid_record_name: not record_name.is_empty
			non_void_field_descriptor: field_descriptor /= Void
			non_void_field_name: field_descriptor.name /= Void
			valid_field_name: not field_descriptor.name.is_empty
		do
			create Result.make (100)

			Result.append ("ccom_")
			Result.append (name_for_feature (record_name))
			Result.append (Underscore)
			Result.append (name_for_feature (field_descriptor.name))
			Result.to_lower
		ensure
			non_void_accesser_name: Result /= Void
			valid_accesser_name: not Result.is_empty
		end

	macro_setter_name (record_name: STRING; 
				field_descriptor: WIZARD_RECORD_FIELD_DESCRIPTOR): STRING is
			-- Name of setter function.
		require
			non_void_record_name: record_name /= Void
			valid_record_name: not record_name.is_empty
			non_void_field_descriptor: field_descriptor /= Void
			non_void_field_name: field_descriptor.name /= Void
			valid_field_name: not field_descriptor.name.is_empty
		do
			create Result.make (100)

			Result.append ("ccom_")
			Result.append (name_for_feature (record_name))
			Result.append ("_set_")
			Result.append (name_for_feature (field_descriptor.name))
			Result.to_lower
		ensure
			non_void_accesser_name: Result /= Void
			valid_accesser_name: not Result.is_empty
		end

end -- class WIZARD_RECORD_GENERATOR

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

