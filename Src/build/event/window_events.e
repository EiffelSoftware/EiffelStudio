indexing
	description: "Page representing events that can %
				% be associated with a window."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	WINDOW_EVENTS

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
			Result := Pixmaps.button_pixmap
		end

--	set_focus_string is
--		do
--			button.set_focus_string (Focus_labels.button_label)
--		end

	fill_page is
		do
			extend (close_ev)
			extend (move_ev)
			extend (resize_ev)
		end

end -- class WINDOW_EVENTS

