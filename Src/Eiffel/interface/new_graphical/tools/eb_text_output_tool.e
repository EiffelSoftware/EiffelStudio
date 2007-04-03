indexing
	description: "Object that represents an output tool which contains a text field"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
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

	is_accelerator_matched (a_key: EV_KEY; a_accelerator: EV_ACCELERATOR): BOOLEAN is
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

	output_text: EV_TEXT is
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

	destination_encoding: ENCODING is
			-- Destination encoding to display process output
		do
			if destination_encoding_internal = Void then
				create destination_encoding_internal.make ((create{CODE_PAGE_CONSTANTS}).utf16)
			end
			Result := destination_encoding_internal
		end

	destination_encoding_internal: like destination_encoding
			-- Implementation of `destination_encoding'

	locale_combo: EV_COMBO_BOX is
			-- Combo box to display locale list
		local
			l_locale_table: like locale_table
			l_locales: LINKED_LIST [STRING_GENERAL]
		do
			if locale_combo_internal = Void then
				create locale_combo_internal
				locale_combo_internal.disable_edit
				l_locale_table := locale_table
				create l_locales.make
				from
					l_locale_table.start
				until
					l_locale_table.after
				loop
					l_locales.extend (l_locale_table.item_for_iteration)
					l_locale_table.forth
				end
				locale_combo_internal.set_strings (l_locales)
				locale_combo_internal.set_text (locale_table.item (preferences.misc_data.locale_id))
				locale_combo_internal.change_actions.extend (agent on_encoding_change)
				on_encoding_change
			end
			Result := locale_combo_internal
		end

	locale_combo_internal: like locale_combo
			-- Implementation of `locale_combo'

feature -- Actions

	on_key_presses_in_output (a_key: EV_KEY) is
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

feature{NONE} -- Actions

	on_encoding_change is
			-- Action to be peroformed when selected encoding changes
		do
			create source_encoding.make (locale_manager.get_locale (create {I18N_LOCALE_ID}.make_from_string (locale_id_table.item (locale_combo.text))).info.code_page)
		end

feature{NONE} -- Implementation

	ctrl_c: EV_ACCELERATOR is
			-- Ctrl + C accelerator
		once
			create Result.make_with_key_combination (create{EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_c), True, False, False)
		ensure
			result_attached: Result /= Void
		end

	ctrl_a: EV_ACCELERATOR is
			-- Ctrl + A accelerator
		once
			create Result.make_with_key_combination (create{EV_KEY}.make_with_code ({EV_KEY_CONSTANTS}.key_a), True, False, False)
		ensure
			result_attached: Result /= Void
		end

	internal_output_text: like output_text
			-- Implementation of `output_text'

	locale_table: HASH_TABLE [STRING_GENERAL, STRING] is
			-- Table of locales: [locale_displayed_name, locale_id]
		do
			if locale_table_internal = Void then
				locale_table_internal := locale_names.locales_from_array (preferences.misc_data.locale_id_preference.value)
			end
			Result := locale_table_internal
		ensure
			result_attached: Result /= Void
		end

	locale_id_table: HASH_TABLE [STRING, STRING_GENERAL] is
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

	locale_id_table_internal: like locale_id_table;
			-- Implementation of `locale_id_table'			

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
