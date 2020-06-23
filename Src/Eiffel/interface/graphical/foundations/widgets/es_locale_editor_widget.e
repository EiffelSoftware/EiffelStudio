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
			on_after_initialized,
			new_right_tool_bar_items
		end

create
	make

convert
	container_widget: {EV_WIDGET}

feature {NONE} -- Initialization

	on_after_initialized
			-- <Precursor>
		do
			Precursor

				-- Set the default string.
			locale_selection.change_actions.block
			locale_selection.set_strings (locale_table.linear_representation)
			locale_selection.change_actions.resume
				-- Force a change.
			on_locale_preference_changed
				-- Receive notification when the user changes the preference.
			register_action (preferences.misc_data.locale_id_preference.change_actions, agent on_locale_preference_changed)
		end

feature -- Access

	encoding: detachable ENCODING
			-- Last set locale encoding.

feature {NONE} -- Access

	locale_table: STRING_TABLE [STRING_32]
			-- Table of locales, indexed by a locale ID.
			--
			-- Key: Locale ID.
			-- Value: Locale description.
		local
			l_names: LOCALE_NAMES
		once
			l_names := (create {SHARED_BENCH_NAMES}).locale_names
			Result := l_names.locales_from_array (preferences.misc_data.locale_id_preference.value)

				-- Add name for "Unselected" entry.
			--Result.force (interface_names.l_unselected, "")
		ensure
			result_attached: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	locale_id_table: HASH_TABLE [READABLE_STRING_GENERAL, STRING_32]
			-- Table of locales, indexed by a locale description.
			--
			-- Key: Locale description.
			-- Value: Locale ID.
		local
			l_locale_table: like locale_table
			l_value: READABLE_STRING_GENERAL
			l_key: STRING_32
		once
			l_locale_table := locale_table
			create Result.make (l_locale_table.count)
			from l_locale_table.start until l_locale_table.after loop
				l_value := l_locale_table.key_for_iteration
				l_key := l_locale_table.item_for_iteration
				if l_key /= Void and then l_value /= Void then
					Result.force (l_value, l_key)
				end
				l_locale_table.forth
			end
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Access: User interface

	locale_selection: attached EV_COMBO_BOX
			-- Combo box to select the locale

feature {NONE} -- Helpers

	locale_manager: SHARED_LOCALE
			-- Access to the shared local manager
		once
			create Result
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Action handlers

	on_locale_changed
			-- Called when the locale changes.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		local
			l_locale: I18N_LOCALE
			l_id: READABLE_STRING_GENERAL
			l_text: STRING_32
		do
			encoding := Void
			l_text := locale_selection.text
			if l_text /= Void and then not l_text.is_empty then
				l_id := locale_id_table.item (l_text)
				if l_id /= Void then
					l_locale := (create {SHARED_LOCALE}).locale_manager.locale (create {I18N_LOCALE_ID}.make_from_string (l_id))
					if l_locale.info.code_page /= Void then
						create encoding.make (l_locale.info.code_page)
						editor.set_encoding (encoding)
					end
				end
			end
		end

	on_locale_preference_changed
			-- Called when the locale preference changed.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		local
			l_locale_id: STRING_32
			l_text: STRING_32
			l_table: like locale_table
		do
			l_locale_id := preferences.misc_data.locale_id
			if l_locale_id /= Void and then not l_locale_id.is_empty then
				l_table := locale_table
				if l_table.has (l_locale_id) then
					l_text := l_table.item (l_locale_id)
					check
						l_text_attached: l_text/= Void
						not_l_text_is_empty: not l_text.is_empty
					end
					locale_selection.enable_edit
					locale_selection.set_text (l_text)
					locale_selection.disable_edit

						-- Trigger notification
					on_locale_changed
				end
			end
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

				-- Locale label
			create l_hbox
			l_hbox.set_padding ({EV_MONITOR_DPI_DETECTOR_IMP}.scaled_size ({ES_UI_CONSTANTS}.horizontal_padding))
			create l_label.make_with_text (locale_formatter.translation (lb_locale) + ":")
			l_hbox.extend (l_label)
			l_hbox.disable_item_expand (l_label)

				-- Locale selection
			create l_combo
			l_combo.disable_edit
			l_combo.set_minimum_width ({EV_MONITOR_DPI_DETECTOR_IMP}.scaled_size (200))
			register_action (l_combo.change_actions, agent on_locale_changed)
			locale_selection := l_combo
			l_hbox.extend (l_combo)

			create l_widget.make (l_hbox)
			Result.put_last (l_widget)
		end

feature {NONE} -- Internationalization

	tt_locale: STRING = "Select an alternative locale for the output"

	lb_locale: STRING = "Locale"

;note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
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
