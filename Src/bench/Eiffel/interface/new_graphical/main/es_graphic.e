indexing
	description	: "Main class for Graphic mode in EiffelStudio."
	date		: "$Date$"
	revision	: "$Revision$"

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

	EB_GENERAL_DATA
		export
			{NONE} all
		undefine
			default_create,
			copy
		end

	EB_PROJECT_TOOL_DATA
		export
			{NONE} all
		undefine
			default_create,
			copy
		end
		
	SHARED_BENCH_LICENSES
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

create
	make_and_launch

feature {NONE} -- Initialization

	make_and_launch is
		local
			rescued: INTEGER
			exception_trace_at_crash: STRING
		do
			if rescued = 0 then
					-- Normal execution
				default_create
				prepare
				launch
			else
					-- First time rescue
				if not Eiffel_project.batch_mode then
					try_to_save_files
				end
					-- Display the dialog showing the error
				clean_exit (exception_trace_at_crash)
				
					-- Prevent the display of the starting dialog
				post_launch_actions.wipe_out
				
					-- Re-launch the message pump
				launch
			end
		rescue
			if not fail_on_rescue then
				rescued := rescued + 1
				exception_trace_at_crash := exception_trace
					-- If the first time rescue has generated an
					-- exception we don't try it again.
				if rescued < 2 and exception_trace_at_crash /= Void then
					retry
				end
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
			if not graphical_output_disabled then
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
				post_launch_actions.extend (agent open_project.execute_with_file (argument (project_index + 1)))
			else
					-- Project created by `ebench -create my_path -ace my_ace'
				create_project_index := index_of_word_option ("create")
				create_ace_index := index_of_word_option ("ace")
				compile_index := index_of_word_option ("compile")
				if create_project_index /= 0 and then create_ace_index /= 0 then
					post_launch_actions.extend (agent create_project (argument (create_project_index + 1), argument (create_ace_index + 1), compile_index /= 0))
				else
						-- Show starting dialog.
					if show_starting_dialog then
						post_launch_actions.extend (agent display_starting_dialog)
					end
				end
			end
			
				-- Register help engine
			set_help_engine (create {EB_HELP_ENGINE}.make)
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
		
feature {NONE} -- Implementation (Failsafe rescue)
		
	clean_exit (trace: STRING) is
			-- Perform clean quit of $EiffelGraphicalCompiler$
		local
			error_dlg: EB_EXCEPTION_DIALOG
		do
			create error_dlg.make (trace)
			error_dlg.show_modal_to_window (parent_for_dialog)
		end
		
	try_to_save_files is
			-- In case of a crash, try to make a backup of all edited files.
		local
			wd: EV_WARNING_DIALOG
			retried: BOOLEAN
		do
			if not retried then -- Never retried
				if Window_manager.has_modified_windows then
					create wd.make_with_text (Warning_messages.w_Crashed)
					wd.show_modal_to_window (parent_for_dialog)
					window_manager.backup_all
					if window_manager.not_backuped = 0 then
						create wd.make_with_text (Warning_messages.w_Backup_succeeded)
						wd.show_modal_to_window (parent_for_dialog)
					else
						create wd.make_with_text (Warning_messages.w_Backup_partial (window_manager.not_backuped))
						wd.show_modal_to_window (parent_for_dialog)
					end
				else
					-- Nothing to do: everything was saved.
				end
			else
				create wd.make_with_text (Warning_messages.w_Backup_failed)
				wd.show_modal_to_window (parent_for_dialog)
			end
		rescue
			retried := true
			retry
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
		
end -- class ES_GRAPHIC
