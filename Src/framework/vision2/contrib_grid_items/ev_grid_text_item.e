indexing
	description: "Objects that represents a text grid item."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
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

	initialize is
			-- Initialize.
		do
			Precursor
			ellipsis_actions.force_extend (agent show_dialog)
			enable_text_editing
		end

feature -- Status

	is_multiline_string: BOOLEAN

feature -- Access

	title: STRING_GENERAL
			-- Dialog's title

	ok_string: STRING_GENERAL
			-- [OK] button's text.

	reset_string: STRING_GENERAL
			-- [Reset] button's text.

	cancel_string: STRING_GENERAL
			-- [Cancel] button's text.

feature -- Change

	set_dialog_title (s: like title) is
			-- Set `title' to `s'
		do
			title := s
		end

	set_ok_string (s: like ok_string) is
			-- Set `ok_string' to `s'
		do
			ok_string := s
		end

	set_reset_string (s: like reset_string) is
			-- Set `reset_string' to `s'
		do
			reset_string := s
		end

	set_cancel_string (s: like cancel_string) is
			-- Set `cancel_string' to `s'
		do
			cancel_string := s
		end

	enable_multiline_string is
		do
			is_multiline_string := True
		end

	disable_multiline_string is
		do
			is_multiline_string := False
		end

feature {NONE} -- Agents

	show_dialog is
			-- Show text editor.
		require
			parented: is_parented
			parent_window: parent_window (parent) /= Void
			activated: is_activated
		local
			l_parent: EV_WINDOW

			l_dial: EV_DIALOG
			vb: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
			l_txt: EV_TEXT
			l_but_valid, l_but_cancel, l_but_reset: EV_BUTTON

			t: STRING_GENERAL
			l_title, l_ok_string, l_reset_string, l_cancel_string: STRING_GENERAL
		do
				--| Texts
			l_title := title
			if l_title = Void then
				l_title := "Edit Text"
			end
			l_ok_string := ok_string
			if l_ok_string = Void then
				l_ok_string := "OK"
			end
			l_reset_string := reset_string
			if l_reset_string = Void then
				l_reset_string := "Reset"
			end
			l_cancel_string := cancel_string
			if l_cancel_string = Void then
				l_cancel_string := "Cancel"
			end

				--| Parent's window	
			l_parent := parent_window (parent)
				-- Build dialog
			create l_dial
			create vb
			l_dial.extend (vb)
			create l_txt
			vb.extend (l_txt)
			create hb
			vb.extend (hb)
			vb.disable_item_expand (hb)
			create l_but_valid.make_with_text_and_action (l_ok_string, agent dialog_ok (l_dial, l_txt))
			create l_but_reset.make_with_text_and_action (l_reset_string, agent dialog_reset (l_dial, l_txt))
			create l_but_cancel.make_with_text_and_action (l_cancel_string, agent dialog_cancel (l_dial, l_txt))
			hb.extend (l_but_valid)
			hb.extend (l_but_reset)
			hb.extend (l_but_cancel)

			if text_field /= Void then
				t := text_field.text
			else
				t := text
			end
			if t /= Void then
				l_txt.set_text (t)
				l_txt.set_data (t)
			end

			l_dial.set_title (l_title)
			l_dial.set_default_cancel_button (l_but_cancel)
			l_dial.set_size (300, 200)
			enter_outter_edition
			l_dial.show_modal_to_window (l_parent)
			leave_outter_edition
			if text_field /= Void then
				text_field.set_focus
			end
		end

	dialog_ok (a_win: EV_WINDOW; a_txt: EV_TEXT) is
			-- Valid button clicked
		local
			t32: STRING_32
		do
			t32 := a_txt.text
			if not is_multiline_string then
				t32.replace_substring_all ("%N", "")
			end
			if text_field /= Void then
				text_field.set_text (t32)
			else
				set_text (t32)
			end

			a_win.destroy
		end

	dialog_reset (a_win: EV_WINDOW; a_txt: EV_TEXT) is
			-- Reset button clicked
		local
			t: STRING_GENERAL
		do
			t ?= a_txt.data
			if t = Void then
				t := text
			end
			a_txt.set_text (t)
		end

	dialog_cancel (a_win: EV_WINDOW; a_txt: EV_TEXT) is
			-- Cancel button clicked
		do
			a_win.destroy
		end

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
