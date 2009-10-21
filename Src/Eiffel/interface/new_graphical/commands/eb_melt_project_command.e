note
	description	: "Command to update the Eiffel project."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date		: "$Date$"
	revision	: "$Revision$"

class
	EB_MELT_PROJECT_COMMAND

inherit
	EB_TOOLBARABLE_AND_MENUABLE_COMMAND
		redefine
			tooltext,
			is_tooltext_important,
			new_sd_toolbar_item
		end

	EB_SHARED_GRAPHICAL_COMMANDS
		export
			{NONE} all
		end

	ES_SHARED_OUTPUTS
		export
			{NONE} all
		end

	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end

	PROJECT_CONTEXT
		export
			{NONE} all
		end

	SHARED_CONFIGURE_RESOURCES
		export
			{NONE} all
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	EXCEPTIONS
		export
			{NONE} all
		end

	EB_SHARED_INTERFACE_TOOLS
		export
			{NONE} all
		end

	EB_SHARED_FORMAT_TABLES
		export
			{NONE} all
		end

	SHARED_FLAGS

	EV_SHARED_APPLICATION
		export
			{NONE} all
		end

	EB_SHARED_DEBUGGER_MANAGER

	ES_SHARED_DIALOG_BUTTONS
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize default values.
		local
			l_shortcut: SHORTCUT_PREFERENCE
		do
			l_shortcut := preferences.misc_shortcut_data.shortcuts.item ("compile")
			create accelerator.make_with_key_combination (l_shortcut.key, l_shortcut.is_ctrl, l_shortcut.is_alt, l_shortcut.is_shift)
			set_referred_shortcut (l_shortcut)
			accelerator.actions.extend (agent execute)
		end

feature -- Properties		

	is_precompiling: BOOLEAN
			-- Is this compilation a precompilation?
		do
			-- False for a standard compilation
		end

feature -- Status report

	run_after_melt: BOOLEAN
			-- Should we execute the system after sucessful melt?

feature -- Status Setting

	set_run_after_melt (b: BOOLEAN)
			-- Request for the system to be executed after a
			-- successful melt compilation or not.
			-- Assign `b' to `run_after_melt'.
		do
			run_after_melt2 := b
		end

feature {NONE} -- Compilation implementation

	reset_debugger
			-- Kill the application, if it is running.
		do
			Eb_debugger_manager.on_compile_start
		end

	compile
			-- Compile, in the one way or the other.
		do
			if not Eiffel_project.is_compiling then
				degree_output.put_start_output

				reset_debugger
				Window_manager.on_compile
				perform_compilation
				display_eiffel_compilation_status
				if Eiffel_project.successful then
						-- If a freezing already occurred (due to a new external
						-- or new derivation of SPECIAL), no need to freeze again.
					if Eiffel_project.save_error then
						degree_output.put_message ("Could not write to ")
						degree_output.put_message (project_location.location)
						degree_output.put_new_line
						degree_output.put_message ("Please check permissions/disk space and retry")
						degree_output.put_new_line
					else
						if not finalization_error then
							launch_c_compilation
						end
					end
				end
				tool_resynchronization

				degree_output.put_end_output
			end
		end

	display_eiffel_compilation_status
			-- Display status of eiffel compilation.
		do
			if Workbench.successful then
				degree_output.put_new_line
				degree_output.put_string (Interface_names.ee_compilation_succeeded)
				degree_output.put_new_line
			else
					-- Need extra break because failure is unexpected.
				degree_output.put_new_line
				degree_output.put_string (Interface_names.ee_compilation_failed)
				degree_output.put_new_line
			end
		end

	tool_resynchronization
			-- Resynchronize class, feature and system tools.
			-- Clear the format_context buffers.
		local
			l_win: EB_DEVELOPMENT_WINDOW
			l_mediator: SD_DOCKER_MEDIATOR
		do
			l_win := window_manager.last_created_window
			if l_win /= Void then
				l_mediator := l_win.docking_manager.docker_mediator
				if l_mediator /= Void then
					-- If end user is dragging a zone for docking, we cancel it.
					l_mediator.cancel_tracing_pointer
				end
			end

				-- Clear the format_context buffers.
			clear_format_tables

			window_manager.display_message_and_percentage (Interface_names.d_Resynchronizing_tools, 0)
			window_manager.synchronize_all
			if Workbench.successful then
				if not process_manager.is_c_compilation_running then
					window_manager.display_message (Interface_names.e_compilation_succeeded)
				end
			else
				window_manager.display_message (Interface_names.e_compilation_failed)
			end
			Eb_debugger_manager.on_compile_stop
			metric_manager.on_compile_stop

			if dynamic_lib_window_is_valid and then dynamic_lib_window.is_visible then
				dynamic_lib_window.refresh
			end
		end

	launch_c_compilation
			-- Launch the C compilation.
		do
			if start_c_compilation and then Eiffel_project.freezing_occurred and then not lace.compile_all_classes then
				if Eiffel_project.freezing_occurred then
					if attached compiler_output as l_output then
						l_output.lock
					end
					c_compiler_formatter.add_string ("Eiffel System is being frozen to include new or modified externals.")
					c_compiler_formatter.add_new_line
					if attached compiler_output as l_output then
						l_output.unlock
					end
				end
				Eiffel_project.call_finish_freezing (True)
			end
		end

	perform_compilation
			-- The real compilation. (This is melting.)
		do
			Eiffel_project.quick_melt
		end

