indexing
	description: "Page representing events that can %
				% be associated with a drawing."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class DRAWING_EVENTS

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
			Result := Pixmaps.drawing_area_pixmap
		end

--	set_focus_string is
--		do
--			button.set_focus_string (Focus_labels.drawing_label)
--		end

	fill_page is
		do
			extend (paint_ev)
			extend (resize_ev)
		end

end -- class TEXT_EVENTS   

