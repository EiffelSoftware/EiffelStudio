note
	description: "[
		A dialog to add a new setter procedure for a given feature.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_COMPOSER_ADD_FEATURE_SETTER_DIALOG

inherit
	ES_DIALOG
		redefine
			on_after_initialized
		end

--inherit {NONE}
	SHARED_ERROR_HANDLER
		export
			{NONE} all
		end

create
	make_with_feature

feature {NONE} -- Initialization

	make_with_feature (a_feature_i: FEATURE_I)
		do
			feature_i := a_feature_i
			make
		end

	feature_i: FEATURE_I

feature {NONE} -- Building

	build_dialog_interface (a_container: EV_VERTICAL_BOX)
			-- <Precursor>
		local
			l_label: EV_LABEL
			l_vbox: EV_VERTICAL_BOX
			but_pre, but_post: EV_CHECK_BUTTON
		do
			a_container.set_padding ({ES_UI_CONSTANTS}.vertical_padding)

				-- Creator tag
			create l_vbox
			l_vbox.set_padding ({ES_UI_CONSTANTS}.label_vertical_padding)

			create l_label.make_with_text (interface_names.f_composer_add_setter)
			auto_recycle (l_label)
			l_label.align_text_left
			l_vbox.extend (l_label)
			l_vbox.disable_item_expand (l_label)

			create setter_name_text.make (create {EV_TEXT_FIELD}, agent validate_setter_name_text)
			setter_name_text.text_field.set_font (preferences.editor_data.editor_font_preference.value)
			suppress_confirmation_key_close (setter_name_text.text_field)
			auto_recycle (setter_name_text)
			register_action (setter_name_text.valid_state_changed_actions, agent on_valid_state_changed)
			l_vbox.extend (setter_name_text)
			l_vbox.disable_item_expand (setter_name_text)

			create but_pre.make_with_text ("Add preconditions?")
			l_vbox.extend (but_pre)
			l_vbox.disable_item_expand (but_pre)
			but_pre.select_actions.extend (agent (i_cb: EV_CHECK_BUTTON)
					do
						include_preconditions := i_cb.is_selected
					end(but_pre))
			but_pre.enable_select

			create but_post.make_with_text ("Add postconditions?")
			l_vbox.extend (but_post)
			l_vbox.disable_item_expand (but_post)
			but_post.select_actions.extend (agent (i_cb: EV_CHECK_BUTTON)
					do
						include_postconditions := i_cb.is_selected
					end(but_post))
			but_post.enable_select

--			l_vbox.extend (create {EV_CELL})

			a_container.extend (l_vbox)
			a_container.disable_item_expand (l_vbox)


			set_button_action_before_close (default_confirm_button, agent on_ok)
		end

	on_after_initialized
			-- <Precursor>
		do
			Precursor
			setter_name_text.set_text ({STRING_32} "set_" + feature_i.feature_name_32)
		end

	is_known_feature_name (fn: READABLE_STRING_GENERAL): BOOLEAN
		do
			if attached feature_i.written_class as cc then
				Result := cc.feature_named_32 (fn) /= Void
			end
		end

feature -- Access

	setter_name: detachable STRING_32

	include_preconditions: BOOLEAN

	include_postconditions: BOOLEAN

	is_validated: BOOLEAN
		do
			Result := setter_name /= Void
		end

feature -- Dialog access

	icon: EV_PIXEL_BUFFER
			-- <Precursor>
		once
			Result := stock_pixmaps.icon_buffer_with_overlay (stock_pixmaps.feature_creators_icon_buffer, stock_pixmaps.overlay_new_icon_buffer, 0, 0)
		end

	title: STRING_32
			-- <Precursor>
		do
			Result := interface_names.f_composer_add_creator
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

	setter_name_text: ES_VALIDATING_WRAPPED_WIDGET
			-- Setter name text field

feature {NONE} -- Validation

	validate_setter_name_text (a_text: STRING_32): TUPLE [is_valid: BOOLEAN; reason: detachable STRING_32]
			--
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
			if a_text.is_empty or else setter_name_regex.matches ({UTF_CONVERTER}.string_32_to_utf_8_string_8 (a_text)) then
				if is_known_feature_name (a_text) then
					Result := [False, {SHARED_LOCALE}.locale.translation_in_context ({STRING_32} "The setter procedure name is already used.", "composer")]
				else
					Result := [True, Void]
				end
			else
				Result := [False, {SHARED_LOCALE}.locale.translation_in_context ({STRING_32} "The setter procedure name is not a valid Eiffel procedure name.", "composer")]
			end
		end

feature {NONE} -- Event handlers

	on_valid_state_changed (a_is_valid: BOOLEAN)
			-- Called when the validation state changes.
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
				-- Currently only `creator_name_text' is a validated creator name
			if
				a_is_valid and then
				not setter_name_text.text.is_empty
			then
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
			check not_error_handler_has_error: not error_handler.has_error end
			setter_name := setter_name_text.text
			error_handler.wipe_out
		ensure then
			values_attached: not is_close_vetoed implies setter_name /= Void
			not_error_handler_has_error: not error_handler.has_error
		end

feature {NONE} -- Regular expression

	setter_name_regex: RX_PCRE_MATCHER
			-- Regular expression for setter names
		once
			create Result.make
			Result.set_caseless (True)
			Result.compile ("^[a-z][a-z0-9_]*$")
		end

invariant
	values_attached: (dialog_result = default_confirm_button and not is_shown) implies setter_name /= Void
	setter_name_is_valid: attached setter_name as inv_setter_name implies not inv_setter_name.is_empty

;note
	copyright:	"Copyright (c) 1984-2024, Eiffel Software"
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

