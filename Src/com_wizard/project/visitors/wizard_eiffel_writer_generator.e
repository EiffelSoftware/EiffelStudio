indexing
	description: "Eiffel writer generator"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_EIFFEL_WRITER_GENERATOR

inherit
	WIZARD_TYPE_GENERATOR

	WIZARD_WRITER_FEATURE_CLAUSES
		export
			{NONE} all
		end

feature -- Access

	eiffel_writer: WIZARD_WRITER_EIFFEL_CLASS
			
end -- class WIZARD_EIFFEL_WRITER_GENERATOR

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

