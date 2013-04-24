note
	description: "Summary description for {NS_TAB_VIEW_ITEM_API}."
	author: "Daniel Furrer"
	date: "$Date$"
	revision: "$Revision$"

class
	NS_TAB_VIEW_ITEM_API

feature

	frozen new: POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [NSTabViewItem new];"
		end

	frozen init_with_identifier (a_tab_view_item: POINTER; a_identifier: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSTabViewItem*)$a_tab_view_item initWithIdentifier: $a_identifier];"
		end

	frozen identifier (a_tab_view_item: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSTabViewItem*)$a_tab_view_item identifier];"
		end

	frozen view (a_tab_view_item: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSTabViewItem*)$a_tab_view_item view];"
		end

	frozen initial_first_responder (a_tab_view_item: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSTabViewItem*)$a_tab_view_item initialFirstResponder];"
		end

	frozen label (a_tab_view_item: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSTabViewItem*)$a_tab_view_item label];"
		end

	frozen color (a_tab_view_item: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSTabViewItem*)$a_tab_view_item color];"
		end

	frozen tab_state (a_tab_view_item: POINTER): INTEGER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSTabViewItem*)$a_tab_view_item tabState];"
		end

	frozen tab_view (a_tab_view_item: POINTER): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"return [(NSTabViewItem*)$a_tab_view_item tabView];"
		end

	frozen set_identifier (a_tab_view_item: POINTER; a_identifier: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSTabViewItem*)$a_tab_view_item setIdentifier: $a_identifier];"
		end

	frozen set_label (a_tab_view_item: POINTER; a_label: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSTabViewItem*)$a_tab_view_item setLabel: $a_label];"
		end

	frozen set_color (a_tab_view_item: POINTER; a_color: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSTabViewItem*)$a_tab_view_item setColor: $a_color];"
		end

	frozen set_view (a_tab_view_item: POINTER; a_view: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSTabViewItem*)$a_tab_view_item setView: $a_view];"
		end

	frozen set_initial_first_responder (a_tab_view_item: POINTER; a_view: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSTabViewItem*)$a_tab_view_item setInitialFirstResponder: $a_view];"
		end

	frozen draw_label_in_rect (a_tab_view_item: POINTER; a_should_truncate_label: BOOLEAN; a_label_rect: POINTER)
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[(NSTabViewItem*)$a_tab_view_item drawLabel: $a_should_truncate_label inRect: *(NSRect*)$a_label_rect];"
		end

	frozen size_of_label (a_tab_view_item: POINTER; a_compute_min: BOOLEAN): POINTER
		external
			"C inline use <Cocoa/Cocoa.h>"
		alias
			"[
				NSSize size = [(NSTabViewItem*)$a_tab_view_item sizeOfLabel: $a_compute_min];
				NSSize *res = malloc(sizeof(NSSize));
				memcpy (res, &size, sizeof(NSSize));
				return res;
			]"
		end

end
