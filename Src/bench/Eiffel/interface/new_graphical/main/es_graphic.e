indexing
	description: "Main class for Graphic mode in EiffelStudio."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_GRAPHIC

inherit
	EV_APPLICATION

	EB_SHARED_INTERFACE_TOOLS
		undefine
			default_create,
			copy
		end

	SHARED_EIFFEL_PROJECT
		undefine
			default_create,
			copy
		end

	SHARED_APPLICATION_EXECUTION
		undefine
			default_create,
			copy
		end

	ARGUMENTS
		undefine
			default_create,
			copy
		end

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		undefine
			default_create,
			copy
		end
		
	EXCEPTIONS
		export
			{NONE} all
		undefine
			default_create,
			copy
		end

	SHARED_CONFIGURE_RESOURCES
		export
			{NONE} all
		undefine
			default_create,
			copy
		end

	EB_CONSTANTS
		export
			{NONE} all
		undefine
			default_create,
			copy
		end

	SHARED_LICENSE
		export
			{NONE} all
		undefine
			default_create,
			copy
		end

create
	make

feature {NONE} -- Initialization

	make is
			-- Make and initialize graphical compiler
		do
			default_create
			license.check_license
			if license.is_licensed then
				post_launch_actions.extend (agent prepare)
			else
				post_launch_actions.extend (agent license.check_activation_while_running (agent prepare))
			end
		end

feature {NONE} -- Implementation (preparation of all widgets)
		
	prepare is
		local
			project_index: INTEGER
			create_project_index: INTEGER
			create_ace_index: INTEGER
			compile_index: INTEGER
			open_project: EB_OPEN_PROJECT_COMMAND
			an_output_manager: EB_GRAPHICAL_OUTPUT_MANAGER
			a_recent_projects_manager: EB_RECENT_PROJECTS_MANAGER
			first_window: EB_DEVELOPMENT_WINDOW
			a_progress_dialog: EB_PROGRESS_DIALOG
			a_graphical_degree_output: EB_GRAPHICAL_DEGREE_OUTPUT
		do
			if license.is_licensed or license.can_run then
					--| If we don't put bench mode here,
					--| `error_window' will assume batch
					--| mode and thus it will initialize
					--| `error_window' as a TERM_WINDOW.
					--| Also note that `error_window' is a
					--| once-function!!
		
					-- Create and setup the output manager / Error displayer
				create an_output_manager
				set_output_manager (an_output_manager)
				Eiffel_project.set_error_displayer (an_output_manager)
		
					-- Create and setup the degree output window.
				if not preferences.project_tool_data.graphical_output_disabled then
					create a_progress_dialog
					set_progress_dialog (a_progress_dialog)
					create a_graphical_degree_output.make_with_dialog (a_progress_dialog)
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
					open_project.execute_with_file (argument (project_index + 1))
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
				set_help_engine (create {EB_HELP_ENGINE}.make)
			end
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
			create_project_dialog: EB_CREATE_PROJECT_DIALOG
			first_window: EB_DEVELOPMENT_WINDOW
		do
			first_window := window_manager.last_created_window
			check
				first_window_not_void: first_window /= Void
			end

				-- Create the project.
			create create_project_dialog.make_with_ace_and_directory_and_flags (first_window.window,
				an_ace_file_name, a_directory_name, compilation_flag, False)
			create_project_dialog.create_project

				-- Compile if needed.
			if create_project_dialog.success and then create_project_dialog.compile_project then
				first_window.Melt_project_cmd.execute
			end
		end
		
end -- class ES_GRAPHIC
