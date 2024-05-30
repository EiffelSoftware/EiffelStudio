note
	description: "[
		A dialog to add a new creation procedure on a given class, and with set of attributes.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_COMPOSER_ADD_CREATOR_DIALOG

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
			if attached class_i.compiled_class as cc then
				class_c := cc
				if
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
			end
			make
		end

	class_i: CLASS_I

	class_c: detachable CLASS_C

	available_attributes: detachable STRING_TABLE [ATTRIBUTE_I]
			-- Attribute indexed by attribute name

feature {NONE} -- Building

	build_dialog_interface (a_container: EV_VERTICAL_BOX)
			-- <Precursor>
		local
			l_label: EV_LABEL
			l_vbox: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
			but_up, but_down: EV_BUTTON
			but_update_create: EV_CHECK_BUTTON
			but_type: EV_CHECK_BUTTON
		do
			a_container.set_padding ({ES_UI_CONSTANTS}.vertical_padding)

				-- creation procedure name
			--| [ make ]
			--| / Attributes /
			--| [X] att1 name | arg1 name
			--| [X] att2 name | arg2 name
			--| [X] att3 name | arg3 name
			--|

				-- Creator tag
			create l_vbox
			l_vbox.set_padding ({ES_UI_CONSTANTS}.label_vertical_padding)

			create l_label.make_with_text (interface_names.l_generate_creation_procedure_of_name)
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

					-- create clause			
			create but_update_create.make_with_text ({SHARED_LOCALE}.locale.translation_in_context ({STRING_32} "Update list of creators?", "composer"))

			but_update_create.enable_select
			l_vbox.extend (but_update_create); l_vbox.disable_item_expand (but_update_create)
			update_creator_list := True
			but_update_create.select_actions.extend (agent (cb: EV_CHECK_BUTTON)
					do
						update_creator_list := cb.is_selected
					end(but_update_create))

				-- Attributes
			create l_vbox
			l_vbox.set_padding ({ES_UI_CONSTANTS}.label_vertical_padding)

			create l_label.make_with_text (interface_names.l_generate_creation_procedure_of_name)
			auto_recycle (l_label)
			l_label.align_text_left
			l_vbox.extend (l_label)
			l_vbox.disable_item_expand (l_label)

			create attributes_grid
			attributes_grid.enable_single_row_selection
			attributes_grid.set_column_count_to (3)
			attributes_grid.column (1).set_title (interface_names.l_attributes)
			attributes_grid.column (2).set_title (interface_names.l_arguments)
			attributes_grid.column (3).set_title (interface_names.l_type)
			auto_recycle (attributes_grid)
			attributes_grid.set_minimum_size (450, 60)
			l_vbox.extend (attributes_grid)

			create hb
			hb.set_padding ({ES_UI_CONSTANTS}.Label_horizontal_padding)

			create but_up
			but_up.set_pixmap (stock_pixmaps.general_move_up_icon)
			hb.extend (but_up)
			hb.disable_item_expand (but_up)
			but_up.disable_sensitive

			create but_down
			but_down.set_pixmap (stock_pixmaps.general_move_down_icon)
			hb.extend (but_down)
			hb.disable_item_expand (but_down)
			but_down.disable_sensitive

			but_up.select_actions.extend (agent on_attributes_up (but_up, but_down))
			but_down.select_actions.extend (agent on_attributes_down (but_up, but_down))

			hb.extend (create {EV_CELL})

			create but_type.make_with_text ({SHARED_LOCALE}.locale.translation_in_context ({STRING_32} "Use anchor type?", "composer"))
			hb.extend (but_type)
			but_type.select_actions.extend (agent (cb: EV_CHECK_BUTTON)
					do
						set_use_anchor_types (cb.is_selected)
					end(but_type)
				)
			but_type.enable_select

			l_vbox.extend (hb); l_vbox.disable_item_expand (hb)

			a_container.extend (l_vbox)

			set_button_action_before_close (default_confirm_button, agent on_ok)

			attributes_grid.row_select_actions.extend (agent on_attributes_row_selected (?, but_up, but_down))
			attributes_grid.row_deselect_actions.extend (agent on_attributes_row_deselected (?, but_up, but_down))
		end

	on_after_initialized
			-- <Precursor>
		local
			vn: STRING_32
			arg_names: STRING_TABLE [ATTRIBUTE_I]
			ge: EV_GRID_EDITABLE_ITEM
			gcb: EV_GRID_CHECKABLE_LABEL_ITEM
			r: INTEGER
			row: EV_GRID_ROW
			att: ATTRIBUTE_I
			att_name: READABLE_STRING_32
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
			if attached available_attributes as tb then
				create arg_names.make_caseless (tb.count)
				across
					tb as ic
				loop
					att := ic.item
					vn := suggested_argument_name (att, arg_names)
					arg_names [vn] := att
				end
				attributes_grid.set_row_count_to (arg_names.count)
				r := 0
				across
					arg_names as ic
				loop
					att := ic.item
					r := r + 1
					row := attributes_grid.row (r)
					row.set_data (att)
					att_name := ic.item.feature_name_32
					create gcb.make_with_text (att_name)
					row.set_item (1, gcb)
					create ge.make_with_text (ic.key)
					ge.pointer_double_press_actions.extend (agent (i_ge: EV_GRID_EDITABLE_ITEM; i_x, i_y, i_button: INTEGER; i_x_tilt, i_y_tilt, i_pressure: DOUBLE; i_screen_x, i_screen_y: INTEGER)
							do
								if i_button = {EV_POINTER_CONSTANTS}.left then
									i_ge.activate
								end
							end(ge, ?,?,?,?,?,?,?,?)
						)
					row.set_item (2, ge)
					if use_anchor_type then
						create ge.make_with_text ({STRING_32} "like " + att_name)
					else
						create ge.make_with_text (suggested_argument_type (att))
						ge.set_data (ge.text)
					end
					ge.pointer_double_press_actions.extend (agent (i_ge: EV_GRID_EDITABLE_ITEM; i_x, i_y, i_button: INTEGER; i_x_tilt, i_y_tilt, i_pressure: DOUBLE; i_screen_x, i_screen_y: INTEGER)
							do
								if i_button = {EV_POINTER_CONSTANTS}.left then
									i_ge.activate
								end
							end(ge, ?,?,?,?,?,?,?,?)
						)
					row.set_item (3, ge)
					gcb.set_is_checked (True)
				end
			else
				attributes_grid.set_row_count_to (0)
			end
		end

	suggested_argument_name (att: ATTRIBUTE_I; arg_names: STRING_TABLE [ATTRIBUTE_I]): STRING_32
		do
				-- Default convention: first letter
				-- if conflicted: 3 first letters
				-- and if conflicted: "a_" + attrib name
			Result := att.feature_name_32.head (1)
			if arg_names.has (Result) or is_known_feature_name (Result) then
				Result := att.feature_name_32.head (3)
				if arg_names.has (Result) or is_known_feature_name (Result) then
					Result := {STRING_32} "a_" + att.feature_name_32
				end
			end
		end

	suggested_argument_type (att: ATTRIBUTE_I): STRING_32
		do
			create Result.make_from_string_general (att.type.name)
			Result.replace_substring_all ("?", "detachable ")
			Result.replace_substring_all ("!", "")
		end

	is_known_feature_name (fn: READABLE_STRING_GENERAL): BOOLEAN
		do
			if attached class_c as cc then
				Result := cc.feature_named_32 (fn) /= Void
			end
		end

