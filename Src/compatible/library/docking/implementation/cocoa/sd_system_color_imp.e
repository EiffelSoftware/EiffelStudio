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
			-- Hot zone factory which will be used on Cocoa.
		do
			create Result
		end

feature {NONE} -- Cocoa text_aa colors.

	normal_color: EV_COLOR
			-- State during normal operation.
		do
			create Result
		end

	active_color: EV_COLOR
			-- State of a currently active widget, such as a depressed button.
		do
			create Result
		end

	dark_color: EV_COLOR
			-- Dark color of a widget.
		do
			create Result
		end

	prelight_color: EV_COLOR
			-- State indicating that the mouse pointer is over the widget and widget will respond to mouse clicks.
		do
			create Result
		end

	selected_color: EV_COLOR
			-- State of a selected item, such the selected row in a list.
		do
			create Result
		end

	insesitive_color: EV_COLOR
			-- State indicating that the widget is unresponsive to user actions.
		do
			create Result
		end

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"






end
