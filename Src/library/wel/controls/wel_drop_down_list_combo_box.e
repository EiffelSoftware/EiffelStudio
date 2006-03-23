indexing
	description: "A combo box which has a drop down list box."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	WEL_DROP_DOWN_LIST_COMBO_BOX

inherit
	WEL_COMBO_BOX
		redefine
			height
		end

create
	make,
	make_by_id

feature -- Access

	height: INTEGER is
			-- Height including the list box
		do
			Result := dropped_rect.height
		end

feature -- Status setting

	show_list is
			-- Show the drop down list
		require
			exists: exists
		do
			cwin_send_message (item, Cb_showdropdown, to_wparam (1), to_lparam (0))
		ensure
			list_shown: list_shown
		end

	hide_list is
			-- Hide the drop down list
		require
			exists: exists
		do
			cwin_send_message (item, Cb_showdropdown, to_wparam (0), to_lparam (0))
		ensure
			list_not_shown: not list_shown
		end

feature -- Status report

	list_shown: BOOLEAN is
			-- Is the drop down list shown?
		require
			exists: exists
		do
			Result := cwin_send_message_result (item,
				Cb_getdroppedstate, to_wparam (0), to_lparam (0)) /= default_pointer
		end

feature -- Obsolete

	show_drop_down is obsolete "Use ``show_list''"
		require
			exists: exists
		do
			show_list
		ensure
			list_shown: list_shown
		end

	hide_drop_down is obsolete "Use ``hide_list''"
		require
			exists: exists
		do
			hide_list
		ensure
			list_not_shown: not list_shown
		end

	dropped_down: BOOLEAN is obsolete "Use ``list_shown''"
		require
			exists: exists
		do
			Result := list_shown
		end

feature {NONE} -- Implementation

	default_style: INTEGER is
			-- Default style used to create the control
		once
			Result := Ws_visible + Ws_child + Ws_group +
				Ws_tabstop + Ws_vscroll + Cbs_dropdownlist +
				Cbs_autohscroll
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




end -- class WEL_DROP_DOWN_LIST_COMBO_BOX

