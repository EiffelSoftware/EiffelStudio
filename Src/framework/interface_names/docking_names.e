indexing
	description: "Names used in docking library."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DOCKING_NAMES

inherit
	SHARED_LOCALE

feature -- Access

	Editor_place_holder_content_name: STRING_GENERAL is
			-- Content name for `place_holder_content' in SD_DOCKING_MANAGER_ZONES.
		do
			Result := locale.translate ("docking manager editor place holder")
		end

	Zone_navigation_left_column_name: STRING_GENERAL is
			-- Left column name of SD_ZONE_NAVIGATION_DIALOG.
		do
			Result := locale.translate ("Tools")
		end

	Zone_navigation_right_column_name: STRING_GENERAL is
			-- Right column name of SD_ZONE_NAVIGATION_DIALOG.
		do
			Result := locale.translate ("Targets")
		end

	Tooltip_mini_toolbar_stick: STRING_GENERAL is
			-- Tooltip for mini toolbar pin buttons.
		do
			Result := locale.translate ("Auto Hide")
		end

	Tooltip_mini_toolbar_stick_unpin: STRING_GENERAL is
			-- Tooltip for mini toolbar unpin buttons.
		do
			Result := locale.translate ("Auto Hide")
		end

	Tooltip_mini_toolbar_maximize: STRING_GENERAL is
			-- Tooltip for mini toolbar maximize buttons.
		do
			Result :=  locale.translate ("Maximize")
		end

	Tooltip_mini_toolbar_restore: STRING_GENERAL is
			-- Tooltip for mini toolbar restore buttons.
		do
			Result := locale.translate ("Restore")
		end

	Tooltip_mini_toolbar_minimize: STRING_GENERAL is
			-- Tooltip for mini toolbar minimize buttons.
		do
			Result :=  locale.translate ("Minimize")
		end

	Tooltip_mini_toolbar_close: STRING_GENERAL is
			-- Tooltip for mini toolbar close buttons.
		do
			Result := locale.translate ("Close")
		end

	Tooltip_mini_toolbar_hidden_toolbar_indicator: STRING_GENERAL is
			-- Tooltip for mini toolbar hidden tool bar indicators.
		do
			Result := locale.translate ("Show Mini Toolbar")
		end

	Tooltip_mini_toolbar_hidden_tab_indicator: STRING_GENERAL is
			-- Tooltip for mini toolbar hidden tab indicators.
		do
			Result := locale.translate ("Show List")
		end

	Tooltip_toolbar_tail_indicator: STRING_GENERAL is
			-- Tooltip for tool bar tail indicators.
		do
			Result := locale.translate ("Toolbar Options")
		end

	Tooltip_toolbar_floating_close: STRING_GENERAL is
			-- Tooltip for tool bar close button.
		do
			Result := locale.translate ("Close")
		end

	Tooltip_notebook_hidden_tab_indicator: STRING_GENERAL is
			-- Tooltip for notebook hidden tab indicator.
		do
			Result := locale.translate ("Show List")
		end

feature -- Tool bar customize dialog strings

	tool_bar_customize_title: STRING_GENERAL is
			-- Tool bar customize dialog title.
		do
			Result := locale.translate ("Customize Toolbar")
		end

	available_buttons: STRING_GENERAL is
			-- Tool bar customize dialog label.
		do
			Result := locale.translate ("Available buttons")
		end

	displayed_buttons: STRING_GENERAL is
			-- Tool bar customize dialog label.
		do
			Result := locale.translate ("Displayed buttons")
		end

	add_button: STRING_GENERAL is
			-- Tool bar customize dialog add button text.
		do
			Result := locale.translate ("Add ->")
		end

	remove_button: STRING_GENERAL is
			-- Tool bar customize dialog remove button text.
		do
			Result := locale.translate ("<- Remove")
		end

	move_button_up: STRING_GENERAL is
			-- Tool bar customize dialog move button up button text.
		do
			Result := locale.translate ("Up")
		end

	move_button_down: STRING_GENERAL is
			-- Tool bar customize dialog move button down button text.
		do
			Result := locale.translate ("Down")
		end

	separator: STRING_GENERAL is
			-- Tool bar separator name which appeared in tool bar customize dialog.
		do
			Result := locale.translate ("Separator")
		end

	ok: STRING_GENERAL is
			-- Ok button text.
		do
			Result := locale.translate ("OK")
		end

	cancel: STRING_GENERAL is
			-- Cancel button text.
		do
			Result := locale.translate ("Cancel")
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
