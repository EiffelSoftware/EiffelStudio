indexing
	description: "C property generator"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_CPP_PROPERTY_GENERATOR

inherit
	WIZARD_CPP_FEATURE_GENERATOR
		export
			{NONE} all
		end

feature -- Access

	c_access_feature: WIZARD_WRITER_C_FUNCTION
			-- C access feature

	c_setting_feature: WIZARD_WRITER_C_FUNCTION
			-- C setting feature

	c_header_file: STRING 
			-- C header file name.
			-- Header file describing property type.

feature {NONE} -- Implementation

	set_header_file (a_header_file: STRING) is
			-- Set `c_header_file' with `a_header_file'
		require
			non_void_header_file: a_header_file /= Void
			valid_header_file: not a_header_file.is_empty
		do
			c_header_file := a_header_file.twin
		end

end -- class WIZARD_CPP_PROPERTY_GENERATOR

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

