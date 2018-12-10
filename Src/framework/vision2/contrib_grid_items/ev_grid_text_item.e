note
	description: "Objects that represents a text grid item."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_TEXT_ITEM

inherit
	EV_GRID_EDITABLE_ELLIPSIS_ITEM
		redefine
			initialize
		end

create
	default_create,
	make_with_text

feature {NONE} -- Initialization

	initialize
			-- Initialize.
		do
			Precursor
			ellipsis_actions.extend (agent show_dialog)
			enable_text_editing
		end

feature -- Status

	is_multiline_string: BOOLEAN

feature -- Access

	dialog_title: detachable STRING_GENERAL
			-- Dialog's title

	ok_button_string: detachable STRING_GENERAL
			-- [OK] button's text.

	reset_button_string: detachable STRING_GENERAL
			-- [Reset] button's text.

	cancel_button_string: detachable STRING_GENERAL
			-- [Cancel] button's text.

feature -- Change

	set_dialog_title (s: like dialog_title)
			-- Set `dialog_title' to `s'
		do
			dialog_title := s
		end

	set_ok_button_string (s: like ok_button_string)
			-- Set `ok_button_string' to `s'
		do
			ok_button_string := s
		end

	set_reset_button_string (s: like reset_button_string)
			-- Set `reset_button_string' to `s'
		do
			reset_button_string := s
		end

	set_cancel_button_string (s: like cancel_button_string)
			-- Set `cancel_button_string' to `s'
		do
			cancel_button_string := s
		end

	enable_multiline_string
		do
			is_multiline_string := True
		end

	disable_multiline_string
		do
			is_multiline_string := False
		end

feature {NONE} -- Agents

	show_dialog
			-- Show text editor.
		require
			parented: is_parented
			parent_window: attached parent as rl_parent and then parent_window (rl_parent) /= Void
			activated: is_text_editing implies is_activated
		local
			l_dial: EV_DIALOG
			vb: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
			l_txt: EV_TEXT
			l_but_valid, l_but_cancel, l_but_reset: EV_BUTTON

			t: detachable STRING_GENERAL
			l_dialog_title, l_ok_button_string, l_reset_button_string, l_cancel_button_string: detachable STRING_GENERAL
		do
				--| Texts
			l_dialog_title := dialog_title
			if l_dialog_title = Void then
				l_dialog_title := "Edit Text"
			end
			l_ok_button_string := ok_button_string
			if l_ok_button_string = Void then
				l_ok_button_string := "OK"
			end
			l_reset_button_string := reset_button_string
			if l_reset_button_string = Void then
				l_reset_button_string := "Reset"
			end
			l_cancel_button_string := cancel_button_string
			if l_cancel_button_string = Void then
				l_cancel_button_string := "Cancel"
			end

				-- Build dialog
			create l_dial
			create vb
			l_dial.extend (vb)
			create l_txt
			vb.extend (l_txt)
			create hb
			vb.extend (hb)
			vb.disable_item_expand (hb)
			create l_but_valid.make_with_text_and_action (l_ok_button_string, agent dialog_ok (l_dial, l_txt))
			create l_but_reset.make_with_text_and_action (l_reset_button_string, agent dialog_reset (l_dial, l_txt))
			create l_but_cancel.make_with_text_and_action (l_cancel_button_string, agent dialog_cancel (l_dial, l_txt))
			hb.extend (l_but_valid)
			hb.extend (l_but_reset)
			hb.extend (l_but_cancel)

			if attached text_field as tf then
				t := tf.text
			else
				t := text
			end
			if t /= Void then
				l_txt.set_text (t)
				l_txt.set_data (t)
			end

			l_dial.set_title (l_dialog_title)
			l_dial.set_default_cancel_button (l_but_cancel)
			l_dial.set_size (300, 200)
			enter_outter_edition

				--| Parent's window	
			if
				attached parent as l_parent_grid and then
				attached parent_window (l_parent_grid) as l_parent
			then
				l_dial.show_modal_to_window (l_parent)
			else
				l_dial.show
			end
			leave_outter_edition
			if attached text_field as tf then
				tf.set_focus
			end
		end

	dialog_ok (a_win: EV_WINDOW; a_txt: EV_TEXT)
			-- Valid button clicked
		local
			t32: STRING_32
		do
			t32 := a_txt.text
			if not is_multiline_string then
				t32.replace_substring_all ("%N", "")
			end
			if attached text_field as tf then
				tf.set_text (t32)
			else
				set_text (t32)
			end

			a_win.destroy
		end

	dialog_reset (a_win: EV_WINDOW; a_txt: EV_TEXT)
			-- Reset button clicked
		do
			if attached {STRING_GENERAL} a_txt.data as t then
				a_txt.set_text (t)
			else
				a_txt.set_text (text)
			end
		end

	dialog_cancel (a_win: EV_WINDOW; a_txt: EV_TEXT)
			-- Cancel button clicked
		do
			a_win.destroy
		end

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
