note
	description: "[
		A specialized editor widget for supporting different locale in the editor output.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_LOCALE_EDITOR_WIDGET

inherit
	ES_EDITOR_WIDGET
		redefine
			new_right_tool_bar_items
		end

create
	make

convert
	widget: {EV_WIDGET}

feature {NONE} -- Access



feature {NONE} -- Access: User interface

	locale_selection: attached EV_COMBO_BOX
			-- Combo box to select the locale

feature {NONE} -- Basic operations

feature {NONE} -- Action handlers

	on_locale_changed
			-- Called when the locale changes.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do

		end

feature {NONE} -- Factory

	new_right_tool_bar_items: detachable DS_ARRAYED_LIST [SD_TOOL_BAR_ITEM]
			-- <Precursor>
		local
			l_combo: EV_COMBO_BOX
			l_widget: SD_TOOL_BAR_WIDGET_ITEM
			l_hbox: EV_HORIZONTAL_BOX
			l_label: EV_LABEL
		do
			Result := Precursor
			if Result = Void then
				create Result.make (1)
			else
				Result.resize (2 + Result.count)
				Result.put_last (create {SD_TOOL_BAR_SEPARATOR}.make)
			end

			create l_hbox
			l_hbox.set_padding ({ES_UI_CONSTANTS}.horizontal_padding)
			create l_label.make_with_text (locale_formatter.translation (lb_locale))
			l_hbox.extend (l_label)
			l_hbox.disable_item_expand (l_label)
			create l_combo
			l_combo.set_minimum_width (200)
			register_action (l_combo.change_actions, agent on_locale_changed)
			l_hbox.extend (l_combo)
			locale_selection := l_combo

			create l_widget.make (l_hbox)
			Result.put_last (l_widget)
		end

feature {NONE} -- Internationalization

	tt_locale: STRING = "Select an alternative locale for the output."

	lb_locale: STRING = "Locale:"

;note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
