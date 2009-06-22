note
	description: "Wrapper for NSTabViewItem."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TAB_VIEW_ITEM

inherit
	NS_OBJECT

	NS_TAB_VIEW_ITEM_API
		undefine
			copy
		end

create
	make

feature {NONE} -- Creation

	make
		do
			make_from_pointer (tab_view_item_new)
		end

	init_with_identifier (a_identifier: NS_OBJECT): NS_OBJECT
		do
			create Result.make_from_pointer (tab_view_item_init_with_identifier (item, a_identifier.item))
		end

feature

	identifier: NS_OBJECT
		do
			create Result.share_from_pointer (tab_view_item_identifier (item))
		end

	view: NS_VIEW
		do
			Result := (create {NS_VIEW}.share_from_pointer (tab_view_item_view (item)))
		end

	initial_first_responder: NS_OBJECT
		do
			create Result.share_from_pointer (tab_view_item_initial_first_responder (item))
		end

	label: NS_STRING
		do
			create Result.share_from_pointer (tab_view_item_label (item))
		end

	color: NS_COLOR
		do
			create Result.share_from_pointer (tab_view_item_color (item))
		end

	tab_state: INTEGER
		do
			Result := tab_view_item_tab_state (item)
		end

	tab_view: NS_TAB_VIEW
		do
			create Result.share_from_pointer ( tab_view_item_tab_view (item))
		end

	set_identifier (a_identifier: NS_OBJECT)
		do
			tab_view_item_set_identifier(item, a_identifier.item)
		end

	set_label (a_label: STRING_GENERAL)
		do
			tab_view_item_set_label (item, (create {NS_STRING}.make_with_string (a_label)).item)
		end

	set_color (a_color: NS_COLOR)
		do
			tab_view_item_set_color(item, a_color.item)
		end

	set_view (a_view: NS_VIEW)
		do
			tab_view_item_set_view(item, a_view.item)
		end

	set_initial_first_responder (a_view: NS_VIEW)
		do
			tab_view_item_set_initial_first_responder(item, a_view.item)
		end

--	draw_label_in_rect (a_should_truncate_label: BOOLEAN; a_label_rect: NS_RECT)
--		do
--			tab_view_item_draw_label_in_rect(cocoa_object, a_should_truncate_label, a_label_rect.cocoa_object)
--		end

--	size_of_label (a_compute_min: BOOLEAN): NS_SIZE
--		do
--			Result := tab_view_item_size_of_label(cocoa_object, a_compute_min)
--		end

end
