indexing
	description: "C type generator"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_CPP_WRITER_GENERATOR

inherit
	WIZARD_TYPE_GENERATOR

	WIZARD_WRITER_CPP_EXPORT_STATUS
		export
			{NONE} all
		end


feature -- Access

	cpp_class_writer: WIZARD_WRITER_CPP_CLASS
			-- Cpp implementation writer


end -- class WIZARD_C_WRITER_GENERATOR

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

