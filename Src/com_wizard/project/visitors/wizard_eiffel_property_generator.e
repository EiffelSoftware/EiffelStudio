indexing
	description: "Eiffel property generator"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_EIFFEL_PROPERTY_GENERATOR

inherit
	WIZARD_EIFFEL_ASSERTION_GENERATOR
		export
			{NONE} all
		end

	ECOM_VAR_FLAGS
		export
			{NONE} all
		end

feature -- Access

	access_feature: WIZARD_WRITER_FEATURE
 			-- Access feature

	external_access_feature: WIZARD_WRITER_FEATURE
			-- External access feature

	external_setting_feature: WIZARD_WRITER_FEATURE
			-- External setting feature

	setting_feature: WIZARD_WRITER_FEATURE
			-- Setting feature

	property_renamed: BOOLEAN
			-- Property is renamed?

	changed_names: HASH_TABLE[STRING, STRING]
			-- Changed names
			-- Original name as key

end -- class WIZARD_EIFFEL_PROPERTY_GENERATOR

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
