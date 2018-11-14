note
	description: "Objects that represents a directory grid item."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			ellipsis_actions.extend (agent show_dialog)
			enable_text_editing
		end

feature -- Status

	is_dialog_open: BOOLEAN
			-- Is the extended dialog open?

	start_directory: detachable READABLE_STRING_GENERAL
		do
			if attached start_path as p then
				Result := p.name
			end
		end

	start_path: detachable PATH
			-- Starting directory path

feature -- Change

	set_start_directory (v: like start_directory)
		do
			if v /= Void then
				set_start_path (create {PATH}.make_from_string (v))
			else
				set_start_path (Void)
			end
		end

	set_start_path (a_path: like start_path)
		do
			start_path := a_path
		end


feature {NONE} -- Agents

	show_dialog
			-- Show text editor.
		require
			parented: is_parented
			parent_window: attached parent as r_p and then parent_window (r_p) /= Void
			activated: is_activated
		local
			l_parent: detachable EV_WINDOW
			l_dial: EV_DIRECTORY_DIALOG
			l_dir: detachable DIRECTORY
			t: STRING_32
			tf: like text_field
		do
			is_dialog_open := True
			create l_dial
			tf := text_field
			if tf /= Void then
				t := tf.text
			else
				t := text
			end

				--| Find the start directory
			if t /= Void and then not t.is_empty then
				create l_dir.make (t)
				if not l_dir.exists then
					l_dir := Void
				end
			end
			if l_dir = Void and attached start_path as s_path then
				create l_dir.make_with_path (s_path)
				if not l_dir.exists then
					l_dir := Void
				end
			end
			if l_dir /= Void then
				l_dial.set_start_directory (l_dir.path.name)
			end

			l_dial.ok_actions.extend (agent dialog_ok (l_dial))
			enter_outter_edition
			if attached parent as g then
				l_parent := parent_window (g)
			end
			if l_parent /= Void then
				l_dial.show_modal_to_window (l_parent)
			else
				check has_parent_window: False end
			end
			leave_outter_edition
			if tf /= Void then
				tf.set_focus
			end
			is_dialog_open := False
		end

	dialog_ok (a_dial: EV_DIRECTORY_DIALOG)
			-- If dialog is closed with ok.
		do
			if attached text_field as tf then
				tf.set_text (a_dial.path.name)
			else
				set_text (a_dial.path.name)
			end
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
