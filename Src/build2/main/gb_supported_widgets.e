indexing
	description: "Objects that provide information about the currently%
		%supported vision2 classes."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_SUPPORTED_WIDGETS

feature -- Access

	containers: ARRAY [STRING] is
		once
				--| FIXME, I have removed EV_TABLE and EV_VIEWPORT for
				--| the first release. These need specific handling, due to their behaviour.
				--| Julian 11/12/01.
			Result := <<"EV_CELL", "EV_FIXED", "EV_FRAME", "EV_HORIZONTAL_SPLIT_AREA",
				"EV_HORIZONTAL_BOX", "EV_NOTEBOOK", "EV_SCROLLABLE_AREA", "EV_VERTICAL_BOX",
				"EV_VERTICAL_SPLIT_AREA">>
		end
				
	primitives: ARRAY [STRING] is 
		once
			Result := <<"EV_BUTTON", "EV_CHECK_BUTTON", "EV_COMBO_BOX",
				"EV_HORIZONTAL_PROGRESS_BAR", "EV_HORIZONTAL_RANGE",
				"EV_HORIZONTAL_SEPARATOR", "EV_LABEL", "EV_LIST", "EV_MULTI_COLUMN_LIST", "EV_OPTION_BUTTON",
				"EV_PASSWORD_FIELD", "EV_PIXMAP", "EV_RADIO_BUTTON", "EV_SPIN_BUTTON",
				"EV_TEXT", "EV_TEXT_FIELD", "EV_TOGGLE_BUTTON", "EV_TOOL_BAR", "EV_TREE", "EV_VERTICAL_PROGRESS_BAR",
				"EV_VERTICAL_RANGE", "EV_VERTICAL_SEPARATOR", "EV_DRAWING_AREA", "EV_VERTICAL_SCROLL_BAR",
				"EV_HORIZONTAL_SCROLL_BAR">>
		end
		
	items: ARRAY [STRING] is
		once
			Result := <<"EV_LIST_ITEM", "EV_MENU_BAR", "EV_MENU", "EV_MENU_ITEM", "EV_TREE_ITEM">>
		end
		
	tool_bar_items: ARRAY [STRING] is
		once
			Result := <<"EV_TOOL_BAR_BUTTON", "EV_TOOL_BAR_TOGGLE_BUTTON", "EV_TOOL_BAR_RADIO_BUTTON", "EV_TOOL_BAR_SEPARATOR">>
		end
		
		

feature {NONE} -- Implementation
		
	include_all_components is
			-- We must include all the vision2 components that are currently
			-- supported, otherwise the dynamic creation will fail.
			-- This feature never needs to be called, but the components are
			-- declared as local to further hide them. The compiler can find them
			-- here.
			-- We must also include all GB_EV_* classes, as they will be created dynamically.
		local
			cell: EV_CELL
			fixed: EV_FIXED
			frame: EV_FRAME
			horizontal_split_area: EV_HORIZONTAL_SPLIT_AREA
			horizontal_box: EV_HORIZONTAL_BOX
			notebook: EV_NOTEBOOK
			scrollable_area: EV_SCROLLABLE_AREA
			table: EV_TABLE
			vertical_box: EV_VERTICAL_BOX
			vertical_split_area: EV_VERTICAL_SPLIT_AREA
			viewport: EV_VIEWPORT
		
			button: EV_BUTTON
			check_button: EV_CHECK_BUTTON
			combo_box: EV_COMBO_BOX
			horizontal_progress_bar: EV_HORIZONTAL_PROGRESS_BAR
			horizontal_range: EV_HORIZONTAL_RANGE
			horizontal_separator: EV_HORIZONTAL_SEPARATOR
			label: EV_LABEL
			list: EV_LIST
			multi_column_list: EV_MULTI_COLUMN_LIST
			password_field: EV_PASSWORD_FIELD
			pixmap: EV_PIXMAP
			radio_button: EV_RADIO_BUTTON
			spin_button: EV_SPIN_BUTTON
			text: EV_TEXT
			text_field: EV_TEXT_FIELD
			toggle_button: EV_TOGGLE_BUTTON
			tool_bar: EV_TOOL_BAR
			tree: EV_TREE
			vertical_progress_bar: EV_VERTICAL_PROGRESS_BAR
			vertical_range: EV_VERTICAL_RANGE
			vertical_separator: EV_VERTICAL_SEPARATOR
			drawing_area: EV_DRAWING_AREA
			vertical_scroll_bar: EV_VERTICAL_SCROLL_BAR
			horizontal_scroll_bar: EV_HORIZONTAL_SCROLL_BAR
			tool_bar_button: EV_TOOL_BAR_BUTTON
			tool_bar_toggle_button: EV_TOOL_BAR_TOGGLE_BUTTON
			tool_bar_radio_button: EV_TOOL_BAR_RADIO_BUTTON
			tool_bar_separator: EV_TOOL_BAR_SEPARATOR
			list_item: EV_LIST_ITEM
			
			gb_ev_sensitive: GB_EV_SENSITIVE
			gb_ev_tooltipable: GB_EV_TOOLTIPABLE
			gb_ev_window: GB_EV_WINDOW
			gb_ev_frame: GB_EV_FRAME
			gb_ev_box: GB_EV_BOX
			gb_ev_textable: GB_EV_TEXTABLE
			gb_ev_text_alignable: GB_EV_TEXT_ALIGNABLE
			gb_ev_deselectable: GB_EV_DESELECTABLE
			gb_ev_colorizable: GB_EV_COLORIZABLE
			gb_ev_widget: GB_EV_WIDGET
			gb_ev_gauge: GB_EV_GAUGE
			gb_ev_notebook: GB_EV_NOTEBOOK
			gb_ev_text_component: GB_EV_TEXT_COMPONENT
		do
		end

invariant
	containers_not_void: containers /= Void
	primitives_not_void: primitives /= Void
	items_not_void: items /= Void

end -- class GB_SUPPORTED_WIDGETS
