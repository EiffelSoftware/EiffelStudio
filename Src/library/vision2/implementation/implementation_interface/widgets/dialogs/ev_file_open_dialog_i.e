indexing 
	description: "EiffelVision file open dialog."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_FILE_OPEN_DIALOG_I

inherit
	EV_FILE_DIALOG_I
		redefine
			internal_accept
		end
	
feature {NONE} -- Implementation

	internal_accept: STRING is
			-- The text of the "ok" type button of `Current'.
			-- e.g. not the cancel button.
			-- See comment in EV_STANDARD_DIALOG_I.
		do
			Result := ev_open
		end

end -- class EV_FILE_OPEN_DIALOG_I

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

