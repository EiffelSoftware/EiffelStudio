indexing
	description: "Implemented `IOleInPlaceFrame' Interface."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IOLE_IN_PLACE_FRAME_IMPL

inherit
	IOLE_IN_PLACE_FRAME_INTERFACE

	IOLE_IN_PLACE_UIWINDOW_IMPL

feature -- Basic Operations

	insert_menus (hmenu_shared: POINTER; lp_menu_widths: TAG_OLE_MENU_GROUP_WIDTHS_RECORD) is
			-- No description available.
			-- `hmenu_shared' [in].  
			-- `lp_menu_widths' [in, out].  
		do
			-- No Implementation.
		end

	set_menu (hmenu_shared: POINTER; holemenu: POINTER; hwnd_active_object: POINTER) is
			-- No description available.
			-- `hmenu_shared' [in].  
			-- `holemenu' [in].  
			-- `hwnd_active_object' [in].  
		do
			-- No Implementation.
		end

	remove_menus (hmenu_shared: POINTER) is
			-- No description available.
			-- `hmenu_shared' [in].  
		do
			-- No Implementation.
		end

	set_status_text (psz_status_text: STRING) is
			-- No description available.
			-- `psz_status_text' [in].  
		do
			-- No Implementation.
		end

	enable_modeless (f_enable: INTEGER) is
			-- No description available.
			-- `f_enable' [in].  
		do
			-- No Implementation.
		end

	translate_accelerator (lpmsg: TAG_MSG_RECORD; w_id: INTEGER) is
			-- No description available.
			-- `lpmsg' [in].  
			-- `w_id' [in].  
		do
			trigger (S_false)
		end


end -- IOLE_IN_PLACE_FRAME_IMPL

