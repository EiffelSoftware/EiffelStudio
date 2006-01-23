indexing
	description: "EiffelVision primitive, mswin implementation.%N%
			%This class would be the equivalent of a wel_control in%N%
			% the wel hierarchy."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			interface,
			destroy
		end

	EV_SIZEABLE_PRIMITIVE_IMP
		redefine
			interface
		end

	EV_TOOLTIPABLE_IMP
		redefine
			interface,
			tooltip_window,
			destroy
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
			l_null, hwnd: POINTER
			window: WEL_WINDOW
			l_top: like top_level_window_imp
		do
			l_top := top_level_window_imp
			if l_top /= Void then
				hwnd := next_dlgtabitem (l_top.wel_item, wel_item, direction)
			end
			if hwnd /= l_null then
				window := window_of_item (hwnd)
				if window /= Void then
					window.set_focus
				end
			end
		end

	arrow_action (direction: BOOLEAN) is
			-- Go to the next widget that takes the focus throughthe arrow
			-- keys. If `direction' it goes to the next widget otherwise,
			-- it goes to the previous one.
		local
			hwnd, l_null: POINTER
			window: WEL_WINDOW
			l_top: like top_level_window_imp
		do
			l_top := top_level_window_imp
			if l_top /= Void then
				hwnd := next_dlggroupitem (l_top.wel_item, wel_item, direction)
			end
			if hwnd /= l_null then
				window := window_of_item (hwnd)
				if window /= Void then
					window.set_focus
				end
			end
		end

	process_tab_key (virtual_key: INTEGER) is
			-- Process a tab or arrow key press to give the focus to the next
			-- widget. Need to be called in the feature on_key_down when the
			-- control needs to process this kind of keys.
		do
			if virtual_key = ({WEL_INPUT_CONSTANTS}.Vk_tab) and then 
				flag_set (style, {WEL_WINDOW_CONSTANTS}.Ws_tabstop)
			then
				tab_action (not key_down ({WEL_INPUT_CONSTANTS}.Vk_shift))
			end
		end

	process_tab_and_arrows_keys (virtual_key: INTEGER) is
			-- Process a tab or arrow key press to give the focus to the next
			-- widget. Need to be called in the feature on_key_down when the
			-- control need to process this kind of keys.
		do
			inspect
				virtual_key
			when {WEL_INPUT_CONSTANTS}.vk_tab then
				tab_action (not key_down ({WEL_INPUT_CONSTANTS}.vk_shift))
			when {WEL_INPUT_CONSTANTS}.vk_down, {WEL_INPUT_CONSTANTS}.vk_right then
				arrow_action (True)
			when {WEL_INPUT_CONSTANTS}.vk_up, {WEL_INPUT_CONSTANTS}.vk_left then
				arrow_action (False)
			else
				-- Do nothing
			end
		end

	on_getdlgcode is
			-- Called when window receives WM_GETDLGCODE message.
		do
			set_message_return_value (to_lresult ({WEL_DLGC_CONSTANTS}.dlgc_want_all_keys))
		end

	tooltip_window: WEL_WINDOW is
			-- `Result' is WEL_WINDOW of `Current' used
			-- to trigger tooltip events. May be redefined in
			-- descendents that are composed of more than one window
			-- such as combo boxes.
		do
			Result := window_of_item (wel_item)
		end

feature {EV_ANY_I} -- Implementation

	destroy is
			-- Destroy `Current'.
		do
			Precursor {EV_TOOLTIPABLE_IMP}
			Precursor {EV_WIDGET_IMP}
		end

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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_PRIMITIVE_IMP

