indexing
	description: 
		"EiffelVision primitive, mswin implementation."
	note: "This class would be the equivalent of a wel_control in%
			% the wel hierarchy."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_PRIMITIVE_IMP
	
inherit
	EV_PRIMITIVE_I

	EV_WIDGET_IMP
		redefine
			on_key_down
		end

feature -- Access

	top_level_window_imp: EV_UNTITLED_WINDOW_IMP
			-- Top level window that contains the current widget.

feature -- Element change

	set_parent (par: EV_CONTAINER) is
			-- Make `par' the new parent of the widget.
			-- `par' can be Void then the parent is the
			-- default_parent.
		local
			par_imp: EV_CONTAINER_IMP
			ww: WEL_WINDOW
		do
			if par /= Void then
				if parent_imp /= Void then
					parent_imp.remove_child (Current)
				end
				ww ?= par.implementation
				wel_set_parent (ww)
				par_imp ?= par.implementation
				check
					valid_cast: par_imp /= Void
				end
				set_top_level_window_imp (par_imp.top_level_window_imp)
				par_imp.add_child (Current)
			elseif parent_imp /= Void then
				parent_imp.remove_child (Current)
				wel_set_parent (default_parent)
			end
		end

	set_top_level_window_imp (a_window: EV_UNTITLED_WINDOW_IMP) is
			-- Make `a_window' the new `top_level_window_imp'
			-- of the widget.
		do
			top_level_window_imp := a_window
		end

feature -- Basic operations

	tab_action (direction: BOOLEAN) is
			-- Go to the next widget that takes the focus through to the tab key.
			-- If `direction' it goes to the next widget otherwise, it goes to the 
			-- previous one.
		local
			hwnd: POINTER
			window: WEL_WINDOW
		do
			hwnd := next_dlgtabitem (top_level_window_imp.item, item, direction)
			window := windows.item (hwnd)
			window.set_focus
		end

	arrow_action (direction: BOOLEAN) is
			-- Go to the next widget that takes the focus through the arrow keys.
			-- If `direction' it goes to the next widget otherwise, it goes to the 
			-- previous one.
		local
			hwnd: POINTER
			window: WEL_WINDOW
		do
			hwnd := next_dlggroupitem (top_level_window_imp.item, item, direction)
			window := windows.item (hwnd)
			window.set_focus
		end

feature {NONE} -- WEL Implementation

	on_key_down (virtual_key, key_data: INTEGER) is
			-- Use the tab key to jump from one control
			-- to another. Use also the arrows.
		local
			hwnd: POINTER
			window: WEL_WINDOW
		do
			{EV_WIDGET_IMP} Precursor (virtual_key, key_data)
			if virtual_key = Vk_tab then
				tab_action (True)
--				hwnd := next_dlgtabitem (top_level_window_imp.item, item, True)
--				window := windows.item (hwnd)
--				window.set_focus
			elseif virtual_key = Vk_down then
				arrow_action (True)
--				hwnd := next_dlggroupitem (top_level_window_imp.item, item, True)
--				window := windows.item (hwnd)
--				window.set_focus
			elseif virtual_key = Vk_up then
				arrow_action (False)
--				hwnd := next_dlggroupitem (top_level_window_imp.item, item, False)
--				window := windows.item (hwnd)
--				window.set_focus
			end
		end

feature {NONE} -- Deferred features

	item: POINTER is
		deferred
		end

	windows: HASH_TABLE [WEL_WINDOW, POINTER] is
		deferred
		end

feature {NONE} -- Feature that should be directly implemented by externals

	next_dlgtabitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- Encapsulation of the SDK GetNextDlgTabItem,
			-- because we cannot do a deferred feature become an
			-- external feature.
		deferred
		end

	next_dlggroupitem (hdlg, hctl: POINTER; previous: BOOLEAN): POINTER is
			-- Encapsulation of the SDK GetNextDlgGroupItem,
			-- because we cannot do a deferred feature become an
			-- external feature.
		deferred
		end

end -- class EV_PRIMITIVE_IMP

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
