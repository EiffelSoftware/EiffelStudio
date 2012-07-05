note
	description: "System color on Unix."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_SYSTEM_COLOR_IMP

inherit
	SD_SYSTEM_COLOR

	EV_ANY_HANDLER

create
	make

feature {NONE} -- Initlization
	make
			-- Creation method
		do
		end

feature -- Access

	default_background_color: EV_COLOR
			-- Default background color
		do
			Result := stock_colors_imp.default_background_color
		end

	mdi_back_ground_color: EV_COLOR
			-- Background color of Multiple Document Interface (MDI) Applications.
		do
			Result := active_color
		end

	focused_selection_color: EV_COLOR
			-- Focused selection color for title bar.
		do
			Result := selected_color
		end

	non_focused_selection_color: EV_COLOR
			-- Non focused selection color for title bar.
		do
			Result := normal_color
		end

	non_focused_title_text_color: EV_COLOR
			-- Non focuesd title text color
		local
			l_helper: SD_COLOR_HELPER
		do
			create l_helper
			Result := l_helper.text_color_by (non_focused_selection_title_color)
		end

	non_focused_selection_title_color: EV_COLOR
			-- Non focused selection title color
		do
			Result := insesitive_color
		end

	active_border_color: EV_COLOR
			-- Active border color
		do
			Result := active_color--dark_color
		end

	focused_title_text_color: EV_COLOR
			-- Focused title text color
		local
			l_grid: EV_GRID
		do
			create l_grid
			Result := l_grid.focused_selection_text_color
		end

	button_text_color: EV_COLOR
			-- Button text color
		local
			l_grid: EV_GRID
		do
			create l_grid
			Result := l_grid.foreground_color
		end

feature -- Font

	tool_bar_font: EV_FONT
			-- Redefine.
		local
			l_drawing_area: EV_DRAWING_AREA
		do
			create l_drawing_area
			Result := l_drawing_area.font
		end

feature -- HoT zone factory

	hot_zone_factory: SD_HOT_ZONE_OLD_FACTORY
			-- Hot zone factory which will be used on GTK.
		do
			create Result
		end

feature {NONE} -- GTK text_aa colors.

	normal_color: EV_COLOR
			-- State during normal operation.
		do
			Result := stock_colors_imp.color_from_state (tree_view, {EV_STOCK_COLORS_IMP}.bg_style, {GTK}.gtk_state_flag_normal_enum)
		end

	active_color: EV_COLOR
			-- State of a currently active widget, such as a depressed button.
		do
			Result := stock_colors_imp.color_from_state (tree_view, {EV_STOCK_COLORS_IMP}.bg_style, {GTK}.gtk_state_flag_active_enum)
		end

	dark_color: EV_COLOR
			-- Dark color of a widget.
		do
			Result := stock_colors_imp.color_from_state (tree_view, {EV_STOCK_COLORS_IMP}.bg_style, {GTK}.gtk_state_flag_normal_enum)
		end

	prelight_color: EV_COLOR
			-- State indicating that the mouse pointer is over the widget and widget will respond to mouse clicks.
		do
			Result := stock_colors_imp.color_from_state (tree_view, {EV_STOCK_COLORS_IMP}.bg_style, {GTK}.gtk_state_flag_prelight_enum)
		end

	selected_color: EV_COLOR
			-- State of a selected item, such the selected row in a list.
		do
			Result := stock_colors_imp.color_from_state (tree_view, {EV_STOCK_COLORS_IMP}.bg_style, {GTK}.gtk_state_flag_selected_enum)
		end

	insesitive_color: EV_COLOR
			-- State indicating that the widget is unresponsive to user actions.
		do
			Result := stock_colors_imp.color_from_state (tree_view, {EV_STOCK_COLORS_IMP}.bg_style, {GTK}.gtk_state_flag_insensitive_enum)
		end

feature {NONE} -- Implementation

	stock_colors_imp: EV_STOCK_COLORS_IMP
		local
			l_stock_colors: EV_STOCK_COLORS
		once
			create l_stock_colors
			check attached {EV_STOCK_COLORS_IMP} l_stock_colors.implementation as l_result then
				Result := l_result
			end
		end

feature {NONE} -- Implementation

	frozen tree_view : POINTER
		once
			Result := {GTK2}.gtk_tree_view_new
		end

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"






end
