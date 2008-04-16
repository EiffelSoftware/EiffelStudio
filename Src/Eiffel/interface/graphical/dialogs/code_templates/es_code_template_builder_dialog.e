indexing
	description: "[
		A dialog use to recieve user inputs in order to populate a specified code template.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ES_CODE_TEMPLATE_BUILDER_DIALOG

inherit
	ES_DIALOG
		rename
			make as make_dialog
		redefine
			on_before_initialize,
			on_after_initialized,
			on_shown,
			is_size_and_position_remembered
		end

create
	make

feature {NONE} -- Initialization

	make (a_template: !like code_template)
			-- Initialize dialog using a specific development window
		require
			a_template_is_interface_usable: a_template.is_interface_usable
		do
			code_template := a_template
			make_dialog
		ensure
			code_template_set: code_template = a_template
		end

	build_dialog_interface (a_container: EV_VERTICAL_BOX)
			-- <Precursor>
		local
			l_template: !like code_template
			l_definition: !CODE_TEMPLATE_DEFINITION
			l_declarations: !DS_BILINEAR [CODE_DECLARATION]
			l_cursor: DS_BILINEAR_CURSOR [CODE_DECLARATION]
			l_padding: !EV_CELL
			l_description: !EVS_LABEL
			l_template_description: !STRING_32
			l_code_result_label: !EV_LABEL
			l_code_result_view: !like code_result_view
			l_declaration_fields: !like declaration_text_fields
		do
			a_container.set_padding ({ES_UI_CONSTANTS}.vertical_padding)

			l_template := code_template
			l_definition := l_template.definition

				-- Template description
			l_template_description := l_definition.metadata.description
			if not l_template_description.is_empty then
				create l_description.make
				l_description.set_is_text_wrapped (True)
				l_description.set_text (l_template_description)
				a_container.extend (l_description)
				a_container.disable_item_expand (l_description)
			end

				-- Padding
			create l_padding
			l_padding.set_minimum_height ({ES_UI_CONSTANTS}.vertical_padding)
			a_container.extend (l_padding)
			a_container.disable_item_expand (l_padding)

				-- Declaration fields
			l_declarations := l_definition.declarations.items
			l_cursor := l_declarations.new_cursor
			if not l_declarations.is_empty then
				l_declaration_fields := declaration_text_fields

				from l_cursor.start until l_cursor.after loop
					if not l_cursor.item.is_built_in and then {l_literal: !CODE_LITERAL_DECLARATION} l_cursor.item and then l_literal.is_editable then
						if not l_declaration_fields.has (l_literal.id) then
							build_declaration_line_interface (l_literal, a_container)
						end
					end
					l_cursor.forth
				end
			end

				-- Padding
			create l_padding
			l_padding.set_minimum_height ({ES_UI_CONSTANTS}.vertical_padding)
			a_container.extend (l_padding)
			a_container.disable_item_expand (l_padding)

				-- Code result
			create l_code_result_label.make_with_text (interface_names.l_code_results)
			l_code_result_label.align_text_left
			a_container.extend (l_code_result_label)
			a_container.disable_item_expand (l_code_result_label)

				-- Template result
			create l_code_result_view
			l_code_result_view.current_class.set_scanner (create {EDITOR_EIFFEL_SCANNER}.make)
			l_code_result_view.disable_line_numbers
			l_code_result_view.widget.set_minimum_size (400, 100)
			l_code_result_view.widget.set_border_width (1)
			l_code_result_view.widget.set_background_color (colors.stock_colors.color_3d_shadow)
			a_container.extend (l_code_result_view.widget)
			code_result_view := l_code_result_view
		end

	build_declaration_line_interface (a_declaration: !CODE_LITERAL_DECLARATION; a_container: EV_VERTICAL_BOX)
			-- TODO
		require
			not_a_declaration_is_built_in: not a_declaration.is_built_in
			a_declaration_is_editable: a_declaration.is_editable
			not_a_container_is_destroyed: not a_container.is_destroyed
			not_declaration_text_fields_has_id: not declaration_text_fields.has (a_declaration.id)
		local
			l_label: EV_LABEL
			l_edit: !EV_TEXT_FIELD
			l_text: STRING_32
			l_vbox: EV_VERTICAL_BOX
		do
			create l_vbox
			l_vbox.set_padding ({ES_UI_CONSTANTS}.label_vertical_padding)

				-- Create description
			create l_label
			l_label.align_text_left
			l_text := a_declaration.description
			if l_text.is_empty then
				l_text := a_declaration.id.as_string_32 + interface_names.l_code_declarations_value.twin
				l_text.prune_all_trailing ('.')
			else
				l_text ?= l_text.twin
			end
			if {l_object: CODE_OBJECT_DECLARATION} a_declaration then
				l_text.append_character (' ')
				l_text.append (interface_names.l_code_declarations_conform (l_object.must_conform_to))
			end
			l_text.append (":")
			l_label.set_text (l_text)

			l_vbox.extend (l_label)
			l_vbox.disable_item_expand (l_label)

				-- Create field
			l_text := a_declaration.default_value
			if l_text.is_empty then
					-- Use ID as the default value.
				l_text := a_declaration.id
			end
			l_edit := create_declaration_text_widget (a_declaration)
			l_edit.set_text (l_text)
			l_edit.set_font (preferences.editor_data.editor_font_preference.value)
			register_action (l_edit.change_actions, agent on_text_changed (l_edit, a_declaration.id))
			register_action (l_edit.focus_in_actions, agent on_text_focused (l_edit, a_declaration.id))
			suppress_confirmation_key_close (l_edit)
			l_vbox.extend (l_edit)
			l_vbox.disable_item_expand (l_edit)

			a_container.extend (l_vbox)
			a_container.disable_item_expand (l_vbox)

			declaration_text_fields.force_last (l_edit, a_declaration.id)
		ensure
			declaration_text_fields_has_a_declaration: declaration_text_fields.has (a_declaration.id)
		end

	on_before_initialize
			-- <Precursor>
		do
			create declaration_text_fields.make_default
			create edited_declaration_text_fields.make_default
			create code_result.make_empty
			Precursor
		end

	on_after_initialized
			-- <Precusor>
		do
			Precursor
			update_code_result
		end

