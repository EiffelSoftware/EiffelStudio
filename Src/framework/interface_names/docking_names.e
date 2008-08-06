indexing
	description: "Names used in docking library."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"
	
class
	DOCKING_NAMES

inherit
	SHARED_LOCALE

feature -- Access

	Zone_navigation_left_column_name: STRING_32 is
			-- Left column name of SD_ZONE_NAVIGATION_DIALOG.
		do
			Result := locale.translation ("Tools")
		end

	Zone_navigation_right_column_name: STRING_32 is
			-- Right column name of SD_ZONE_NAVIGATION_DIALOG.
		do
			Result := locale.translation ("Targets")
		end

	Tooltip_mini_toolbar_stick: STRING_32 is
			-- Tooltip for mini toolbar pin buttons.
		do
			Result := locale.translation ("Auto Hide")
		end

	Tooltip_mini_toolbar_stick_unpin: STRING_32 is
			-- Tooltip for mini toolbar unpin buttons.
		do
			Result := locale.translation ("Disable Auto Hide")
		end

	Tooltip_mini_toolbar_maximize: STRING_32 is
			-- Tooltip for mini toolbar maximize buttons.
		do
			Result :=  locale.translation ("Maximize")
		end

	Tooltip_mini_toolbar_restore: STRING_32 is
			-- Tooltip for mini toolbar restore buttons.
		do
			Result := locale.translation ("Restore")
		end

	Tooltip_mini_toolbar_minimize: STRING_32 is
			-- Tooltip for mini toolbar minimize buttons.
		do
			Result :=  locale.translation ("Minimize")
		end

	Tooltip_mini_toolbar_close: STRING_32 is
			-- Tooltip for mini toolbar close buttons.
		do
			Result := locale.translation ("Close")
		end

	Tooltip_mini_toolbar_hidden_toolbar_indicator: STRING_32 is
			-- Tooltip for mini toolbar hidden tool bar indicators.
		do
			Result := locale.translation ("Show Mini Toolbar")
		end

	Tooltip_mini_toolbar_hidden_tab_indicator: STRING_32 is
			-- Tooltip for mini toolbar hidden tab indicators.
		do
			Result := locale.translation ("Show List")
		end

	Tooltip_toolbar_tail_indicator: STRING_32 is
			-- Tooltip for tool bar tail indicators.
		do
			Result := locale.translation ("Toolbar Options")
		end

	Tooltip_toolbar_floating_close: STRING_32 is
			-- Tooltip for tool bar close button.
		do
			Result := locale.translation ("Close")
		end

	Tooltip_notebook_hidden_tab_indicator: STRING_32 is
			-- Tooltip for notebook hidden tab indicator.
		do
			Result := locale.translation ("Show List")
		end

	Zone_navigation_no_description_available: STRING_32 is
			-- Label text for zone navigation dialog.
		do
			Result := locale.translation ("No description available.")
		end

	Zone_navigation_no_detail_available: STRING_32 is
			-- Label text for zone navigation dialog.
		do
			Result := locale.translation ("No detail available.")
		end

	tool_bar_right_click_customize (toolbar_name: STRING_GENERAL): STRING_32 is
			-- String for menu area right click menu.
		do
			Result := locale.formatted_string (locale.translation ("Customize $1..."), [toolbar_name])
		end

feature -- Tool bar customize dialog strings

	tool_bar_customize_title: STRING_32 is
			-- Tool bar customize dialog title.
		do
			Result := locale.translation ("Customize Toolbar")
		end

	available_buttons: STRING_32 is
			-- Tool bar customize dialog label.
		do
			Result := locale.translation ("Available buttons")
		end

	displayed_buttons: STRING_32 is
			-- Tool bar customize dialog label.
		do
			Result := locale.translation ("Displayed buttons")
		end

	add_button: STRING_32 is
			-- Tool bar customize dialog add button text.
		do
			Result := locale.translation ("Add ->")
		end

	remove_button: STRING_32 is
			-- Tool bar customize dialog remove button text.
		do
			Result := locale.translation ("<- Remove")
		end

	move_button_up: STRING_32 is
			-- Tool bar customize dialog move button up button text.
		do
			Result := locale.translation ("Up")
		end

	move_button_down: STRING_32 is
			-- Tool bar customize dialog move button down button text.
		do
			Result := locale.translation ("Down")
		end

	separator: STRING_32 is
			-- Tool bar separator name which appeared in tool bar customize dialog.
		do
			Result := locale.translation ("Separator")
		end

	ok: STRING_32 is
			-- Ok button text.
		do
			Result := locale.translation ("OK")
		end

	cancel: STRING_32 is
			-- Cancel button text.
		do
			Result := locale.translation ("Cancel")
		end

feature -- Hidden item dialog strings

	customize: STRING_32 is
			-- Customize menu entry text.
		do
			Result := locale.translation ("Customize")
		end

feature -- Menu

	menu_close: STRING_32
			-- For editor tab area right click menu
		do
			Result := locale.translation ("Close")
		end

	menu_close_all_but_this: STRING_32
			-- For editor tab area right click menu
		do
			Result := locale.translation ("Close All But This")
		end

	menu_close_all: STRING_32
			-- For editor tab area right click menu
		do
			Result := locale.translation ("Close All")
		end

feature -- Editor

	editor_area: STRING_32
			-- For minimized editor area
		do
			Result := locale.translation ("Editor Area")
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end
