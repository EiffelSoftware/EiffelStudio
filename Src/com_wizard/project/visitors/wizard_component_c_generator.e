indexing
	description: "Component C generator."
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_COMPONENT_C_GENERATOR

inherit
	WIZARD_SHARED_DATA
		export
			{NONE} all
			{ANY} default_pointer
		end

	ECOM_INVOKE_KIND
		export
			{NONE} all
		end

	WIZARD_GUID_GENERATOR

end -- class WIZARD_COMPONENT_C_GENERATOR

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

