indexing
	description: "Component client generator."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_COMPONENT_CLIENT_GENERATOR

feature -- Access

	ccom_last_error_code_name: STRING is "ccom_last_error_code"
			-- Name of last error code external feature.

	ccom_last_source_of_exception_name: STRING is "ccom_last_source_of_exception"
			-- Name of last source of exception external feature.

	ccom_last_error_description_name: STRING is "ccom_last_error_description"
			-- Name of last error description external feature.

	ccom_last_error_help_file_name: STRING is "ccom_last_error_help_file"
			-- Name of last error help file external feature.

	last_error_code_name: STRING is "last_error_code"
			-- Name of last error code  feature.

	last_source_of_exception_name: STRING is "last_source_of_exception"
			-- Name of last source of exception  feature.

	last_error_description_name: STRING is "last_error_description"
			-- Name of last error description  feature.

	last_error_help_file_name: STRING is "last_error_help_file"
			-- Name of last error help file  feature.


end -- class WIZARD_COMPONENT_CLIENT_GENERATOR

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
