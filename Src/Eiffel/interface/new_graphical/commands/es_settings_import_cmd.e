note
	description: "Import settings."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_SETTINGS_IMPORT_CMD

inherit
	EB_MENUABLE_COMMAND

	EB_SHARED_WINDOW_MANAGER
		export
			{NONE} all
		end

	EB_SHARED_PREFERENCES

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize the command.
		do
		end

feature -- Formatting

	execute
			-- Set the execution format to `stone'.
		do
			if is_sensitive then
				open_settings_import_dialog
			end
		end

	open_settings_import_dialog
			-- Show the arguments dialog.
		local
			dlg: detachable ES_SETTINGS_IMPORT_DIALOG
		do
			if attached {EB_DEVELOPMENT_WINDOW} window_manager.last_focused_window as window then
				if attached importation_dialog as l_import_dlg then
					dlg := l_import_dlg
					l_import_dlg.update
				else
					create dlg.make (window)
					set_importation_dialog (dlg)
				end
				dlg.raise
			end
		end

	importation_dialog: detachable ES_SETTINGS_IMPORT_DIALOG

	set_importation_dialog (dlg: like importation_dialog)
		do
			importation_dialog := dlg
		end

feature -- Properties

	name: STRING
			-- Name of the command.
		do
			Result := "Settings Importation"
		end

	menu_name: STRING_GENERAL
			-- <Precursor>
		do
			Result := interface_names.m_import_settings
		end

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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
