indexing
	description: "Page representing mouse events."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class MOUSE_EVENTS

inherit
	EVENT_PAGE

creation
	make

feature -- Access

	update_content (ctxt: CONTEXT) is
		do
		end

feature {NONE} -- Implementation

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.mouse_pixmap
		end

--	set_focus_string is
--		do
--			button.set_focus_string (Focus_labels.mouse_label)
--		end

	fill_page is
		do
			extend (mouse1_press_ev)
			extend (mouse2_press_ev)
			extend (mouse3_press_ev)
			extend (mouse1_release_ev)
			extend (mouse2_release_ev)
			extend (mouse3_release_ev)
			extend (mouse1_motion_ev)
			extend (mouse2_motion_ev)
			extend (mouse3_motion_ev)
			extend (mouse1_dbl_click_ev)
			extend (mouse2_dbl_click_ev)
			extend (mouse3_dbl_click_ev)
		end

end -- class MOUSE_EVENTS

