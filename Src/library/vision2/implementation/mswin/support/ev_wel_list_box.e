indexing
	description: "EiffelVision list box. An adapted wel_list_box %
				% for Eiffel Vision."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_WEL_LIST_BOX

inherit
	WEL_LIST_BOX
		rename
			make as wel_make
		redefine
			on_lbn_selchange,
			on_lbn_dblclk
		end

feature {NONE} -- Initialization

	make (wel_parent: WEL_COMPOSITE_WINDOW; ev_list: EV_LIST_IMP) is
			-- Set the `list' of the class to `ev_list' 
		do
			wel_make (wel_parent, 0, 0, 100, 20, 0)
			list := ev_list
		end

feature -- Access

	list: EV_LIST_IMP

feature -- Status report

	caret_index: INTEGER is
			-- Index of the item that has the focus
		deferred
		end

feature -- Notifications

	on_lbn_selchange is
			-- The selection is about to change
		do
			list.on_lbn_selchange
		end

	on_lbn_dblclk is
			-- Double click on a string
		do
			list.on_lbn_dblclk
		end

end -- class EV_WEL_LIST_BOX

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