feature -- Access

	values: detachable TUPLE [creator_name: STRING_32; attributes: detachable STRING_TABLE [ATTRIBUTE_I]; type_names: detachable STRING_TABLE [READABLE_STRING_32]]

	update_creator_list: BOOLEAN
			-- Update the list of creators?

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

	creator_name_text: ES_VALIDATING_WRAPPED_WIDGET
			-- Create name text field

	attributes_grid: ES_GRID
			-- Grid used to edit the attributes

feature {NONE} -- Event

	use_anchor_type: BOOLEAN

	set_use_anchor_types (v: BOOLEAN)
		local
			r,n: INTEGER
		do
			if use_anchor_type /= v then
				use_anchor_type := v
				if attached attributes_grid as g then
					from
						r := 1
						n := g.row_count
					until
						r > n
					loop
						if
							attached g.row (r) as row and then
							attached {ATTRIBUTE_I} row.data as att
						then
							if attached {EV_GRID_EDITABLE_ITEM} row.item (3) as ged then
								if use_anchor_type then
									ged.set_data (ged.text)
									ged.set_text ({STRING_32} "like " + att.feature_name_32)
								else
									if attached {READABLE_STRING_GENERAL} ged.data as txt then
										ged.set_text (txt)
									else
										ged.set_text (suggested_argument_type (att))
										ged.set_data (ged.text)
									end
								end
							end
						end
						r := r + 1
					end
				end
			end
		end

	update_attributes_buttons (a_row: EV_GRID_ROW; a_but_up, a_but_down: EV_BUTTON; a_is_selected: BOOLEAN)
		do
			if
				a_is_selected and then
				not a_row.is_destroyed and then
			 	attached a_row.parent as g
			then
				if a_row.index > 1 then
					a_but_up.enable_sensitive
				else
					a_but_up.disable_sensitive
				end
				if a_row.index < g.row_count then
					a_but_down.enable_sensitive
				else
					a_but_down.disable_sensitive
				end
			else
				a_but_up.disable_sensitive
				a_but_down.disable_sensitive
			end
		end

	on_attributes_row_selected (a_row: EV_GRID_ROW; a_but_up, a_but_down: EV_BUTTON)
		do
			update_attributes_buttons (a_row, a_but_up, a_but_down, True)
		end

	on_attributes_row_deselected (a_row: EV_GRID_ROW; a_but_up, a_but_down: EV_BUTTON)
		do
			update_attributes_buttons (a_row, a_but_up, a_but_down, False)
		end

	on_attributes_up (a_but_up, a_but_down: EV_BUTTON)
		do
			if
				attached attributes_grid.selected_rows as l_rows and then
				attached l_rows.first as l_row
			then
				attributes_grid.move_row (l_row.index, l_row.index - 1)
				update_attributes_buttons (l_row, a_but_up, a_but_down, True)
			end
		end

	on_attributes_down (a_but_up, a_but_down: EV_BUTTON)
		do
			if
				attached attributes_grid.selected_rows as l_rows and then
				attached l_rows.first as l_row
			then
				attributes_grid.move_row (l_row.index, l_row.index + 2)
				update_attributes_buttons (l_row, a_but_up, a_but_down, True)
			end
		end