feature {NONE} -- Attributes

	not_saved: BOOLEAN
			-- Has the text of some tool been edited and not saved?
		do
			Result := window_manager.has_modified_windows
		end

	finalization_error: BOOLEAN
			-- Has a validity error been detected during the
			-- finalization? This happens with DLE dealing
			-- with statically bound feature calls
		do
		end

	start_c_compilation: BOOLEAN
			-- Do we have to start the C compilation after C Code generation?

	run_after_melt2: BOOLEAN
			-- Should we execute the system after sucessful melt?
			-- This boolean value is only reliable at the beginning
			-- of the execution of this command. After a warning or
			-- confirmation panel has been popped up, this value
			-- can be cleared by the caller. To prevent that, we
			-- keep track of that value in `run_after_melt' at the
			-- beginning of the execution, so that we can still
			-- rely on it after a confirmation when we resume
			-- (i.e. re-execute) the command

	retried: BOOLEAN
			-- Is this already tried?

	c_code_directory: STRING
			-- Directory where the C code is stored.
		do
			Result := project_location.workbench_path
		end

feature -- Execution

	execute
			-- Recompile the project, start C compilation if necessarry.
		local
			l_window: EB_DEVELOPMENT_WINDOW
			l_service: SERVICE_CONSUMER [OUTPUT_MANAGER_S]
			l_output: OUTPUT_I
		do
			if is_sensitive then
				if process_manager.is_c_compilation_running then
					process_manager.confirm_process_termination (agent go_on_compile, Void, window_manager.last_focused_development_window.window)
				else
					l_window := window_manager.last_focused_development_window
					check
						l_window_attached: l_window /= Void
						l_window_is_interface_usable: l_window.is_interface_usable
					end
						-- Activate the compiler output on the outputs tools.
					create l_service
					if l_service.is_service_available then
						l_output := l_service.service.output ((create {OUTPUT_MANAGER_KINDS}).eiffel_compiler)
						l_output.activate (False)
					end
					if preferences.development_window_data.outputs_tool_prompted then
							-- Request tool be shown.
						l_window.shell_tools.show_tool ({ES_OUTPUTS_TOOL}, False)
					end
					go_on_compile
				end
			end
		end

	execute_and_wait
			-- Execute current command and wait for it to finish.
		do
			execute
			from
			until
				not process_manager.is_c_compilation_running
			loop
				ev_application.process_events
			end
		end

	go_on_compile
			-- Go on running Eiffel compilation.
		do
			execute_with_c_compilation_flag (True)
		end

feature {NONE} -- Execution

	execute_with_c_compilation_flag (c_compilation_enabled: BOOLEAN)
			-- Recompile the project and start C compilation if `c_compilation_enabled'
			-- is True.
		local
			l_save_confirm: ES_DISCARDABLE_COMPILE_SAVE_FILES_PROMPT
			l_classes: DS_ARRAYED_LIST [CLASS_I]
		do
			start_c_compilation := c_compilation_enabled
			if c_compilation_enabled then
					-- Should we execute the system after sucessful melt?
					-- (See header comment of `run_after_melt2'.)
				run_after_melt := run_after_melt2
			else
				run_after_melt := false
			end
			if Eiffel_project.is_read_only then
				prompts.show_warning_prompt (warning_messages.w_cannot_compile, Void, Void)
			elseif Eiffel_project.initialized then
				if not_saved then
					create l_classes.make_default
					window_manager.all_modified_classes.do_all (agent l_classes.force_last)
					create l_save_confirm.make (l_classes)
					l_save_confirm.set_button_action (l_save_confirm.dialog_buttons.yes_button, agent save_and_compile)
					l_save_confirm.set_button_action (l_save_confirm.dialog_buttons.no_button, agent compile_no_save)
					l_save_confirm.set_button_action (l_save_confirm.dialog_buttons.cancel_button, agent set_run_after_melt (False))
					l_save_confirm.show_on_active_window
				else
					compile_no_save
				end
			end
		end

	save_and_compile
			-- Save all files, then launch compilation
		do
			window_manager.save_all_before_compiling
			compile_no_save
		end

	compile_no_save
			-- Launch compilation.
		local
			l_last_window: EV_WINDOW
		do
			l_last_window := window_manager.last_focused_development_window.window
			if l_last_window.is_displayed and l_last_window.is_sensitive then
				l_last_window.set_focus
			end
			--window_manager.last_focused_development_window.window.set_focus
			confirm_and_compile
		end

	confirm_and_compile
			-- Ask for confirmations and options, then compile.
			--| Can be redefined in descendants!
		do
			confirm_execution_halt
		end

	confirm_execution_halt
			-- If the application is running, prompt
			-- user so and ask for a confirmation.
			-- If confirmation successful then compile.
		local
			l_confirm: ES_DISCARDABLE_QUESTION_PROMPT
		do
			if
				not Debugger_manager.application_is_executing
			then
				compile_and_run
			else
				create l_confirm.make_standard (interface_names.e_exec_recompile, "", create {ES_BOOLEAN_PREFERENCE_SETTING}.make (preferences.dialog_data.stop_execution_when_compiling_preference, True))
				l_confirm.set_title (interface_names.t_debugger_question)
				l_confirm.set_button_action (l_confirm.dialog_buttons.yes_button, agent compile_and_run)
				l_confirm.show_on_active_window
			end
		end

	compile_and_run
			-- Compile, then run application, according
			-- to run ability and `run_after_melt' flag.
		do
			compile
			if
				run_after_melt and then
				Eiffel_ace.file_name /= Void and then
				Eiffel_project.successful and
				not Eiffel_project.freezing_occurred
			then
					-- The system has been successfully melted.
					-- The system can be executed as required.
				Run_project_cmd.execute
			end
		end

feature {NONE} -- Implementation

	new_sd_toolbar_item (display_text: BOOLEAN): EB_SD_COMMAND_TOOL_BAR_DUAL_POPUP_BUTTON
			-- Create a new docking tool bar button for this command.
		do
			create Result.make (Current)
			initialize_sd_toolbar_item (Result, display_text)
			Result.select_actions.extend (agent execute)
			Result.set_menu (drop_down_menu (Result))
		end

	drop_down_menu (a_cmd: like new_sd_toolbar_item): EV_MENU
			-- Drop down menu for `new_sd_toolbar_item'.
		local
			l_item: EB_COMMAND_MENU_ITEM
		do
			create Result

			l_item := new_menu_item
			a_cmd.auto_recycle (l_item)
			Result.extend (l_item)

			l_item := discover_melt_cmd.new_menu_item
			a_cmd.auto_recycle (l_item)
			Result.extend (l_item)

			l_item := override_scan_cmd.new_menu_item
			a_cmd.auto_recycle (l_item)
			Result.extend (l_item)

			l_item := freeze_project_cmd.new_menu_item
			a_cmd.auto_recycle (l_item)
			Result.extend (l_item)

			l_item := finalize_project_cmd.new_menu_item
			a_cmd.auto_recycle (l_item)
			Result.extend (l_item)

			l_item := precompilation_cmd.new_menu_item
			a_cmd.auto_recycle (l_item)
			Result.extend (l_item)
		ensure
			not_void: Result /= Void
		end

	tooltext: STRING_GENERAL
			-- Text displayed in toolbar
		do
			Result := Interface_names.b_Compile
		end

	is_tooltext_important: BOOLEAN
			-- Is the tooltext important shown when view is 'Selective Text'
		do
			Result := tooltext.is_equal (Interface_names.b_Compile)
		end

	menu_name: STRING_GENERAL
			-- Name as it appears in the menu (with & symbol).
		do
			Result := Interface_names.m_Melt_new
		end

	pixmap: EV_PIXMAP
			-- Pixmap representing the command.
		do
			Result := pixmaps.icon_pixmaps.project_melt_icon
		end

	pixel_buffer: EV_PIXEL_BUFFER
			-- Pixel buffer representing the command.
		do
			Result := pixmaps.icon_pixmaps.project_melt_icon_buffer
		end

	tooltip: STRING_GENERAL
			-- Tooltip for the toolbar button.
		do
			Result := Interface_names.f_Melt
		end

	description: STRING_GENERAL
			-- Description for the command.
		do
			Result := Interface_names.f_Melt
		end

	name: STRING
			-- Name of the command. Used to store the command in the
			-- preferences.
		do
			Result := "Melt_project"
		end

	stop_execution: ANY
			-- Argument used when files needs to be saved before compiling.
		once
			create Result
		end

	number_of_compilations: INTEGER;
			-- Number of compilations done in a certain mode so far.

note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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

end -- class EB_MELT_PROJECT_COMMAND
