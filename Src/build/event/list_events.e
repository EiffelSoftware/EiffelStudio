indexing
	description: "Page representing events that can %
				% be associated with a list."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class LIST_EVENTS 

inherit
    EVENT_PAGE

creation
	make

feature -- Access

	update_content (ctxt: CONTEXT) is
		local
			mc_list_c: MULTI_COLUMN_LIST_C
		do
			mc_list_c ?= ctxt
			if mc_list_c /= Void then
				if count = 1 then
					extend (column_click_ev)
				end
			elseif count > 1 then
				get_item (2).destroy
			end
		end

feature {NONE} -- Implementation

	symbol: EV_PIXMAP is
		do
			Result := Pixmaps.list_pixmap
		end

--	set_focus_string is
--		do
--			button.set_focus_string (Focus_labels.list_label)
--		end

	fill_page is
		do
			extend (selection_ev)
		end

end -- class LIST_EVENTS

