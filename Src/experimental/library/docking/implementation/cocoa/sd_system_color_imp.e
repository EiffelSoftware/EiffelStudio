note
	description: "System color on the Mac."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_SYSTEM_COLOR_IMP

inherit
	SD_SYSTEM_COLOR

	REFACTORING_HELPER

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
		local
			l_stock_colors: EV_STOCK_COLORS
		do
			create l_stock_colors
			Result := l_stock_colors.default_background_color
		end

	mdi_back_ground_color: EV_COLOR
			-- Background color of Multiple Document Interface (MDI) Applications.
		do
			Result := active_color
		end

	focused_selection_color: EV_COLOR
			-- Focused selection color for title bar.
			-- SD_TITE_BAR background of the focused window Blue
		local
			l_color: NS_COLOR
		do
			create l_color.keyboard_focus_indicator_color
			l_color := l_color.color_using_color_space_name (create {NS_STRING}.make_with_string ("NSDeviceRGBColorSpace"))
			create Result.make_with_rgb (l_color.red_component, l_color.green_component, l_color.blue_component)
		end

	non_focused_selection_color: EV_COLOR
			-- Non focused selection color for title bar.
			-- SD_TITLE_BAR: Font color for the focused window and the color that is faded to on the right
		local
--			l_color: NS_COLOR
		do
--			create l_color.light_gray_color
--			l_color := l_color.color_using_color_space_name (create {NS_STRING}.make_with_string ("NSDeviceRGBColorSpace"))
			create Result.make_with_rgb ({REAL_32}0.91, {REAL_32}0.91, {REAL_32}0.91)
		end

	non_focused_title_text_color: EV_COLOR
			-- Non focuesd title text color
		do
			create Result.make_with_rgb ({REAL_32}0.0, {REAL_32}0.0, {REAL_32}0.0)
		end

	non_focused_selection_title_color: EV_COLOR
			-- Non focused selection title color
		do
			create Result.make_with_rgb ({REAL_32}0.0, {REAL_32}0.0, {REAL_32}0.0)
		end

	active_border_color: EV_COLOR
			-- Active border color
			-- Used by SD_TITLE_BAR for the border around titles
		do
			create Result.make_with_rgb ({REAL_32}0.1, {REAL_32}0.1, {REAL_32}0.1)
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
			-- Hot zone factory which will be used on Cocoa.
		do
			create Result
		end

feature {NONE} -- Cocoa text_aa colors.

	normal_color: EV_COLOR
			-- State during normal operation.
		do
			create Result.make_with_rgb ({REAL_32}1.0, {REAL_32}1.0, {REAL_32}0.0)
		end

	active_color: EV_COLOR
			-- State of a currently active widget, such as a depressed button.
		do
			create Result.make_with_rgb ({REAL_32}1.0, {REAL_32}0.0, {REAL_32}0.0)
		end

	dark_color: EV_COLOR
			-- Dark color of a widget.
		do
			create Result.make_with_rgb ({REAL_32}1.0, {REAL_32}0.0, {REAL_32}1.0)
		end

	prelight_color: EV_COLOR
			-- State indicating that the mouse pointer is over the widget and widget will respond to mouse clicks.
		do
			create Result.make_with_rgb ({REAL_32}0.0, {REAL_32}1.0, {REAL_32}0.0)
		end

	selected_color: EV_COLOR
			-- State of a selected item, such the selected row in a list.
		do
			create Result.make_with_rgb ({REAL_32}0.0, {REAL_32}1.0, {REAL_32}1.0)
		end

	insesitive_color: EV_COLOR
			-- State indicating that the widget is unresponsive to user actions.
		do
			create Result.make_with_rgb ({REAL_32}0.0, {REAL_32}0.0, {REAL_32}1.0)
		end

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2009, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"






end
