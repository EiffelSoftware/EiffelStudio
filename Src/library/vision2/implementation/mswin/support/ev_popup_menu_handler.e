indexing
	description:
		"Eiffel Vision popup menu handler. Invisible window that lets%N%
		%`menu_item_list' receive click commands."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_POPUP_MENU_HANDLER

inherit
	WEL_FRAME_WINDOW
		undefine
			on_draw_item
		redefine
			on_menu_command,
			default_process_message,
			class_requires_icon
		end

	EV_MENU_CONTAINER_IMP
		export
			{NONE} all
		end

create
	make_with_menu

feature {NONE} -- Initialization

	make_with_menu (a_menu: EV_MENU_ITEM_LIST_IMP) is
			-- Initialize with `a_menu'.
		require
			a_menu_not_void: a_menu /= Void
		do
			make_top ("EV_POPUP_MENU_HANDLER")
			menu_item_list := a_menu
			set_menu (menu_item_list)
		end

feature {NONE} -- Implementation

	menu_item_list: EV_MENU_ITEM_LIST_IMP
			-- Connected menu.

	on_menu_command (an_id: INTEGER) is
			-- Propagate to `menu'.
		do
			menu_item_list.menu_item_clicked (an_id)
		end

	default_process_message (msg: INTEGER; wparam, lparam: POINTER) is
			-- Process `msg' which has not been processed by
			-- `process_message'.
		do
			if not process_menu_message(msg, wparam, lparam) then
				Precursor (msg, wparam, lparam)
			end
		end

feature {NONE} -- WEL Implementation

	on_menu_char (char_code: CHARACTER; corresponding_menu: WEL_MENU) is
			-- The menu char `char_code' has been typed within `corresponding_menu'.
		do
			set_message_return_value (
				menu_item_list.on_menu_char (char_code, corresponding_menu))
		end

	class_requires_icon: BOOLEAN is
			-- Does `Current' require an icon to be registered?
			-- If `True' `register_class' assigns a class icon, otherwise
			-- no icon is assigned.
		do
			Result := False
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




end -- class EV_POPUP_MENU_HANDLER

