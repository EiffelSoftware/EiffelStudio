indexing
	description: "EiffelVision dialog. Mswindows interface."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_DIALOG_IMP

inherit
	EV_DIALOG_I

	EV_WINDOW_IMP
		undefine
			build
		redefine
			default_style
		end

creation
	make

feature {NONE} -- Implementation

	default_style: INTEGER is
		do
			Result := Ws_border + Ws_dlgframe + Ws_sysmenu 
					+ Ws_overlapped + Ws_clipchildren
					+ Ws_clipsiblings
		end

end -- class EV_DIALOG_IMP

--|----------------------------------------------------------------
--| Windows Eiffel Library: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