feature -- Access

	code_result: !STRING_32
			-- Current result of user input

feature {NONE} -- Access

	code_template: !CODE_TEMPLATE
			-- The code template used to build the UI.

	frozen code_symbol_table: !CODE_SYMBOL_TABLE
			-- Symbol table used to evaluate the code template.
		do
			if internal_code_symbol_table = Void then
				Result := create_code_symbol_table (code_template.definition)
				internal_code_symbol_table := Result
			else
				Result ?= internal_code_symbol_table
			end
		ensure
			result_consistent: Result = code_symbol_table
		end

feature -- Dialog access

	icon: !EV_PIXEL_BUFFER
			-- <Precursor>
		do
			Result := stock_pixmaps.general_document_icon_buffer
		end

	title: !STRING_32
			-- <Precursor>
		local
			l_title: !STRING_32
			l_title_extension: STRING_32
		do
			l_title_extension := interface_names.t_code_template_evaluator.as_string_32
			l_title := code_template.definition.metadata.title
			if not l_title.is_empty then
				create Result.make (l_title.count + l_title_extension.count + 3)
				Result.append (l_title)
				Result.append (" - ")
			else
				create Result.make (l_title_extension.count)
			end
			Result.append (l_title_extension)
		end

	buttons: !DS_SET [INTEGER]
			-- <Precursor>
		once
			Result ?= dialog_buttons.ok_cancel_buttons
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

feature {NONE} -- Status report

	is_size_and_position_remembered: BOOLEAN
			-- <Precursor>
		do
			Result := False
		end

feature {NONE} -- Helpers

	frozen template_renderer: !CODE_TEMPLATE_STRING_RENDERER
			-- Renderer used for evaluating the code template.
		require
			is_interface_usable: is_interface_usable
		do
			if internal_template_renderer = Void then
				Result := create_template_renderer
				auto_recycle (Result)
				internal_template_renderer := Result
			else
				Result ?= internal_template_renderer
			end
		ensure
			result_consistent: Result = template_renderer
		end

