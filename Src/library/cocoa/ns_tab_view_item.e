note
	description: "Summary description for {NS_TAB_VIEW_ITEM}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TAB_VIEW_ITEM

inherit
	NS_OBJECT

create
	new

feature

	new
		do
			cocoa_object := tab_view_item_new
		end

	init_with_identifier (a_identifier: NS_OBJECT): NS_OBJECT
		do
--			Result := tab_view_item_init_with_identifier(cocoa_object, a_identifier.cocoa_object)
		end

	identifier : NS_OBJECT
		do
--			Result := tab_view_item_identifier(cocoa_object)
		end

	view : NS_VIEW
		do
			Result := (create {NS_VIEW}.make_shared (tab_view_item_view(cocoa_object)))
		end

	initial_first_responder : NS_OBJECT
		do
--			Result := tab_view_item_initial_first_responder(cocoa_object)
		end

	label : NS_STRING
		do
--			Result := tab_view_item_label(cocoa_object)
		end

	color : NS_COLOR
		do
--			Result := tab_view_item_color(cocoa_object)
		end

	tab_state : INTEGER
		do
			Result := tab_view_item_tab_state(cocoa_object)
		end

	tab_view : NS_TAB_VIEW
		do
--			Result := tab_view_item_tab_view(cocoa_object)
		end

	set_identifier (a_identifier: NS_OBJECT)
		do
			tab_view_item_set_identifier(cocoa_object, a_identifier.cocoa_object)
		end

	set_label (a_label: STRING_GENERAL)
		do
			tab_view_item_set_label (cocoa_object, (create {NS_STRING}.make_with_string (a_label)).cocoa_object)
		end

	set_color (a_color: NS_COLOR)
		do
			tab_view_item_set_color(cocoa_object, a_color.cocoa_object)
		end

	set_view (a_view: NS_VIEW)
		do
			tab_view_item_set_view(cocoa_object, a_view.cocoa_object)
		end

	set_initial_first_responder (a_view: NS_VIEW)
		do
			tab_view_item_set_initial_first_responder(cocoa_object, a_view.cocoa_object)
		end

--	draw_label_in_rect (a_should_truncate_label: BOOLEAN; a_label_rect: NS_RECT)
--		do
--			tab_view_item_draw_label_in_rect(cocoa_object, a_should_truncate_label, a_label_rect.cocoa_object)
--		end

--	size_of_label (a_compute_min: BOOLEAN): NS_SIZE
--		do
--			Result := tab_view_item_size_of_label(cocoa_object, a_compute_min)
--		end

feature {NONE} -- Objective-C implementation

	frozen tab_view_item_new: POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSTabViewItem new];"
		end

	frozen tab_view_item_init_with_identifier (a_tab_view_item: POINTER; a_identifier: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSTabViewItem*)$a_tab_view_item initWithIdentifier: $a_identifier];"
		end

	frozen tab_view_item_identifier (a_tab_view_item: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSTabViewItem*)$a_tab_view_item identifier];"
		end

	frozen tab_view_item_view (a_tab_view_item: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSTabViewItem*)$a_tab_view_item view];"
		end

	frozen tab_view_item_initial_first_responder (a_tab_view_item: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSTabViewItem*)$a_tab_view_item initialFirstResponder];"
		end

	frozen tab_view_item_label (a_tab_view_item: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSTabViewItem*)$a_tab_view_item label];"
		end

	frozen tab_view_item_color (a_tab_view_item: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSTabViewItem*)$a_tab_view_item color];"
		end

	frozen tab_view_item_tab_state (a_tab_view_item: POINTER): INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSTabViewItem*)$a_tab_view_item tabState];"
		end

	frozen tab_view_item_tab_view (a_tab_view_item: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSTabViewItem*)$a_tab_view_item tabView];"
		end

	frozen tab_view_item_set_identifier (a_tab_view_item: POINTER; a_identifier: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSTabViewItem*)$a_tab_view_item setIdentifier: $a_identifier];"
		end

	frozen tab_view_item_set_label (a_tab_view_item: POINTER; a_label: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSTabViewItem*)$a_tab_view_item setLabel: $a_label];"
		end

	frozen tab_view_item_set_color (a_tab_view_item: POINTER; a_color: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSTabViewItem*)$a_tab_view_item setColor: $a_color];"
		end

	frozen tab_view_item_set_view (a_tab_view_item: POINTER; a_view: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSTabViewItem*)$a_tab_view_item setView: $a_view];"
		end

	frozen tab_view_item_set_initial_first_responder (a_tab_view_item: POINTER; a_view: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSTabViewItem*)$a_tab_view_item setInitialFirstResponder: $a_view];"
		end

--	frozen tab_view_item_draw_label_in_rect (a_tab_view_item: POINTER; a_should_truncate_label: BOOLEAN; a_label_rect: POINTER)
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"[(NSTabViewItem*)$a_tab_view_item drawLabel: $a_should_truncate_label inRect: $a_label_rect];"
--		end

--	frozen tab_view_item_size_of_label (a_tab_view_item: POINTER; a_compute_min: BOOLEAN): POINTER
--		external
--			"C inline use <Cocoa/Cocoa.h>"
--		alias
--			"return [(NSTabViewItem*)$a_tab_view_item sizeOfLabel: $a_compute_min];"
--		end

end
