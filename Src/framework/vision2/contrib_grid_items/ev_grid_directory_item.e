indexing
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

	initialize is
			-- Initialize.
		do
			Precursor
			ellipsis_actions.force_extend (agent show_dialog)
			enable_text_editing
--			change_actions.extend (agent ()
--				do
--					if text /= Void and then not text.is_empty then
--						set_start_directory (text)
--					end
--				end)
		end

feature -- Status

	is_dialog_open: BOOLEAN
			-- Is the extended dialog open?

	start_directory: STRING_GENERAL

feature -- Change

	set_start_directory (v: like start_directory) is
		do
			start_directory := v.twin
--			print ("start_directory -> ")
--			print (start_directory)
--			print ("%N")
		end

feature {NONE} -- Agents

	show_dialog is
			-- Show text editor.
		require
			parent_window: parent_window /= Void
			popup_window: popup_window /= Void
			activated: is_activated
		local
			l_parent: EV_WINDOW
			l_dial: EV_DIRECTORY_DIALOG
			l_dir: DIRECTORY
			t: STRING
		do
			l_parent := parent_window
			is_dialog_open := True
			create l_dial
			t := text
				--| Find the start directory
			if t /= Void and then not t.is_empty then
				create l_dir.make (t)
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
			l_dial.show_modal_to_window (l_parent)
			is_dialog_open := False
		end

	dialog_ok (a_dial: EV_DIRECTORY_DIALOG) is
			-- If dialog is closed with ok.
		do
			set_text (a_dial.directory)
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
