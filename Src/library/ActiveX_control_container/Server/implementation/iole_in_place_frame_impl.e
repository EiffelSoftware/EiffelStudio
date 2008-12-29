note
	description: "Implemented `IOleInPlaceFrame' Interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IOLE_IN_PLACE_FRAME_IMPL

inherit
	IOLE_IN_PLACE_FRAME_INTERFACE

	IOLE_IN_PLACE_UIWINDOW_IMPL

feature -- Basic Operations

	insert_menus (hmenu_shared: POINTER; lp_menu_widths: TAG_OLE_MENU_GROUP_WIDTHS_RECORD)
			-- No description available.
			-- `hmenu_shared' [in].  
			-- `lp_menu_widths' [in, out].  
		do
			-- No Implementation.
		end

	set_menu (hmenu_shared: POINTER; holemenu: POINTER; hwnd_active_object: POINTER)
			-- No description available.
			-- `hmenu_shared' [in].  
			-- `holemenu' [in].  
			-- `hwnd_active_object' [in].  
		do
			-- No Implementation.
		end

	remove_menus (hmenu_shared: POINTER)
			-- No description available.
			-- `hmenu_shared' [in].  
		do
			-- No Implementation.
		end

	set_status_text (psz_status_text: STRING)
			-- No description available.
			-- `psz_status_text' [in].  
		do
			-- No Implementation.
		end

	enable_modeless (f_enable: INTEGER)
			-- No description available.
			-- `f_enable' [in].  
		do
			-- No Implementation.
		end

	translate_accelerator (lpmsg: TAG_MSG_RECORD; w_id: INTEGER)
			-- No description available.
			-- `lpmsg' [in].  
			-- `w_id' [in].  
		do
			trigger (S_false)
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




end -- IOLE_IN_PLACE_FRAME_IMPL

