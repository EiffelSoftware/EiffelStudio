indexing
	description: "EiffelVision primitive, mswin implementation.%N%
			%This class would be the equivalent of a wel_control in%N%
			% the wel hierarchy."
	status: "See notice at end of class,"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_PRIMITIVE_IMP
	
inherit
	EV_PRIMITIVE_I
		redefine
			interface
		end

	EV_WIDGET_IMP
		redefine
			update_for_pick_and_drop,
			interface
		end

	EV_SIZEABLE_PRIMITIVE_IMP
		redefine
			interface
		end

	EV_TOOLTIPABLE_IMP
		redefine
			interface,
			tooltip_window
		end

feature -- Access

	top_level_window_imp: EV_WINDOW_IMP
			-- Top level window that contains `Current'.

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
				par_imp ?= par.implementation
				ww ?= par.implementation
				wel_set_parent (ww)
				check
					valid_cast: par_imp /= Void
				end
				set_top_level_window_imp (par_imp.top_level_window_imp)
			elseif parent_imp /= Void then
				wel_set_parent (default_parent)
			end
		end
	
	set_top_level_window_imp (a_window: EV_WINDOW_IMP) is
			-- Make `a_window' the new `top_level_window_imp'
			-- of `Current'.
		do
			top_level_window_imp := a_window
		end

feature -- Basic operations

	tab_action (direction: BOOLEAN) is
			-- Go to the next widget that takes the focus through to the tab
			-- key. If `direction' it goes to the next widget otherwise,
			-- it goes to the previous one.
		local
			hwnd: POINTER
			window: WEL_WINDOW
		do
			hwnd := next_dlgtabitem (top_level_window_imp.wel_item,
			wel_item, direction)
			window := window_of_item (hwnd)
			if window /= Void then
				window.set_focus
			end
		end

	arrow_action (direction: BOOLEAN) is
			-- Go to the next widget that takes the focus throughthe arrow
			-- keys. If `direction' it goes to the next widget otherwise,
			-- it goes to the previous one.
		local
			hwnd: POINTER
			window: EV_WIDGET_IMP
		do
			hwnd := next_dlggroupitem (top_level_window_imp.wel_item,
			wel_item, direction)
			window ?= window_of_item (hwnd)
			check
				valid_cast: window /= Void
			end
			if parent_imp = window.parent_imp then
				-- The next widget must have the same parent as the
				-- widget which currently has the focus.
				window.set_focus
			end
		end

	process_tab_key (virtual_key: INTEGER) is
			-- Process a tab or arrow key press to give the focus to the next
			-- widget. Need to be called in the feature on_key_down when the
			-- control needs to process this kind of keys.
		do
			if virtual_key = Wel_input_constants.Vk_tab and then 
				flag_set (style, Wel_window_constants.Ws_tabstop)
			then
				tab_action (not key_down (Wel_input_constants.Vk_shift))
			end
		end

	process_tab_and_arrows_keys (virtual_key: INTEGER) is
			-- Process a tab or arrow key press to give the focus to the next
			-- widget. Need to be called in the feature on_key_down when the
			-- control need to process this kind of keys.
		do
			if virtual_key = Wel_input_constants.Vk_tab then
				tab_action (not key_down (Wel_input_constants.Vk_shift))
			elseif virtual_key = Wel_input_constants.Vk_down then
				arrow_action (True)
			elseif virtual_key = Wel_input_constants.Vk_up then
				arrow_action (False)
			end
		end

	tooltip_window: WEL_WINDOW is
			-- `Result' is WEL_WINDOW of `Current'.
		do
			Result := window_of_item (wel_item)
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

feature {EV_ANY_I} -- Implementation

	update_for_pick_and_drop (starting: BOOLEAN) is
			-- Pick and drop status has changed so update appearence of
			-- `Current'.
		do
			--| Redefine this for each primitive that changes its appearence
		end
		
	interface: EV_PRIMITIVE

	is_control_in_window (hwnd_control: POINTER): BOOLEAN is
			-- Is the control of handle `hwnd_control'
			-- located inside the current window?
		do
			Result := (hwnd_control = wel_item)
		end

end -- class EV_PRIMITIVE_IMP

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

