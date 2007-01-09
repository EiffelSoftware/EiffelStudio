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

	is_dialog_open: BOOLEAN
			-- Is the extended dialog open?

	is_multiline_string: BOOLEAN

feature -- Change

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
			popup_window: popup_window /= Void
			activated: is_activated
		local
			l_parent: EV_WINDOW

			l_dial: EV_DIALOG
			vb: EV_VERTICAL_BOX
			hb: EV_HORIZONTAL_BOX
			l_txt: EV_TEXT
			l_but_valid, l_but_cancel, l_but_reset: EV_BUTTON

			t: STRING
		do
			l_parent := parent_window (parent)
			is_dialog_open := False
				-- Build dialog
			create l_dial
			create vb
			l_dial.extend (vb)
			create l_txt
			vb.extend (l_txt)
			create hb
			vb.extend (hb)
			vb.disable_item_expand (hb)
			create l_but_valid.make_with_text_and_action ("Valid", agent dialog_ok (l_dial, l_txt))
			create l_but_reset.make_with_text_and_action ("Reset", agent dialog_reset (l_dial, l_txt))
			create l_but_cancel.make_with_text_and_action ("Cancel", agent dialog_cancel (l_dial, l_txt))
			hb.extend (l_but_valid)
			hb.extend (l_but_reset)
			hb.extend (l_but_cancel)

			t := text
			if t /= Void then
				l_txt.set_text (t)
			end

			l_dial.set_title ("Edit text")
			l_dial.set_default_cancel_button (l_but_cancel)
			l_dial.set_size (300, 200)
			l_dial.show_modal_to_window (l_parent)
			is_dialog_open := True
		end

	dialog_ok (a_dial: EV_DIALOG; a_txt: EV_TEXT) is
			-- Valid button clicked
		local
			t: STRING
		do
			t := a_txt.text
			if not is_multiline_string then
				t.replace_substring_all ("%N", "")
			end
			set_text (t)
			a_dial.destroy
			is_dialog_open := False
		end

	dialog_reset (a_dial: EV_DIALOG; a_txt: EV_TEXT) is
			-- Reset button clicked
		do
			a_txt.set_text (text)
		end

	dialog_cancel (a_dial: EV_DIALOG; a_txt: EV_TEXT) is
			-- Cancel button clicked
		do
			a_dial.destroy
			is_dialog_open := False
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
