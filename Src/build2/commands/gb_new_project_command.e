
indexing
	description: "Objects that represent a new project command."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GB_NEW_PROJECT_COMMAND

inherit
	GB_STANDARD_CMD
		redefine
			execute, executable
		end

	GB_CONSTANTS
		export
			{NONE} all
		end

	GB_FILE_CONSTANTS
		export
			{NONE} all
		end

	GB_SHARED_PIXMAPS
		export
			{NONE} all
		end

create
	make_with_components

feature {NONE} -- Initialization

	make_with_components (a_components: GB_INTERNAL_COMPONENTS) is
			-- Create `Current' and assign `a_components' to `components'.
		local
			acc: EV_ACCELERATOR
			key: EV_KEY
		do
			components := a_components
			make
			set_tooltip ("New Project...")
			set_pixmaps ((create {GB_SHARED_PIXMAPS}).icon_new_editor)
			set_name ("New Project...")
			set_menu_name ("New Project...")
			enable_sensitive
			add_agent (agent execute)

					-- Now add an accelerator for `Current'.
			create key.make_with_code ((create {EV_KEY_CONSTANTS}).key_n)
			create acc.make_with_key_combination (key, True, False, False)
			set_accelerator (acc)
		end

feature -- Access

	executable: BOOLEAN is
			-- May `execute' be called on `Current'?
		do
				-- Only can execute if there is no project open.
			Result := not (components.system_status.project_open)
		end

feature -- Basic operations

		execute is
				-- Execute `Current'.
			local
				settings: GB_PROJECT_SETTINGS
				dialog: EV_DIRECTORY_DIALOG
				raw_file: RAW_FILE
				file_name: FILE_NAME
				created_project: BOOLEAN
				conf_dialog, directory_conf: EV_CONFIRMATION_DIALOG
				create_project, cancelled: BOOLEAN
				directory: DIRECTORY
			do
				from
					create dialog
				until
					cancelled or created_project
				loop
					create_project := True
					dialog.show_modal_to_window (components.tools.main_window)
					if dialog.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_cancel) then
						cancelled := True
					end
						-- If a directory was chosen.
					if not cancelled then
						create file_name.make_from_string (dialog.directory)
						file_name.extend (Project_filename)
						create raw_file.make (file_name)
						if raw_file.exists then
							create conf_dialog.make_with_text (Project_exists_warning)
							conf_dialog.set_icon_pixmap (Icon_build_window @ 1)
							conf_dialog.show_modal_to_window (components.tools.main_window)
							if not conf_dialog.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_ok) then
								create_project := False
							end
						end
						if create_project then
							create directory.make (dialog.directory)
							if not directory.exists then
								create directory_conf.make_with_text (Directory_exists_warning)
								directory_conf.set_icon_pixmap (Icon_build_window @ 1)
								directory_conf.show_modal_to_window (components.tools.main_window)
								if directory_conf.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_ok) then
									directory.create_dir
								end
							end
							if directory.exists then
								created_project := True
								create settings.make_with_default_values (components)
								settings.set_project_location (dialog.directory)
								components.system_status.set_current_project (settings)
								components.commands.update
							end
						end
					end
				end

				if created_project then
						-- We must now initailize the tools for a new empty project.
					components.object_handler.add_initial_window
					components.events.new_project_actions.call (Void)
				end
			end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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


end -- class GB_NEW_PROJECT_COMMAND
