indexing
	description: "Page representing events that can %
				% be associated with items."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	ITEM_EVENTS

inherit
    EVENT_PAGE

creation
	make

feature -- Access

	update_content (ctxt: CONTEXT) is
		local
			menu_item_c: MENU_ITEM_C
			tbar_button_c: TOOL_BAR_BUTTON_C
			check_item_c: CHECK_MENU_ITEM_C
			tbar_toggle_c: TOOL_BAR_TOGGLE_BUTTON_C
			list_item_c: LIST_ITEM_C
			tree_item_c: TREE_ITEM_C
		do
			clear_items
			extend (select_ev)

			menu_item_c ?= ctxt
			tbar_button_c ?= ctxt
			if menu_item_c /= Void then
				check_item_c ?= ctxt
				if check_item_c /= Void then
					extend (unselect_ev)
				end
			elseif tbar_button_c /= Void then
				tbar_toggle_c ?= ctxt
				if tbar_toggle_c /= Void then
					extend (unselect_ev)
				end
			else
				extend (unselect_ev)
				list_item_c ?= ctxt
				if list_item_c /= Void then
					extend (double_click_ev)
				else
					tree_item_c ?= ctxt
					if tree_item_c /= Void then
						extend (subtree_ev)
					end
				end
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
		end

end -- class ITEM_EVENTS

