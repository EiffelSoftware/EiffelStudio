indexing

	description: "Generator of a widget manager";
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class

	W_MAN_GEN

feature {NONE} -- Implementation

	widget_manager: W_MANAGER is
			-- EiffelVision widget manager 
		once
			!! Result.make
		ensure
			Valid_result: Result /= Void
		end

end -- class W_MAN_GEN

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1989, 1991, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--|----------------------------------------------------------------

