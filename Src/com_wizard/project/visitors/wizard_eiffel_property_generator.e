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

