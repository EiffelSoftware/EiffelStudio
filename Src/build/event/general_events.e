indexing
	description: "Page representing general events."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class GENERAL_EVENTS 

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
			Result := Pixmaps.general_pixmap
		end

--	set_focus_string is
--		do
--			button.set_focus_string (Focus_labels.general_label)
--		end

	fill_page is
		do
			extend (destroy_ev)
			extend (enter_notify_ev)
			extend (leave_notify_ev)
			extend (motion_notify_ev)
			extend (key_press_ev)
			extend (key_release_ev)
			extend (get_focus_ev)
			extend (lose_focus_ev)
		end

end -- class GENERAL_EVENTS   

