indexing
	description: "Coclass C generator"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_COCLASS_C_GENERATOR

inherit
	WIZARD_COMPONENT_C_GENERATOR

	WIZARD_CPP_WRITER_GENERATOR

feature -- Access

	interface_names: LIST [STRING]
			-- Interface names.

	dispinterface_names: LIST [STRING]
			-- Names of dispinterfaces.

feature {NONE} -- Implementation

end -- class WIZARD_COCLASS_C_GENERATOR

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

