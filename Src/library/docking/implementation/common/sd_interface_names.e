indexing
	description: "[
						All interface names used by Smart Docking library.
						Client programmers can inherit this class to provide his own names.
						Call set_interface_names from SD_SHARED to set singleton.
																							]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SD_INTERFACE_NAMES

feature -- Enumeration

	Zone_navigation_left_column_name: STRING_32 is
			-- Left column name of SD_ZONE_NAVIGATION_DIALOG.
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	Zone_navigation_right_column_name: STRING_32 is
			-- Right column name of SD_ZONE_NAVIGATION_DIALOG.
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	Tooltip_mini_toolbar_stick: STRING_32 is
			-- Tooltip for mini toolbar pin buttons.
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	Tooltip_mini_toolbar_stick_unpin: STRING_32 is
			-- Tooltip for mini toolbar unpin buttons.
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	Tooltip_mini_toolbar_maximize: STRING_32 is
			-- Tooltip for mini toolbar maximize buttons.
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	Tooltip_mini_toolbar_restore: STRING_32 is
			-- Tooltip for mini toolbar restore buttons.
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	Tooltip_mini_toolbar_minimize: STRING_32 is
			-- Tooltip for mini toolbar minimize buttons.
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	Tooltip_mini_toolbar_close: STRING_32 is
			-- Tooltip for mini toolbar close buttons.
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	Tooltip_mini_toolbar_hidden_toolbar_indicator: STRING_32 is
			-- Tooltip for mini toolbar hidden tool bar indicators.
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	Tooltip_mini_toolbar_hidden_tab_indicator: STRING_32 is
			-- Tooltip for mini toolbar hidden tab indicators.
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	Tooltip_toolbar_tail_indicator: STRING_32 is
			-- Tooltip for tool bar tail indicators.
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	Tooltip_toolbar_floating_close: STRING_32 is
			-- Tooltip for tool bar close button.
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	Tooltip_notebook_hidden_tab_indicator: STRING_32 is
			-- Tooltip for notebook hidden tab indicator.
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	Zone_navigation_no_description_available: STRING_32 is
			-- Label text for zone navigation dialog.
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	Zone_navigation_no_detail_available: STRING_32 is
			-- Label text for zone navigation dialog.
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	tool_bar_right_click_customize (toolbar_name: STRING_GENERAL): STRING_32 is
			-- String for menu area right click menu.
		deferred
		ensure
			Result_not_void: Result /= Void
		end

feature -- Tool bar customize dialog strings

	tool_bar_customize_title: STRING_32 is
			-- Tool bar customize dialog title.
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	available_buttons: STRING_32 is
			-- Tool bar customize dialog label.
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	displayed_buttons: STRING_32 is
			-- Tool bar customize dialog label.
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	add_button: STRING_32 is
			-- Tool bar customize dialog add button text.
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	remove_button: STRING_32 is
			-- Tool bar customize dialog remove button text.
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	move_button_up: STRING_32 is
			-- Tool bar customize dialog move button up button text.
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	move_button_down: STRING_32 is
			-- Tool bar customize dialog move button down button text.
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	separator: STRING_32 is
			-- Tool bar separator name which appeared in tool bar customize dialog.
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	ok: STRING_32 is
			-- Ok button text.
		deferred
		ensure
			Result_not_void: Result /= Void
		end

	cancel: STRING_32 is
			-- Cancel button text.
		deferred
		ensure
			Result_not_void: Result /= Void
		end

feature -- Hidden item dialog strings

	customize: STRING_32 is
			-- Customize menu entry text.
		deferred
		ensure
			Result_not_void: Result /= Void
		end

feature -- Menu

	menu_close: STRING_32
			-- For editor tab area right click menu
		deferred
		end

	menu_close_all_but_this: STRING_32
			-- For editor tab area right click menu
		deferred
		end

	menu_close_all: STRING_32
			-- For editor tab area right click menu
		deferred
		end

feature -- Editor

	editor_area: STRING_32
			-- For minimized editor area
		do
			Result := "Editor Area"
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