feature {NONE} -- Basic operations

	update_code_result
			-- Updates the code result
		require
			is_interface_usable: is_interface_usable
			is_initialized: is_initialized
		local
			l_renderer: !like template_renderer
		do
			l_renderer := template_renderer
			l_renderer.render_template (code_template, code_symbol_table)
			create code_result.make_from_string (l_renderer.code)
			code_result_view.load_text (code_result)

		ensure
			code_result_view_set: code_result_view.text.as_string_32.is_equal (code_result)
		end

feature {NONE} -- User interface elements

	declaration_text_fields: !DS_HASH_TABLE [!EV_TEXT_FIELD, !STRING]
			-- A table of text fields for a code template's declarations indexed by a declaration id.
			--
			-- Key: Declaration ID.
			-- Value: A text field.

	edited_declaration_text_fields: !DS_HASH_SET [!STRING]
			-- The set of user edited declaration fields

	code_result_view: !SELECTABLE_TEXT_PANEL
			-- Widget containing the result of the evaluated code template

feature {NONE} -- Action handlers

	on_shown
			-- <Precursor>
		local
			l_declarations: DS_BILINEAR_CURSOR [CODE_DECLARATION]
			l_declaration_fields: !like declaration_text_fields
			l_focus_set: BOOLEAN
		do
			Precursor

				-- Set focus to first declaration field			
			l_declaration_fields := declaration_text_fields
			if not l_declaration_fields.is_empty then
				l_declarations := code_template.definition.declarations.items.new_cursor
				from l_declarations.start until l_declarations.after or l_focus_set loop
					if l_declaration_fields.has (l_declarations.item.id) then
						l_declaration_fields.item (l_declarations.item.id).set_focus
						l_focus_set := True
					end
					l_declarations.forth
				end
			end
			if not l_focus_set then
					-- No applicable declaration fields, set to the view
				code_result_view.set_focus
			end
		end

	on_text_changed (a_sender: !EV_TEXT_FIELD; a_id: !STRING)
			-- Called when the user changes the text variables
		require
			not_a_sender_is_destroyed: not a_sender.is_destroyed
			not_a_id_is_empty: not a_id.is_empty
		local
			l_table: !like code_symbol_table
			l_code_value: !CODE_SYMBOL_VALUE
		do
				-- Update the symbol table
			l_table := code_symbol_table

			check has_id: l_table.has_id (a_id) end
			if l_table.has_id (a_id) then
				l_code_value := l_table.item (a_id)
				if {l_value: !STRING_32} a_sender.text.as_string_32 then
					l_code_value.set_value (l_value)
				end
			end

			if not edited_declaration_text_fields.has (a_id) then
					-- Update the edited set
				edited_declaration_text_fields.force_last (a_id)
			end

				-- Refresh the code result text
			update_code_result
		end

	on_text_focused (a_sender: !EV_TEXT_FIELD; a_id: !STRING) is
			-- Called when the user focuses to a text field
		require
			not_a_sender_is_destroyed: not a_sender.is_destroyed
			not_a_id_is_empty: not a_id.is_empty
		do
			if not edited_declaration_text_fields.has (a_id) then
					-- Select the entire text for easy replacement
				a_sender.set_caret_position (a_sender.text.count)
				a_sender.select_all
			end
		end

feature {NONE} -- Factory

	create_code_symbol_table (a_template: !CODE_TEMPLATE_DEFINITION): !CODE_SYMBOL_TABLE
			-- Creates a symbol table for a given template.
		require
			is_interface_usable: is_interface_usable
			a_template_is_interface_usable: a_template.is_interface_usable
		local
			l_builder: CODE_SYMBOL_TABLE_BUILDER
		do
			create l_builder.make (a_template)
			Result := l_builder.symbol_table
		end

	create_template_renderer: !CODE_TEMPLATE_STRING_RENDERER
			-- Creates a new template renderer for code template evaluation
		require
			is_interface_usable: is_interface_usable
		do
			create Result
		end

	create_declaration_text_widget (a_declaration: !CODE_DECLARATION): !EV_TEXT_FIELD
			-- Create a new text widget for a given code declaration
		require
			is_interface_usable: is_interface_usable
		do
			create Result
		end

feature {NONE} -- Internal implementation cache

	internal_template_renderer: ?like template_renderer
			-- Cached version of `template_renderer'
			-- Note: Do not use directly!

	internal_code_symbol_table: ?like code_symbol_table
			-- Cached version of `code_symbol_table'
			-- Note: Do not use directly!

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
