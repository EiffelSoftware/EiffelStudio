indexing
	description: ""
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_SHARED_VISITOR_FACTORIES

feature -- Access

	C_client_visitor: WIZARD_C_CLIENT_VISITOR is
			-- C Client visitor
		once
			Create Result
		end

	Eiffel_client_visitor: WIZARD_EIFFEL_CLIENT_VISITOR is
			-- Eiffel client visitor
		once
			Create Result
		end

	C_server_visitor: WIZARD_C_SERVER_VISITOR is
			-- C server visitor
		once
			Create Result
		end

	Eiffel_server_visitor: WIZARD_EIFFEL_SERVER_VISITOR is
			-- Eiffel server visitor
		once
			Create Result
		end

end -- class WIZARD_SHARED_VISITOR_FACTORIES

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
  