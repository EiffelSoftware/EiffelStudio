indexing
	description: 
		"EiffelVision popup menu. Mswindows implementation."
	status: "See notice at end of class"
	id: "$$"
	date: "$Date$"
	revision: "$Revision$"

class 
	EV_POPUP_MENU_IMP

inherit
	EV_POPUP_MENU_I

	EV_MENU_ITEM_HOLDER_IMP

	WEL_MENU
		rename
			insert_separator as wel_insert_separator
		redefine
			make
		end

creation
	make

feature {NONE} -- Initialization

	make is         
			-- Create an empty popup menu.
		do
			make_track
		end

feature -- Access

	parent_imp: EV_CONTAINER_IMP
			-- Implementation of the parent.

	menu: WEL_MENU is
			-- Wel menu used when the item is a sub-menu.
		do
			Result := Current
		end

	item_handler: EV_MENU_ITEM_HANDLER_IMP is
			-- The handler of the item.
		do
			Result := parent_imp
		end

feature -- Status report

	destroyed: BOOLEAN is
			-- Is Current object destroyed?
		do
			Result := not exists
		end

feature -- Status setting

	destroy is
			-- Destroy actual object.
		do
			interface.remove_implementation
			interface := Void
			remove_children
			-- After, it will be collected
		end

feature -- Element change

	set_parent (par: EV_CONTAINER) is
			-- Make `par' the new parent of the popup.
		do
			parent_imp ?= par.implementation
		end

feature -- Basic operations

	show is
			-- Show the popup menu at the current position
			-- of the mouse.
		local
			point: WEL_POINT
			ww: WEL_COMPOSITE_WINDOW
		do
			if count /= 0 then
				ww ?= parent_imp
				create point.make (0, 0)
				point.set_cursor_position
				show_track (point.x, point.y, ww)
			end
		end

	show_at_position (x, y: INTEGER) is
			-- Show the popup menu at the given absolute position.
		local
			ww: WEL_COMPOSITE_WINDOW
		do
			if count /= 0 then
				ww ?= parent_imp
				show_track (x, y, ww)
			end
		end

feature {NONE} -- Inapplicable

	on_selection_changed (sitem: EV_MENU_ITEM_IMP) is
			-- `sitem' has been selected'
			-- do nothing here
		do
			check
				Inapplicable: True
			end
		end

	update is
			-- Redraw the menu
		do
			check
				Nothing_to_do: True
			end
		end

end -- class EV_POPUP_MENU_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
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
