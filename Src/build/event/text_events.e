indexing
	description: "Page representing events that can %
				% be associated with a text component."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class TEXT_EVENTS

inherit
	EVENT_PAGE

creation
	make

feature -- Access

	update_content (ctxt: CONTEXT) is
		local
			text_f_c: TEXT_FIELD_C
		do
			text_f_c ?= ctxt
			if text_f_c /= Void then
				if rows = 1 then
					extend (return_ev)
				end
			elseif rows > 1 then
				get_item (2).destroy
			end
		end

feature {NONE} -- Implementation

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.text_pixmap
		end

--	set_focus_string is
--		do
--			button.set_focus_string (Focus_labels.text_label)
--		end

	fill_page is
		do
			extend (change_ev)
		end

end -- class TEXT_EVENTS

