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

