note
	description: "Summary description for {NS_TAB_VIEW_ITEM_API}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TAB_VIEW_ITEM_API

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
