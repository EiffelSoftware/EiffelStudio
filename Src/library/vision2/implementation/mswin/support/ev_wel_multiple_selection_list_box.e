indexing
	description: "EiffelVision multiple selection list box. An  %
			% adapted wel_multiple_selection_list_box for %
			% Eiffel Vision."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_WEL_MULTIPLE_SELECTION_LIST_BOX

inherit
	EV_WEL_LIST_BOX

	WEL_MULTIPLE_SELECTION_LIST_BOX
		rename
			make as wel_make
		undefine
			on_lbn_dblclk,
			on_lbn_selchange
		end

creation

	make

end -- class EV_WEL_MULTIPLE_SELECTION_LIST_BOX

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
--|---------------------------------------------------------------
