indexing
	description: "Objects that ..."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_RECORD_FIELD_VISITOR

--inherit
--	WIZARD_DATA_TYPE_VISITOR
--		rename
--		export
--		undefine
--		redefine
--		select
--		end

feature -- Processing

	process_field (a_record_descriptor: WIZARD_RECORD_DESCRIPTOR; 
				a_field: WIZARD_RECORD_FIELD_DESCRIPTOR) is
			--
		local
			a_field_structure_def: STRING
			an_access_macro: STRING
		do
			a_field_structure_def := generate_field_structure_def (a_field)
			an_access_macro := access_macro (a_record_descriptor, a_field)
		end

	generate_field_structure_def (a_field: WIZARD_RECORD_FIELD_DESCRIPTOR): STRING is
			-- Generate field in structure definition
		require
			valid_field: a_field /= Void
		do
			create Result.make (0)
--			a_field.data_type.define_names
--			Result.append (a_field.data_type.c_type)
--			Result.append (" ")
--			Result.append (a_field.name)
--			Result.append (a_field.data_type.c_post_type)
--			Result.append ("%N")
		ensure
			valid_result: Result /= Void and then not Result.empty	
		end


	access_macro (a_record_descriptor: WIZARD_RECORD_DESCRIPTOR; 
							a_field: WIZARD_RECORD_FIELD_DESCRIPTOR): STRING is
			-- Generate access macro.
		require
			valid_record_descriptor: a_record_descriptor /= Void
			valid_field: a_field /= Void
		local
			an_access_macro_name: STRING
			an_access_macro: STRING
		do
			create an_access_macro_name.make (0)
			create an_access_macro.make (0)
--			a_field.data_type.visit (Current)
		end

feature -- Processing

--	process_safearray_data_type (a_safearray_descriptor: WIZARD_SAFEARRAY_DATA_TYPE_DESCRIPTOR) is
--			-- Process SAFEARRAY
--		do
--		end

--	process_automation_data_type (an_automation_descriptor: WIZARD_AUTOMATION_DATA_TYPE_DESCRIPTOR) is
--			-- Process Automation Data Type
--		do
--		end

--	process_array_data_type (an_array_descriptor: WIZARD_ARRAY_DATA_TYPE_DESCRIPTOR) is
--			-- Process Array
--		do
--		end

--	process_user_defined_data_type (a_user_defined_descriptor: WIZARD_USER_DEFINED_DATA_TYPE_DESCRIPTOR) is
--			-- Process User Defined Data Type
--		do
--		end

--	process_pointed_data_type (a_pointed_descriptor: WIZARD_POINTED_DATA_TYPE_DESCRIPTOR) is
--			-- Process pointed Data Type
--		do
--		end

end -- class WIZARD_RECORD_FIELD_VISITOR

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

