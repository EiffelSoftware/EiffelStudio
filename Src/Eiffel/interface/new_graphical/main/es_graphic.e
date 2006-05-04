indexing
	description: "Main class for Graphic mode in EiffelStudio."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_GRAPHIC

inherit
	EB_SHARED_INTERFACE_TOOLS

	SHARED_EIFFEL_PROJECT

	ARGUMENTS

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		end

	EXCEPTIONS
		export
			{NONE} all
		end

	SHARED_CONFIGURE_RESOURCES
		export
			{NONE} all
		end

	EB_CONSTANTS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (an_app: EV_APPLICATION) is
			-- Make and initialize graphical compiler
		require
			an_app_not_void: an_app /= Void
		do
			an_app.post_launch_actions.extend (agent prepare (an_app))
				-- Make sure any uncaught exceptions are handled
			an_app.uncaught_exception_actions.extend (agent handle_exception)
		end

feature {NONE} -- Implementation (preparation of all widgets)

	prepare (an_app: EV_APPLICATION) is
			-- Build graphical compiler
		require
			an_app_not_void: an_app /= Void
		local
			project_index: INTEGER
			create_project_index: INTEGER
			create_ace_index: INTEGER
			compile_index: INTEGER
			open_project: EB_OPEN_PROJECT_COMMAND
			an_output_manager: EB_GRAPHICAL_OUTPUT_MANAGER

			an_external_output_manager: EB_EXTERNAL_OUTPUT_MANAGER
			a_c_compilation_output_manager: EB_C_COMPILATION_OUTPUT_MANAGER

			a_recent_projects_manager: EB_RECENT_PROJECTS_MANAGER
			first_window: EB_DEVELOPMENT_WINDOW
			a_graphical_degree_output: ES_GRAPHICAL_DEGREE_OUTPUT
			preference_access: PREFERENCES
		do
				--| If we don't put bench mode here,
				--| `error_window' will assume batch
				--| mode and thus it will initialize
				--| `error_window' as a TERM_WINDOW.
				--| Also note that `error_window' is a
				--| once-function!!

				-- Initialization of compiler resources.
			create preference_access.make_with_defaults_and_location (
				<<general_preferences, platform_preferences>>, eiffel_preferences)
			initialize_preferences (preference_access, True)

				-- Create and setup the output manager / Error displayer
			create an_output_manager
			set_output_manager (an_output_manager)
			create an_external_output_manager
			set_external_output_manager (an_external_output_manager)
			create a_c_compilation_output_manager
			set_c_compilation_output_manager (a_c_compilation_output_manager)

			Eiffel_project.set_error_displayer (an_output_manager)

				-- Create and setup the degree output window.
			if not preferences.development_window_data.graphical_output_disabled then
				create a_graphical_degree_output.make_with_output_manager (output_manager)
				Eiffel_project.set_degree_output (a_graphical_degree_output)
			end

				-- Create and setup the recent projects manager
			create a_recent_projects_manager.make
			set_recent_projects_manager (a_recent_projects_manager)

				-- Create a development window
			window_manager.create_window
			first_window := window_manager.last_created_window

			mode.set_item (False)
			project_index := index_of_word_option ("project")
			if project_index /= 0 then
					-- Project opened by `ebench name_of_project.epr'
				create open_project.make_with_parent (first_window.window)
				open_project.execute_with_file (argument (project_index + 1), False)
			else
					-- Project created by `ebench -create my_path -ace my_ace'
				create_project_index := index_of_word_option ("create")
				create_ace_index := index_of_word_option ("ace")
				compile_index := index_of_word_option ("compile")
				if create_project_index /= 0 and then create_ace_index /= 0 then
					create_project (argument (create_project_index + 1), argument (create_ace_index + 1), compile_index /= 0)
				else
						-- Show starting dialog.
					if preferences.dialog_data.show_starting_dialog then
						display_starting_dialog
					end
				end
			end

				-- Register help engine
			an_app.set_help_engine (create {EB_HELP_ENGINE}.make)
		end

	display_starting_dialog is
			-- Show the starting dialog letting the user choose where
			-- his project is (or will be).
		local
			project_dialog: EB_STARTING_DIALOG
			first_window: EB_DEVELOPMENT_WINDOW
		do
			first_window := window_manager.last_created_window
			check
				first_window_not_void: first_window /= Void
			end

			create project_dialog.make_default
			project_dialog.show_modal_to_window (first_window.window)
		end

	create_project (a_directory_name: STRING; an_ace_file_name: STRING; compilation_flag: BOOLEAN) is
			-- Create a new project
		local
			first_window: EB_DEVELOPMENT_WINDOW
			l_loader: EB_GRAPHICAL_PROJECT_LOADER
		do
			first_window := window_manager.last_created_window
			check
				first_window_not_void: first_window /= Void
			end
			create l_loader.make (first_window.window)
			l_loader.open_project_file (an_ace_file_name, Void, a_directory_name, True)
			if not l_loader.is_compilation_requested and then compilation_flag then
				l_loader.compile_project
			end
		end

feature {NONE} -- Exception handling

	handle_exception (a_exception: EXCEPTION) is
			-- Handle the exception `a_exception'
		do
				-- Attempt to salvage any open files
			try_to_save_files
				-- Raise exception dialog
			clean_exit (a_exception.trace_as_string)
		end

	parent_for_dialog: EV_WINDOW is
			-- Retrieve or create a parent for `show_modal_to_window'	
		local
			dev_window: EB_DEVELOPMENT_WINDOW
		do
			dev_window := Window_manager.last_focused_development_window
			if dev_window /= Void then
				Result := dev_window.window
			else
				create Result
			end
		end

	try_to_save_files is
			-- In case of a crash, try to make a backup of all edited files.
		local
			wd: EV_WARNING_DIALOG
			retried: BOOLEAN
		do
			if not retried then
				if window_manager.has_modified_windows then
					create wd.make_with_text (warning_messages.w_crashed)
					wd.show_modal_to_window (parent_for_dialog)
					window_manager.backup_all
					if window_manager.not_backuped = 0 then
						create wd.make_with_text (warning_messages.w_backup_succeeded)
						wd.show_modal_to_window (parent_for_dialog)
					else
						create wd.make_with_text (warning_messages.w_backup_partial (window_manager.not_backuped))
						wd.show_modal_to_window (parent_for_dialog)
					end
				end
			else
				create wd.make_with_text (warning_messages.w_backup_failed)
				wd.show_modal_to_window (parent_for_dialog)
			end
		rescue
			retried := True
			retry
		end

	clean_exit (trace: STRING) is
			-- Perform clean quit of $EiffelGraphicalCompiler$
		local
			error_dlg: EB_EXCEPTION_DIALOG
		do
			create error_dlg.make (trace)
			error_dlg.show_modal_to_window (parent_for_dialog)
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

end -- class ES_GRAPHIC
