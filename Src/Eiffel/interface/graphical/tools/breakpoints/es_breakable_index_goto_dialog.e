note
	description: "Dialog to go to line related to breakable index"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_BREAKABLE_INDEX_GOTO_DIALOG

inherit
	ES_DIALOG
		redefine
			on_shown,
			on_handle_key
		end

create
	make_with_editor

convert
	dialog: {EV_DIALOG}

feature {NONE} -- Initialization

	make_with_editor (a_editor: like editor)
			-- Make Current dialog with `a_editor'
		do
			editor := a_editor
			get_breakable_indexes
			make
		end

	build_dialog_interface (a_container: EV_VERTICAL_BOX)
			-- Builds the dialog's user interface.
			--
			-- `a_container': The dialog's container where the user interface elements should be extended
		local
			okb, cancelb: EV_BUTTON
		do
				-- Create widgets.
			create breakable_index_spin.make_with_value_range (1 |..| upper_breakable_indexes)
			create label.make_with_text (Interface_names.l_breakable_indexes_range (upper_breakable_indexes))
			create okb.make_with_text (Interface_names.b_go_to)
			create cancelb.make_with_text (Interface_names.b_Cancel)

			go_button := okb

				-- Set widget properties.
			breakable_index_spin.enable_sensitive
			breakable_index_spin.set_value (current_breakable_index.max (1).min (upper_breakable_indexes))

			a_container.extend (label)
			a_container.disable_item_expand (label)
			a_container.extend (breakable_index_spin)
			a_container.disable_item_expand (breakable_index_spin)

				-- Set up actions.
			set_button_action_before_close (dialog_buttons.ok_button, agent on_ok)
			set_button_action_before_close (dialog_buttons.cancel_button, agent on_cancel)
--			breakable_index_spin.key_press_actions.extend (agent key_pressed_on_spin)
			breakable_index_spin.change_actions.extend (agent on_value_changed (?))
			breakable_index_spin.text_change_actions.extend (agent on_value_changed (-1))
		end

feature -- Access

	editor: EB_CLICKABLE_EDITOR
			-- Editor to search

	label: EV_LABEL
			-- Label

	go_button: EV_BUTTON
			-- "Goto" button

	upper_breakable_indexes: INTEGER
			-- Upper value for breakable index

	current_breakable_index: INTEGER
			-- Breakable index related to current line

	breakable_indexes: detachable ARRAY [INTEGER]
			-- Editor's lines indexed by breakable indexes

	breakable_index_spin: EV_SPIN_BUTTON
			-- Spin button that indicates the breakable index

feature -- Actions

	on_cancel
			-- Close `dialog' without doing anything.
		do
		end

	on_ok
			-- Close `dialog' without doing anything.
		do
			goto_line
		end

feature {NONE} -- Implementation

	on_shown
			-- Called once the foundation widget has been shown.
		do
			breakable_index_spin.set_focus
			breakable_index_spin.select_all
		end

	get_breakable_indexes
			-- Get editor's lines indexed by breakable indexes
		local
			i, c: INTEGER
			l_breakable_indexes: like breakable_indexes
		do
			if
				not editor.is_empty and then
				attached {CLICKABLE_TEXT} editor.text_displayed as ftxt
			then
				c := ftxt.current_line_number
				from
					i := ftxt.number_of_lines
				until
					i < 1
				loop
					if
						attached {EIFFEL_EDITOR_LINE} ftxt.line (i) as l_line and then
						attached {EDITOR_TOKEN_BREAKPOINT} l_line.breakpoint_token as l_bp and then
						attached {BREAKABLE_STONE} l_bp.pebble as l_stone
					then
						if l_breakable_indexes = Void then
							check upper_breakable_indexes = 0 end
							upper_breakable_indexes := l_stone.index
							create l_breakable_indexes.make_filled (0, 1, upper_breakable_indexes)
							breakable_indexes := l_breakable_indexes
						end
						l_breakable_indexes.put (i, l_stone.index)
						if i <= c then
							current_breakable_index := l_stone.index
							c := 0
						end
					end
					i := i - 1
				end
			end
		end

	goto_line
			-- Goto line
		local
			bi, li: INTEGER
		do
			if not editor.is_empty then
				bi := breakable_index_spin.value
				if attached breakable_indexes.valid_index (bi) then
					li := breakable_indexes.item (bi)
					if 1 <= li and li <= editor.number_of_lines then
						editor.scroll_to_start_of_line_when_ready_if_top (li, 1, True, False)
					end
				end
			end
		end

	on_handle_key (a_key: EV_KEY; a_alt: BOOLEAN; a_ctrl: BOOLEAN; a_shift: BOOLEAN; a_released: BOOLEAN): BOOLEAN
			-- Called when the tool recieve a key event
			--
			-- `a_key': The key pressed.
			-- `a_alt': True if the ALT key was pressed; False otherwise
			-- `a_ctrl': True if the CTRL key was pressed; False otherwise
			-- `a_shift': True if the SHIFT key was pressed; False otherwise
			-- `a_released': True if the key event pertains to the release of a key, False to indicate a press.
			-- `Result': True to indicate the key was handled
			-- (export status {NONE})
			-- Key was pressed in line number text field box
		do
			if not a_ctrl and a_key.code = {EV_KEY_CONSTANTS}.key_enter and then breakable_index_spin.text.is_integer then
				go_button.enable_sensitive
				Result := True
				on_dialog_button_pressed (goto_button_id)
			end
		end

	on_value_changed (a_value: INTEGER)
			-- Text field changed
		local
			i: INTEGER
		do
			if breakable_index_spin.text.is_integer then
				i := breakable_index_spin.text.to_integer
				if i >= 1 and then i <= editor.number_of_lines then
					go_button.enable_sensitive
				else
					go_button.disable_sensitive
				end
			else
				go_button.disable_sensitive
			end
		end

feature -- Access

	icon: EV_PIXEL_BUFFER
			-- The dialog's icon
		do
			Result := stock_pixmaps.general_dialog_icon_buffer
		end

	title: STRING_32
			-- The dialog's title
		do
			Result := interface_names.t_go_to_breakable
		end

	buttons: DS_SET [INTEGER]
			-- Set of button id's for dialog
			-- Note: Use {ES_DIALOG_BUTTONS} or `dialog_buttons' to determine the id's correspondance.
		once
			Result := dialog_buttons.ok_cancel_buttons
		end

	goto_button_id: INTEGER
		do
			Result := dialog_buttons.ok_button
		end

	default_button: INTEGER
			-- The dialog's default action button
		do
			Result := dialog_buttons.cancel_button
		end

	default_cancel_button: INTEGER
			-- The dialog's default cancel button
		do
			Result := dialog_buttons.cancel_button
		end

	default_confirm_button: INTEGER
			-- The dialog's default confirm button		
		do
			Result := dialog_buttons.cancel_button
		end

note
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
