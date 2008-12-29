note
	description: "Objects that represents a directory grid item."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_GRID_DIRECTORY_ITEM

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
			ellipsis_actions.force_extend (agent show_dialog)
			enable_text_editing
		end

feature -- Status

	is_dialog_open: BOOLEAN
			-- Is the extended dialog open?

	start_directory: STRING_GENERAL

feature -- Change

	set_start_directory (v: like start_directory)
		do
			start_directory := v.twin
		end

feature {NONE} -- Agents

	show_dialog
			-- Show text editor.
		require
			parented: is_parented
			parent_window: parent_window (parent) /= Void
			activated: is_activated
		local
			l_parent: EV_WINDOW
			l_dial: EV_DIRECTORY_DIALOG
			l_dir: DIRECTORY
			t: STRING_GENERAL
		do
			l_parent := parent_window (parent)
			is_dialog_open := True
			create l_dial
			if text_field /= Void then
				t := text_field.text
			else
				t := text
			end

				--| Find the start directory
			if t /= Void and then not t.is_empty then
				create l_dir.make (t.as_string_8)
				if not l_dir.exists then
					l_dir := Void
				end
			end
			if l_dir = Void and start_directory /= Void then
				create l_dir.make (start_directory.as_string_8)
				if not l_dir.exists then
					l_dir := Void
				end
			end
			if l_dir /= Void then
				l_dial.set_start_directory (l_dir.name)
			end

			l_dial.ok_actions.extend (agent dialog_ok (l_dial))
			enter_outter_edition
			l_dial.show_modal_to_window (l_parent)
			leave_outter_edition
			if text_field /= Void then
				text_field.set_focus
			end
			is_dialog_open := False
		end

	dialog_ok (a_dial: EV_DIRECTORY_DIALOG)
			-- If dialog is closed with ok.
		do
			if text_field /= Void then
				text_field.set_text (a_dial.directory)
			else
				set_text (a_dial.directory)
			end
		end

note
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
