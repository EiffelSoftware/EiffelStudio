indexing
	description: "[
		A dialog to add a new contract to the contract tool {ES_CONTRACT_TOOL}.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ES_ADD_CONTRACT_DIALOG

inherit
	ES_DIALOG
		redefine
			internal_recycle,
			on_after_initialized
		end

	TEXT_OBSERVER
		export
			{NONE} all
		redefine
			on_text_edited
		end

create
	make

feature {NONE} -- Initialization

	build_dialog_interface (a_container: EV_VERTICAL_BOX)
			-- <Precursor>
		local
			l_label: EV_LABEL
			l_vbox: EV_VERTICAL_BOX
			l_border: ES_BORDERED_WIDGET [EV_WIDGET]
		do
			a_container.set_padding ({ES_UI_CONSTANTS}.vertical_padding)

				-- Contract tag
			create l_vbox
			l_vbox.set_padding ({ES_UI_CONSTANTS}.label_vertical_padding)

			create l_label.make_with_text ("Tag name:")
			auto_recycle (l_label)
			l_label.align_text_left
			l_vbox.extend (l_label)
			l_vbox.disable_item_expand (l_label)

			create tag_text.make (create {EV_TEXT_FIELD}, agent validate_tag_text)
			tag_text.text_field.set_font (preferences.editor_data.editor_font_preference.value)
			suppress_confirmation_key_close (tag_text.text_field)
			auto_recycle (tag_text)
			tag_text.valid_state_changed_event.subscribe (agent on_valid_state_changed)
			l_vbox.extend (tag_text)
			l_vbox.disable_item_expand (tag_text)
			a_container.extend (l_vbox)
			a_container.disable_item_expand (l_vbox)

				-- Contract
			create l_vbox
			l_vbox.set_padding ({ES_UI_CONSTANTS}.label_vertical_padding)

			create l_label.make_with_text ("Contract:")
			auto_recycle (l_label)
			l_label.align_text_left
			l_vbox.extend (l_label)
			l_vbox.disable_item_expand (l_label)

			create contract_editor.make (development_window)
			auto_recycle (contract_editor)
			contract_editor.disable_line_numbers
			contract_editor.disable_has_breakable_slots
			contract_editor.widget.set_minimum_size (400, 100)
			create l_border.make (contract_editor.widget)
			auto_recycle (l_border)
			l_vbox.extend (l_border)
			a_container.extend (l_vbox)

			set_button_action_before_close (default_confirm_button, agent on_ok)
		end

	on_after_initialized
			-- <Precursor>
		do
			Precursor

				-- Set default tag name
			tag_text.set_text (create {!STRING_32}.make_from_string ("new_contract"))
			tag_text.validate
			register_kamikaze_action (show_actions, agent
				do
					tag_text.text_field.set_focus
					tag_text.text_field.select_all
				end)

				-- Set default contract text
			contract_editor.load_text ((True).out)

				-- Add editor observer
			contract_editor.add_edition_observer (Current)
		end

feature {NONE} -- Clean up

	internal_recycle
			-- <Precursor>
		do
			contract_editor.remove_observer (Current)
			Precursor
		end

feature -- Access

	contract: ?TUPLE [tag: !STRING_32; contract: !STRING_32]
			-- Resulting contact

feature -- Dialog access

	icon: EV_PIXEL_BUFFER
			-- <Precursor>
		once
			Result := (create {EB_SHARED_PIXMAPS}).icon_buffer_with_overlay (stock_pixmaps.tool_contract_editor_icon_buffer, stock_pixmaps.overlay_new_icon_buffer, 0, 0)
		end

	title: STRING_32
			-- <Precursor>
		do
			Result := "Add New Contract"
		end

	buttons: DS_SET [INTEGER]
			-- <Precursor>
		do
			Result := dialog_buttons.ok_cancel_buttons
		end

	default_button: INTEGER
			-- <Precursor>
		do
			Result := dialog_buttons.ok_button
		end

	default_confirm_button: INTEGER
			-- <Precursor>
		do
			Result := dialog_buttons.ok_button
		end

	default_cancel_button: INTEGER
			-- <Precursor>
		do
			Result := dialog_buttons.cancel_button
		end

feature {NONE} -- User interface elements

	tag_text: !ES_VALIDATION_TEXT_FIELD
			-- Contract tag text field

	contract_editor: !EB_SMART_EDITOR
			-- Editor use to edit the contract

feature {NONE} -- Validation

	validate_tag_text (a_text: !STRING_32): !TUPLE [is_valid: BOOLEAN; reason: ?STRING_32]
			--
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
			if contract_tag_name_regex.matches (a_text.as_string_8) then
				Result := [True, Void]
			else
				Result := [False, ("The contract tag name is not a valid Eiffel identifier.").as_string_32]
			end
		end

feature {NONE} -- Event handlers

	on_valid_state_changed (a_is_valid: BOOLEAN)
			-- Called when the validation state changes.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
				-- Currently only `tag_text' is a validated contract
			if a_is_valid and then contract_editor.text_is_fully_loaded and then not contract_editor.text.is_empty then
				dialog_window_buttons.item (default_confirm_button).enable_sensitive
			else
				dialog_window_buttons.item (default_confirm_button).disable_sensitive
			end
		end

feature {NONE} -- Action handler

	on_ok
			-- Called when the OK button is pressed
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
			contract := [({!STRING_32}) #? tag_text.text, ({!STRING_32}) #? contract_editor.text.as_string_32]
		ensure then
			contract_attached: contract /= Void
		end

feature {TEXT_OBSERVER_MANAGER} -- Observer handler

	on_text_edited (a_directly_edited: BOOLEAN)
			-- <Precursor>
		do
			Precursor (a_directly_edited)

				-- For validation to update the buttons and so forth
			on_valid_state_changed (tag_text.is_valid)
		end

feature {NONE} -- Regular expression

	contract_tag_name_regex: !RX_PCRE_MATCHER
			-- Regular expression for contract tags
		once
			create Result.make
			Result.set_caseless (True)
			Result.compile ("^[a-z][a-z0-9_]*$")
		end

invariant
	contract_attached: (dialog_result = default_confirm_button and not is_shown) implies contract /= Void
	contract_tag_is_valid: contract /= Void implies not contract.tag.is_empty
	contract_tag_is_valid: contract /= Void implies not contract.contract.is_empty

;indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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
