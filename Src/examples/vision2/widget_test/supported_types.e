indexing
	description: "Objects that provide information concerning all%
		%types to be used in examples."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SUPPORTED_TYPES
	
inherit
	INTERNAL
	
feature -- Basic operation
		
	supported_types: ARRAYED_LIST [STRING] is
			-- All Vision2 types supported by the system.
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
			grid: EV_GRID
			header: EV_HEADER
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
			checkable_list: EV_CHECKABLE_LIST
			checkable_tree: EV_CHECKABLE_TREE
			
			gb_ev_sensitive: GB_EV_SENSITIVE
			gb_ev_tooltipable: GB_EV_TOOLTIPABLE
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
			gb_ev_pixmapable: GB_EV_PIXMAPABLE
			gb_ev_fixed: GB_EV_FIXED
			gb_ev_viewport: GB_EV_VIEWPORT
			gb_ev_table: GB_EV_TABLE
--			gb_ev_container: GB_EV_CONTAINER
			gb_ev_fontable: GB_EV_FONTABLE
			gb_ev_pixmap: GB_EV_PIXMAP
		once
			create Result.make (0)
			Result.extend ("gb_ev_colorizable")
			Result.extend ("gb_ev_fontable")
			Result.extend ("gb_ev_deselectable")
			Result.extend ("gb_ev_sensitive")
			Result.extend ("gb_ev_textable")
			Result.extend ("gb_ev_tooltipable")
			Result.extend ("gb_ev_widget")
			Result.extend ("gb_ev_box")
			Result.extend ("gb_ev_frame")
			Result.extend ("gb_ev_notebook")
			Result.extend ("gb_ev_gauge")
			Result.extend ("gb_ev_text_component")
			Result.extend ("gb_ev_text_alignable")
			Result.extend ("gb_ev_pixmapable")
			Result.extend ("gb_ev_fixed")
			Result.extend ("gb_ev_viewport")
			Result.extend ("gb_ev_table")
--			Result.extend ("gb_ev_container")
			Result.extend ("gb_ev_pixmap")
		end
		
	extendible_types: ARRAYED_LIST [STRING] is
			-- All Vision2 widgets that may be extended into
			-- instances of EV_CONTAINER.
		once
			create Result.make (40)
			Result.extend ("EV_BUTTON")
			Result.extend ("EV_CHECK_BUTTON")
			Result.extend ("EV_COMBO_BOX")
			Result.extend ("EV_LABEL")
			Result.extend ("EV_RADIO_BUTTON")
			Result.extend ("EV_SPIN_BUTTON")
			Result.extend ("EV_TEXT")
			Result.extend ("EV_TEXT_FIELD")
			Result.extend ("EV_TOGGLE_BUTTON")
		end
		

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class SUPPORTED_TYPES
