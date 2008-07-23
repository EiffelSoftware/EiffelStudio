indexing
	description: "Default interface names used by Smart Docking library."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_DEFAULT_INTERFACE_NAMES

inherit
	SD_INTERFACE_NAMES

feature -- Enumeration

	Zone_navigation_left_column_name: STRING_32 is
			-- Left column name of SD_ZONE_NAVIGATION_DIALOG.
		do
			Result := "Tools"
		end

	Zone_navigation_right_column_name: STRING_32 is
			-- Right column name of SD_ZONE_NAVIGATION_DIALOG.
		do
			Result := "Targets"
		end

	Tooltip_mini_toolbar_stick: STRING_32 is
			-- Tooltip for mini toolbar pin buttons.
		do
			Result := "Auto Hide"
		end

	Tooltip_mini_toolbar_stick_unpin: STRING_32 is
			-- Tooltip for mini toolbar unpin buttons.
		do
			Result := "Disable Auto Hide"
		end

	Tooltip_mini_toolbar_maximize: STRING_32 is
			-- Tooltip for mini toolbar maximize buttons.
		do
			Result :=  "Maximize"
		end

	Tooltip_mini_toolbar_restore: STRING_32 is
			-- Tooltip for mini toolbar restore buttons.
		do
			Result := "Restore"
		end

	Tooltip_mini_toolbar_minimize: STRING_32 is
			-- Tooltip for mini toolbar minimize buttons.
		do
			Result :=  "Minimize"
		end

	Tooltip_mini_toolbar_close: STRING_32 is
			-- Tooltip for mini toolbar close buttons.
		do
			Result := "Close"
		end

	Tooltip_mini_toolbar_hidden_toolbar_indicator: STRING_32 is
			-- Tooltip for mini toolbar hidden tool bar indicators.
		do
			Result := "Show Mini Toolbar"
		end

	Tooltip_mini_toolbar_hidden_tab_indicator: STRING_32 is
			-- Tooltip for mini toolbar hidden tab indicators.
		do
			Result := "Show List"
		end

	Tooltip_toolbar_tail_indicator: STRING_32 is
			-- Tooltip for tool bar tail indicators.
		do
			Result := "Toolbar Options"
		end

	Tooltip_toolbar_floating_close: STRING_32 is
			-- Tooltip for tool bar close button.
		do
			Result := "Close"
		end

	Tooltip_notebook_hidden_tab_indicator: STRING_32 is
			-- Tooltip for notebook hidden tab indicator.
		do
			Result := "Show List"
		end

	Zone_navigation_no_description_available: STRING_32 is
			-- Label text for zone navigation dialog.
		do
			Result := "No description available."
		end

	Zone_navigation_no_detail_available: STRING_32 is
			-- Label text for zone navigation dialog.
		do
			Result := "No detail available."
		end

	tool_bar_right_click_customize (toolbar_name: STRING_GENERAL): STRING_32 is
			-- String for menu area right click menu.
		do
			Result := "Customize " + toolbar_name.as_string_8 + "..."
		end

feature -- Tool bar customize dialog strings

	tool_bar_customize_title: STRING_32 is
			-- Tool bar customize dialog title.
		do
			Result := "Customize Toolbar"
		end

	available_buttons: STRING_32 is
			-- Tool bar customize dialog label.
		do
			Result := "Available buttons"
		end

	displayed_buttons: STRING_32 is
			-- Tool bar customize dialog label.
		do
			Result := "Displayed buttons"
		end

	add_button: STRING_32 is
			-- Tool bar customize dialog add button text.
		do
			Result := "Add ->"
		end

	remove_button: STRING_32 is
			-- Tool bar customize dialog remove button text.
		do
			Result := "<- Remove"
		end

	move_button_up: STRING_32 is
			-- Tool bar customize dialog move button up button text.
		do
			Result := "Up"
		end

	move_button_down: STRING_32 is
			-- Tool bar customize dialog move button down button text.
		do
			Result := "Down"
		end

	separator: STRING_32 is
			-- Tool bar separator name which appeared in tool bar customize dialog.
		do
			Result := "Separator"
		end

	ok: STRING_32 is
			-- Ok button text.
		do
			Result := "OK"
		end

	cancel: STRING_32 is
			-- Cancel button text.
		do
			Result := "Cancel"
		end

feature -- Hidden item dialog strings

	customize: STRING_32 is
			-- Customize menu entry text.
		do
			Result := "Customize"
		end

feature -- Menu

	menu_close: STRING_32
			-- For editor tab area right click menu
		do
			Result := "Close"
		end

	menu_close_all_but_this: STRING_32
			-- For editor tab area right click menu
		do
			Result := "Close All But This"
		end

	menu_close_all: STRING_32
			-- For editor tab area right click menu
		do
			Result := "Close All"
		end

indexing
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
