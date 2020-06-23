note
	description: "Object that represents an output tool which contains a text field"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_TEXT_OUTPUT_TOOL

inherit
	ANY

	EV_SHARED_APPLICATION
		export
			{NONE} all
		end

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

	SHARED_BENCH_NAMES

feature -- Accelerator

	is_accelerator_matched (a_key: EV_KEY; a_accelerator: EV_ACCELERATOR): BOOLEAN
			-- Does `a_accelerator' match current keyboard status?
		require
			a_key_attached: a_key /= Void
		local
			l_ev_app: like ev_application
		do
			l_ev_app := ev_application
			Result := a_accelerator /= Void and then
					 a_accelerator.key.code = a_key.code and then
					 a_accelerator.alt_required = l_ev_app.alt_pressed and then
					 a_accelerator.shift_required = l_ev_app.shift_pressed and then
					 a_accelerator.control_required = l_ev_app.ctrl_pressed
		end

feature -- Access

	output_text: EV_TEXT
			-- Text pane used to display output
		do
			if internal_output_text = Void then
				create internal_output_text
				internal_output_text.key_press_actions.extend (agent on_key_presses_in_output)
			end
			Result := internal_output_text
		ensure
			result_attached: Result /= Void
		end

	source_encoding: ENCODING
			-- Source encoding of process output

	locale_combo: EV_COMBO_BOX
			-- Combo box to display locale list
		do
			if locale_combo_internal = Void then
				create locale_combo_internal
				locale_combo_internal.set_strings (locale_table.linear_representation)
				locale_combo_internal.set_text (locale_table.item (preferences.misc_data.locale_id))
				locale_combo_internal.select_actions.extend (agent on_encoding_change)
				locale_combo_internal.disable_edit
				on_encoding_change
			end
			Result := locale_combo_internal
		end

	locale_combo_internal: like locale_combo
			-- Implementation of `locale_combo'

feature{NONE} -- Actions

	on_key_presses_in_output (a_key: EV_KEY)
			-- Action to be performed when key pressed on text field
		require
			a_key_attached: a_key /= Void
			output_text_attached: output_text /= Void
		do
			if is_accelerator_matched (a_key, ctrl_a) then
				output_text.select_all
			elseif is_accelerator_matched (a_key, ctrl_c) then
				if output_text.has_selection then
					output_text.copy_selection
				end
			end
		end

	on_encoding_change
			-- Action to be peroformed when selected encoding changes
		local
			l_locale: I18N_LOCALE
			l_id: READABLE_STRING_GENERAL
		do
			l_id := locale_id_table.item (locale_combo.text)
			if l_id /= Void then
				l_locale := locale_manager.locale (create {I18N_LOCALE_ID}.make_from_string (l_id))
				if l_locale = Void or else l_locale.info.code_page = Void then
					source_encoding := Void
				else
					create source_encoding.make (l_locale.info.code_page)
				end
			end
		end

feature{NONE} -- Implementation

	ctrl_c: EV_ACCELERATOR
			-- Ctrl + C accelerator
		once
			create Result.make_with_key_combination (create{EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_c), True, False, False)
		ensure
			result_attached: Result /= Void
		end

	ctrl_a: EV_ACCELERATOR
			-- Ctrl + A accelerator
		once
			create Result.make_with_key_combination (create{EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_a), True, False, False)
		ensure
			result_attached: Result /= Void
		end

	internal_output_text: like output_text
			-- Implementation of `output_text'

	locale_table: STRING_TABLE [STRING_32]
			-- Table of locales: [locale_displayed_name, locale_id]
		do
			if locale_table_internal = Void then
				locale_table_internal := locale_names.locales_from_array (preferences.misc_data.locale_id_preference.value)
					-- Add name for "Unselected" entry.
				locale_table_internal.force (names.l_unselected, "Unselected")
			end
			Result := locale_table_internal
		ensure
			result_attached: Result /= Void
		end

	locale_id_table: HASH_TABLE [READABLE_STRING_GENERAL, STRING_32]
			-- Table of locale ids: [locale_id, locale_displayed_name]
		local
			l_locale_table: like locale_table
			l_locale_id_table: like locale_id_table
		do
			if locale_id_table_internal = Void then
				create locale_id_table_internal.make (100)
				l_locale_id_table := locale_id_table_internal
				l_locale_table := locale_table
				from
					l_locale_table.start
				until
					l_locale_table.after
				loop
					l_locale_id_table.put (l_locale_table.key_for_iteration, l_locale_table.item_for_iteration)
					l_locale_table.forth
				end
			end
			Result := locale_id_table_internal
		ensure
			result_attached: Result /= Void
		end

	locale_table_internal: like locale_table
			-- Implementation of `locale_table'

	locale_id_table_internal: like locale_id_table
			-- Implementation of `locale_id_table'

feature -- Process

	process_block_text (text_block: separate EB_PROCESS_IO_STRING_BLOCK)
			-- Print `text_block' on `console'.
		local
			str: STRING
			str_general: STRING_GENERAL
		do
			if attached text_block.data as s then
				if attached {STRING} s as ss then
					str := ss
				else
					create str.make_from_separate (s)
				end
				if source_encoding /= Void then
					str_general := console_encoding_to_utf32 (source_encoding, str)
				end
				if str_general = Void then
					str_general := str
				end
				output_text.append_text (str_general)
			end
		end

note
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
