indexing
	description: "MIDL component creator"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EI_MIDL_COMPONENT_CREATOR

inherit
	EI_APP_CONSTANTS	

feature {NONE} -- Initialization

	make is
			-- Initialize object.
		do
			succeed := False
		end

feature -- Status report

	succeed: BOOLEAN
			-- Last operation succeed?

feature -- Basic operations

	create_from_eiffel_class (coclass: EI_CLASS) is
			-- Create from eiffel class.
		require
			non_void_coclass: coclass /= Void
		deferred
		end

end -- class EI_MIDL_COMPONENT_CREATOR

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

