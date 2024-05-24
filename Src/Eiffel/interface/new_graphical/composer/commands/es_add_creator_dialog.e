note
	description: "[
		A dialog to add a new creation procedure on a given class, and with set of attributes.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_ADD_CREATOR_DIALOG

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
	make_with_class

feature {NONE} -- Initialization

	make_with_class (a_class_i: CLASS_I)
		local
			l_attribs: like available_attributes
		do
			class_i := a_class_i
			available_attributes := Void
			if
				attached class_i.compiled_class as cc and then
				attached cc.feature_table.features as lst
			then
				create l_attribs.make (10)
				across
					lst as ic
				loop
					if attached {ATTRIBUTE_I} ic.item as l_attrib_i then
						l_attribs [l_attrib_i.feature_name_32] := l_attrib_i
					end
				end
				if not l_attribs.is_empty then
					available_attributes := l_attribs
				end
			end
			make
		end

	class_i: CLASS_I

	available_attributes: detachable STRING_TABLE [ATTRIBUTE_I]
			-- Attribute indexed by attribute name

feature {NONE} -- Building

	build_dialog_interface (a_container: EV_VERTICAL_BOX)
			-- <Precursor>
		local
			l_label: EV_LABEL
			l_vbox: EV_VERTICAL_BOX
			l_border: ES_BORDERED_WIDGET [EV_WIDGET]
		do
			a_container.set_padding ({ES_UI_CONSTANTS}.vertical_padding)

				-- creation procedure name
			--| [ make ]
			--| / Attributes /
			--| [x]
			--| [x]
			--| [x]
			--|

				-- Creator tag
			create l_vbox
			l_vbox.set_padding ({ES_UI_CONSTANTS}.label_vertical_padding)

			create l_label.make_with_text ("Creation procedure name:")
			auto_recycle (l_label)
			l_label.align_text_left
			l_vbox.extend (l_label)
			l_vbox.disable_item_expand (l_label)

			create creator_name_text.make (create {EV_TEXT_FIELD}, agent validate_creator_name_text)
			creator_name_text.text_field.set_font (preferences.editor_data.editor_font_preference.value)
			suppress_confirmation_key_close (creator_name_text.text_field)
			auto_recycle (creator_name_text)
			register_action (creator_name_text.valid_state_changed_actions, agent on_valid_state_changed)
			l_vbox.extend (creator_name_text)
			l_vbox.disable_item_expand (creator_name_text)
			a_container.extend (l_vbox)
			a_container.disable_item_expand (l_vbox)

				-- Attributes
			create l_vbox
			l_vbox.set_padding ({ES_UI_CONSTANTS}.label_vertical_padding)

			create l_label.make_with_text ("Attributes:")
			auto_recycle (l_label)
			l_label.align_text_left
			l_vbox.extend (l_label)
			l_vbox.disable_item_expand (l_label)


			create attributes_editor.make_with_text ("..")
			auto_recycle (attributes_editor)
			attributes_editor.set_minimum_size (450, 60)
			create l_border.make (attributes_editor)
			auto_recycle (l_border)
			l_vbox.extend (l_border)

			create l_label.make_with_text ("Note: one line per argument%N following the format 'attribute_name | argument_name'%NThe order follows the order of the line")
			auto_recycle (l_label)
			l_label.align_text_left
			l_vbox.extend (l_label)
			l_vbox.disable_item_expand (l_label)
			a_container.extend (l_vbox)

			propagate_action (attributes_editor, agent suppress_confirmation_key_close, Void)

			set_button_action_before_close (default_confirm_button, agent on_ok)
		end

	on_after_initialized
			-- <Precursor>
		local
			s,vn: STRING_32
			arg_names: STRING_TABLE [ATTRIBUTE_I]
		do
			Precursor

				-- Set default tag name
			creator_name_text.set_text (create {STRING_32}.make_from_string ("make"))
			creator_name_text.validate
			register_kamikaze_action (show_actions, agent
				do
					creator_name_text.text_field.set_focus
					if not creator_name_text.text_field.text.is_empty then
						creator_name_text.text_field.select_all
					end
				end)

				-- Set default attributes
			create s.make_empty
			if attached available_attributes as tb then
				create arg_names.make_caseless (tb.count)
				across
					tb as ic
				loop
					if attached {ATTRIBUTE_I} ic.item as att then
							-- Default convention: first letter
							-- if conflicted: 3 first letters
							-- and if conflicted: "a_" + attrib name
						vn := att.feature_name_32.head (1)
						if arg_names.has (vn) then
							vn := att.feature_name_32.head (3)
							if arg_names.has (vn) then
								vn := {STRING_32} "a_" + att.feature_name_32
							end
						end
						s.append (att.feature_name_32)
						s.append (" | ")
						s.append (vn)
						s.append_character ('%N')
						arg_names [vn] := att
					end
				end
			end
			attributes_editor.set_text (s)
		end

feature -- Access

	values: detachable TUPLE [creator_name: STRING_32; attributes: detachable STRING_TABLE [ATTRIBUTE_I]]

feature -- Dialog access

	icon: EV_PIXEL_BUFFER
			-- <Precursor>
		once
			Result := stock_pixmaps.icon_buffer_with_overlay (stock_pixmaps.feature_creators_icon_buffer, stock_pixmaps.overlay_new_icon_buffer, 0, 0)
		end

	title: STRING_32
			-- <Precursor>
		do
			Result := "Add New Creation Procedure"
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

	creator_name_text: ES_VALIDATING_WRAPPED_WIDGET
			-- Create name text field

	attributes_editor: EV_TEXT
			-- Editor use to edit the attributes

feature {NONE} -- Validation

	validate_creator_name_text (a_text: STRING_32): TUPLE [is_valid: BOOLEAN; reason: detachable STRING_32]
			--
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
			if a_text.is_empty or else creator_name_regex.matches ({UTF_CONVERTER}.string_32_to_utf_8_string_8 (a_text)) then
				Result := [True, Void]
			else
				Result := [False, ("The creation procedure name is not a valid Eiffel procedure name.").as_string_32]
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
				not creator_name_text.text.is_empty
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
		local
--			l_error: ES_ERROR_PROMPT
			l_str: STRING_32
			attribs: STRING_TABLE [ATTRIBUTE_I]
			pos: INTEGER
			arg_name, att_name: STRING_32
		do
			check not_error_handler_has_error: not error_handler.has_error end
			l_str := attributes_editor.text
			if attached l_str.split ('%N') as l_lines then
				create attribs.make (l_lines.count)
				across
					l_lines as ic
				loop
					if attached {STRING_32} ic.item as line then
						pos := line.index_of ('|', 1)
						if pos > 0 then
							att_name := line.head (pos - 1)
							att_name.adjust

							arg_name := line.substring (pos + 1, line.count)
							arg_name.adjust
							if
								attached available_attributes as l_available_attributes and then
								attached l_available_attributes [att_name] as att
							then
								attribs [arg_name] := att
							end
						end
					end
				end
			end
			values := [creator_name_text.text, attribs]
			error_handler.wipe_out
		ensure then
			values_attached: not is_close_vetoed implies values /= Void
			not_error_handler_has_error: not error_handler.has_error
		end

feature {NONE} -- Regular expression

	creator_name_regex: RX_PCRE_MATCHER
			-- Regular expression for creator names
		once
			create Result.make
			Result.set_caseless (True)
			Result.compile ("^[a-z][a-z0-9_]*$")
		end

invariant
	values_attached: (dialog_result = default_confirm_button and not is_shown) implies values /= Void
	creator_name_is_valid: values /= Void implies not values.creator_name.is_empty

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

