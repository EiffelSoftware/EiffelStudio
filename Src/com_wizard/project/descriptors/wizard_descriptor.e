indexing
	description: "Descriptor; describes a type library element"
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	WIZARD_DESCRIPTOR

inherit
	WIZARD_WRITER_DICTIONARY
		export
			{NONE} all;
			{ANY} generator
		end

feature -- Access

	name: STRING is
			-- Name of element
		deferred
		end

	description: STRING is
			-- Description of element
		deferred
		end

end -- class WIZARD_DESCRIPTOR

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

