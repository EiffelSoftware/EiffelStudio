note
	description: "Command to display the License."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_LICENSE_COMMAND

inherit
	EB_COMMAND

	EB_SHARED_MANAGERS
		export
			{NONE} all
		end

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

feature -- Access

	license_path: detachable PATH
			-- Path to the license file.
		do
			if is_eiffel_layout_defined then
				Result := eiffel_layout.install_path.extended ("LICENSE")
			end
		end

	parent_window: detachable EV_WINDOW
			-- If set, license dialog will be modal to this `parent_window`.

feature -- Element change

	set_parent_window (win: detachable EV_WINDOW)
			-- Set `parent_window` to `win`.
		do
			parent_window := win
		end

feature -- Status report

	is_available: BOOLEAN
			-- Is license available?
		local
			fu: FILE_UTILITIES
		do
			if attached license_path as p then
				Result := fu.file_path_exists (p)
			end
		end

feature -- Execution

	execute
			-- Popup the help window.
		local
			lic_dialog: EB_LICENSE_DIALOG
			l_parent_window: detachable EV_WINDOW
		do
			create lic_dialog.make (license_path)

			l_parent_window := parent_window
			if l_parent_window = Void and then attached window_manager.last_focused_window as win then
				l_parent_window := win.window
			end
			if l_parent_window /= Void then
				lic_dialog.show_modal_to_window (l_parent_window)
			end
		end

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software"
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

end -- class EB_LICENSE_COMMAND
