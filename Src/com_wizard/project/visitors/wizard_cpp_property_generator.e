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
			c_header_file := clone (a_header_file)
		end

end -- class WIZARD_CPP_PROPERTY_GENERATOR

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
 
