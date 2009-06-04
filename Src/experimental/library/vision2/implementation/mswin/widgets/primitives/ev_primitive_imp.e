note
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
			destroy,
			is_tabable_from
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

	top_level_window_imp: detachable EV_WINDOW_IMP
			-- Top level window that contains `Current'.

feature -- Element change

	set_parent_imp (par_imp: detachable EV_CONTAINER_IMP)
			-- Make `par' the new parent of the widget.
			-- `par' can be Void then the parent is the
			-- default_parent.
		local
			ww: detachable WEL_WINDOW
		do
			if par_imp /= Void then
				ww ?= par_imp
				check ww /= Void end
				wel_set_parent (ww)
				set_top_level_window_imp (par_imp.top_level_window_imp)
			elseif parent_imp /= Void then
				wel_set_parent (default_parent)
			end
		end

	set_top_level_window_imp (a_window: detachable EV_WINDOW_IMP)
			-- Make `a_window' the new `top_level_window_imp'
			-- of `Current'.
		do
			top_level_window_imp := a_window
		end

feature -- Basic operations

	on_getdlgcode
			-- Called when window receives WM_GETDLGCODE message.
		do
			set_message_return_value (to_lresult ({WEL_DLGC_CONSTANTS}.dlgc_want_all_keys))
		end

	tooltip_window: detachable WEL_WINDOW
			-- `Result' is WEL_WINDOW of `Current' used
			-- to trigger tooltip events. May be redefined in
			-- descendents that are composed of more than one window
			-- such as combo boxes.
		do
			Result := window_of_item (wel_item)
		end

feature -- Navigation

	is_tabable_to: BOOLEAN
			-- May `Current' be tabbed to?
		do
			Result := flag_set (style, {WEL_WS_CONSTANTS}.ws_tabstop)
		end

	is_tabable_from: BOOLEAN
			-- May `Current' be tabbed from?
		do
			Result := not not_is_tabable_from
		end

 	enable_tabable_to
 			-- Ensure `is_tabable_to' is `True'.
 		do
		 	set_style (style | {WEL_WS_CONSTANTS}.ws_tabstop | {WEL_WS_CONSTANTS}.ws_group)
		end

	disable_tabable_to
			-- Ensure `is_tabable_to' is `False'.
		local
			l_style: INTEGER
		do
			l_style := style
			l_style := clear_flag (l_style, {WEL_WS_CONSTANTS}.ws_tabstop)
			l_style := clear_flag (l_style, {WEL_WS_CONSTANTS}.ws_group)
			set_style (l_style)
		end

	enable_tabable_from
 			-- Ensure `is_tabable_from' is `True'.
 		do
 			not_is_tabable_from := False
		end

	disable_tabable_from
			-- Ensure `is_tabable_from' is `False'.
		do
			not_is_tabable_from := True
		end

feature {EV_ANY_I} -- Implementation

	not_is_tabable_from: BOOLEAN
			-- Storage for `is_tabable_from' in negative value because the
			-- default for `is_tabable_from' is True and we do not want to
			-- set this to all descendants of EV_PRIMITIVE_IMP.

	destroy
			-- Destroy `Current'.
		do
			Precursor {EV_WIDGET_IMP}
		end

	update_for_pick_and_drop (starting: BOOLEAN)
			-- Pick and drop status has changed so update appearence of
			-- `Current'.
		do
			--| Redefine this for each primitive that changes its appearence
		end

	interface: detachable EV_PRIMITIVE note option: stable attribute end

	is_control_in_window (hwnd_control: POINTER): BOOLEAN
			-- Is the control of handle `hwnd_control'
			-- located inside the current window?
		do
			Result := (hwnd_control = wel_item)
		end

note
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