feature {NONE} -- Validation

	validate_creator_name_text (a_text: STRING_32): TUPLE [is_valid: BOOLEAN; reason: detachable STRING_32]
			--
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		do
			if a_text.is_empty or else creator_name_regex.matches ({UTF_CONVERTER}.string_32_to_utf_8_string_8 (a_text)) then
				if is_known_feature_name (a_text) then
					Result := [False, {SHARED_LOCALE}.locale.translation_in_context ({STRING_32} "The creation procedure name is already used.", "composer")]
				else
					Result := [True, Void]
				end
			else
				Result := [False, {SHARED_LOCALE}.locale.translation_in_context ({STRING_32} "The creation procedure name is not a valid Eiffel procedure name.", "composer")]
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
			attribs: STRING_TABLE [ATTRIBUTE_I]
			typenames: STRING_TABLE [READABLE_STRING_32]
			n,r: INTEGER
			vn, tn: READABLE_STRING_32
		do
			check not_error_handler_has_error: not error_handler.has_error end
			from
				r := 1
				n := attributes_grid.row_count
				create attribs.make (n)
				create typenames.make (n)
			until
				r > n
			loop
				if
					attached attributes_grid.row (r) as l_row and then
					attached {ATTRIBUTE_I} l_row.data as att
				then
					vn := Void
					tn := Void
					if
						attached {EV_GRID_CHECKABLE_LABEL_ITEM} l_row.item (1) as gcb and then
						gcb.is_checked
					then
						if attached {EV_GRID_EDITABLE_ITEM} l_row.item (2) as ged then
							vn := ged.text
						end
						if attached {EV_GRID_EDITABLE_ITEM} l_row.item (3) as ged then
							tn := ged.text
						end
					end
					if vn /= Void then
						attribs [vn] := att
						typenames [vn] := tn
					end
				end
				r := r + 1
			end
			values := [creator_name_text.text, attribs, typenames]
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

