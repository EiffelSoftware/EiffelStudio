indexing
	description: "Page representing events that can %
				% be associated with a button."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class BUTTON_EVENTS

inherit
	EVENT_PAGE

creation
	make

feature -- Access

	update_content (ctxt: CONTEXT) is
		local
			toggle_b_c: TOGGLE_BUTTON_C
		do
			toggle_b_c ?= ctxt
			if toggle_b_c /= Void then
				if count = 1 then
					extend (toggle_ev)
				end
			elseif count > 1 then
				get_item (2).destroy
			end
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
			extend (click_ev)
		end

end -- class BUTTON_EVENTS

