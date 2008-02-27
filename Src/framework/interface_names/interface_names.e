indexing
	description:
		"Constants for command names, etc."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	conventions:
		"a_: Accelerator key combination; %
		%b_: Button text; %
		%c_: choices; %
		%d_: Degree outputter; %
		%f_: Focus label text (tooltips); %
		%h_: Help text; %
		%i_: Icon ids for windows (ignored for motif); %
		%m_: Mnemonic (menu entry); %
		%l_: Label texts; %
		%n_: widget Names; %
		%s_: Stone names; %
		%t_: Title (part); %
		%st_: Sub title (part); %
		%e_: Short description, explanation; %
		%s_: Stone names; %
		%fs_: Fixed shortcut names; %
		%wt_: Title for wizards step; %
		%wb_: Body for wizards step; %
		%ws_: Subtitle for wizards step"
	date: "$Date$"
	revision: "$Revision$"

class
	INTERFACE_NAMES

inherit
	PRODUCT_NAMES

	SHARED_LOCALE

feature -- Button texts

	b_Abort: STRING_GENERAL is							do Result := locale.translation("Abort")	end
	b_Add: STRING_GENERAL is 							do Result := locale.translation("Add")	end
	b_Add_text: STRING_GENERAL is 						do Result := locale.translation("Add ->")	end
	b_alphabetical_class_list: STRING_GENERAL is 		do Result := locale.translation("Alphabetical class list")	end
	b_alphabetical_cluster_list: STRING_GENERAL is 		do Result := locale.translation("Alphabetical cluster list")	end
	b_And: STRING_GENERAL is							do Result := locale.translation("And")	end
	b_Apply: STRING_GENERAL is							do Result := locale.translation("Apply")	end
	b_Browse: STRING_GENERAL is							do Result := locale.translation("Browse...")	end
	b_C_functions: STRING_GENERAL is					do Result := locale.translation("C Functions")	end
	b_change: STRING_GENERAL is 						do Result := locale.translation ("Change")	end
	b_Close: STRING_GENERAL is							do Result := locale.translation("Close")	end
	b_Close_tool (a_tool: STRING_GENERAL): STRING_GENERAL is
		require a_tool_not_void: a_tool /= Void
		do	Result := locale.formatted_string (locale.translation ("Close $1"), [a_tool]) end
	b_cluster_charts: STRING_GENERAL is					do Result := locale.translation("Cluster charts")	end
	b_cluster_diagram: STRING_GENERAL is				do Result := locale.translation("Cluster diagrams (may take a long time!)")	end
	b_cluster_hierarchy: STRING_GENERAL is				do Result := locale.translation("Cluster hierarchy")	end
	b_Continue_anyway: STRING_GENERAL is				do Result := locale.translation("Continue Anyway")	end
	b_Continue_on_condition_failure: STRING_GENERAL is  do Result := locale.translation("Continue if evaluation fails")	end
	b_Create: STRING_GENERAL is							do Result := locale.translation("Create")	end
	b_Create_folder: STRING_GENERAL is					do Result := locale.translation("Create Folder...")	end
	b_Delete_command: STRING_GENERAL is					do Result := locale.translation("Delete")	end
	b_Descendant_time: STRING_GENERAL is				do Result := locale.translation("Descendant Time")	end
	b_Execution_parameters: STRING_GENERAL is			do Result := locale.translation ("Execution Parameters") end
	b_Discard_assertions: STRING_GENERAL is				do Result := locale.translation("Discard Assertions")	end
	b_Display_Exception_Trace: STRING_GENERAL is		do Result := locale.translation("Display Exception Trace")	end
	b_do_nothing: STRING_GENERAL is 					do Result := locale.translation("Do nothing")	end
	b_Down_text: STRING_GENERAL is 						do Result := locale.translation("Down")	end
	b_Edit_ace: STRING_GENERAL is						do Result := locale.translation("Edit")	end
	b_Edit_command: STRING_GENERAL is					do Result := locale.translation("Edit...")	end
	b_Eiffel_features: STRING_GENERAL is				do Result := locale.translation("Eiffel Features")	end

	b_Force_debug_mode: STRING_GENERAL is				do Result := locale.translation("Force Debug Mode")	end

	b_Feature_name: STRING_GENERAL is					do Result := locale.translation("Feature Name")	end
	b_Finish: STRING_GENERAL is							do Result := locale.translation("Finish")	end
	b_Function_time: STRING_GENERAL is					do Result := locale.translation("Function Time")	end
	b_go_to: STRING_GENERAL is							do Result := locale.translation ("Go to") end
	b_Keep_assertions: STRING_GENERAL is				do Result := locale.translation("Keep Assertions")	end
	b_eval_keep_assertion_checking: STRING_GENERAL is	do Result := locale.translation("Keep Assertion Checking")	end
	b_Load_ace: STRING_GENERAL is						do Result := locale.translation("Load From...")	end
	b_Move_to_folder: STRING_GENERAL is					do Result := locale.translation("Move to Folder...")	end
	b_New_ace: STRING_GENERAL is						do Result := locale.translation("Reset")	end
	b_New_command: STRING_GENERAL is					do Result := locale.translation("Add...")	end
	b_New_favorite_class: STRING_GENERAL is				do Result := locale.translation("New Favorite Class...")	end
	b_New_tab: STRING_GENERAL is 						do Result := locale.translation("New Tab")	end
	b_Next: STRING_GENERAL is							do Result := locale.translation("Next")	end
	b_Number_of_calls: STRING_GENERAL is				do Result := locale.translation("Number of Calls")	end
	b_Open_original: STRING_GENERAL is					do Result := locale.translation("Open Original File")	end
	b_Open_backup: STRING_GENERAL is					do Result := locale.translation("Open Backup File")	end
	b_Or: STRING_GENERAL is								do Result := locale.translation("Or")	end
	b_Percentage: STRING_GENERAL is						do Result := locale.translation("Percentage")	end
	b_put_handle_left: STRING_GENERAL is				do Result := locale.translation("Put handle left")	end
	b_put_handle_right: STRING_GENERAL is				do Result := locale.translation("Put handle right")	end
	b_put_two_handle_right: STRING_GENERAL is			do Result := locale.translation("Put two handles right")	end
	b_put_two_handle_left: STRING_GENERAL is			do Result := locale.translation("Put two handles left")	end

	b_Replace: STRING_GENERAL is						do Result := locale.translation("Replace")	end
	b_Replace_all: STRING_GENERAL is					do Result := locale.translation("Replace all")	end
	b_Recursive_functions: STRING_GENERAL is			do Result := locale.translation("Recursive Functions")	end
	b_Reload: STRING_GENERAL is							do Result := locale.translation("Reload")	end
	b_Remove: STRING_GENERAL is							do Result := locale.translation("Remove")	end
	b_Remove_all: STRING_GENERAL is						do Result := locale.translation("Remove all")	end
	b_Remove_handles: STRING_GENERAL is					do Result := locale.translation("Remove handles")	end
	b_Remove_text: STRING_GENERAL is 					do Result := locale.translation("<- Remove")	end
	b_Rename: STRING_GENERAL is							do Result := locale.translation("Rename") end
	b_Retry: STRING_GENERAL is							do Result := locale.translation("Retry")	end
	b_Search: STRING_GENERAL is							do Result := locale.translation("Search")	end
	b_select_target: STRING_GENERAL is					do Result := locale.translation ("Select target") end
	b_set: STRING_GENERAL is							do Result := locale.translation("Set")	end
	b_New_search: STRING_GENERAL is 					do Result := locale.translation("New Search?")	end
	b_Save: STRING_GENERAL is							do Result := locale.translation("Save")	end
	b_Save_all: STRING_GENERAL is 						do Result := locale.translation("Save All")	end
	b_Total_time: STRING_GENERAL is						do Result := locale.translation("Total Time")	end
	b_Up_text: STRING_GENERAL is 						do Result := locale.translation("Up")	end
	b_Update: STRING_GENERAL is 						do Result := locale.translation("Update")	end
	b_Compile: STRING_GENERAL is						do Result := locale.translation("Compile")	end
	b_Launch: STRING_GENERAL is							do Result := locale.translation("Start")	end
	b_Restart: STRING_GENERAL							do Result := locale.translation("Restart") end
	b_Continue: STRING_GENERAL is						do Result := locale.translation("Continue")	end
	b_Finalize: STRING_GENERAL is						do Result := locale.translation("Finalize")	end
	b_Freeze: STRING_GENERAL is							do Result := locale.translation("Freeze")	end
	b_Precompile: STRING_GENERAL is						do Result := locale.translation("Precompile")	end
	b_override_scan: STRING_GENERAL is					do Result := locale.translation("Recompile Overrides")	end
	b_discover_melt: STRING_GENERAL is					do Result := locale.translation("Find Added Classes & Recompile")	end
	b_Cut: STRING_GENERAL is							do Result := locale.translation("Cut")	end
	b_Copy: STRING_GENERAL is							do Result := locale.translation("Copy")	end
	b_Paste: STRING_GENERAL is							do Result := locale.translation("Paste")	end
	b_New_editor: STRING_GENERAL is						do Result := locale.translation("New Editor")	end
	b_New_context: STRING_GENERAL is					do Result := locale.translation("New Context")	end
	b_New_window: STRING_GENERAL is						do Result := locale.translation("New Window")	end
	b_Open: STRING_GENERAL is							do Result := locale.translation("Open")	end
	b_Save_as: STRING_GENERAL is						do Result := locale.translation("Save As...")	end
	b_Shell: STRING_GENERAL is							do Result := locale.translation("External Editor")	end
	b_Print: STRING_GENERAL is							do Result := locale.translation("Print")	end
	b_Undo: STRING_GENERAL is							do Result := locale.translation("Undo")	end
	b_Redo: STRING_GENERAL is							do Result := locale.translation("Redo")	end
	b_Create_new_cluster: STRING_GENERAL is				do Result := locale.translation("Add Cluster")	end
	b_Create_new_library: STRING_GENERAL is				do Result := locale.translation("Add Library")	end
	b_Create_new_assembly: STRING_GENERAL is			do Result := locale.translation("Add Assembly")	end
	b_Create_new_precompile: STRING_GENERAL is			do Result := locale.translation("Add Precompile")	end
	b_Create_new_class: STRING_GENERAL is				do Result := locale.translation("New Class")	end
	b_Create_new_feature: STRING_GENERAL is				do Result := locale.translation("New Feature")	end
	b_Send_stone_to_context: STRING_GENERAL is			do Result := locale.translation("Synchronize")	end
	b_Display_error_help: STRING_GENERAL is				do Result := locale.translation("Help Tool")	end
	b_Project_settings: STRING_GENERAL is				do Result := locale.translation("Project Settings")	end
	b_previous: STRING_GENERAL is 						do Result := locale.translation ("Previous") end
	b_System_info: STRING_GENERAL is					do Result := locale.translation("System Info")	end
	b_arrow_back: STRING_GENERAL is						do Result := locale.translation ("< Back") end
	b_arrow_next: STRING_GENERAL is						do Result := locale.translation ("Next >") end
	b_Bkpt_info: STRING_GENERAL is						do Result := locale.translation("Breakpoint Info")	end
	b_Bkpt_enable: STRING_GENERAL is					do Result := locale.translation("Enable Breakpoints")	end
	b_Bkpt_disable: STRING_GENERAL is					do Result := locale.translation("Disable Breakpoints")	end
	b_Bkpt_remove: STRING_GENERAL is					do Result := locale.translation("Remove Breakpoints")	end
	b_Bkpt_stop_in_hole: STRING_GENERAL is				do Result := locale.translation("Pause")	end
	b_Exec_kill: STRING_GENERAL is						do Result := locale.translation("Stop Application")	end
	b_Exec_into: STRING_GENERAL is						do Result := locale.translation("Step Into")	end
	b_Exec_no_stop: STRING_GENERAL is					do Result := locale.translation("Launch Without Stopping")	end
	b_Exec_out: STRING_GENERAL is						do Result := locale.translation("Step Out")	end
	b_Exec_step: STRING_GENERAL is						do Result := locale.translation("Step")	end
	b_Exec_stop: STRING_GENERAL is						do Result := locale.translation("Pause")	end
	b_enable_profiles: STRING_GENERAL is				do Result := locale.translation("Enable Profiles")	end
	b_run: STRING_GENERAL is							do Result := locale.translation("Run")	end
	b_run_and_close: STRING_GENERAL is					do Result := locale.translation("Run & Close")	end
	b_Run_finalized: STRING_GENERAL is					do Result := locale.translation("Run Finalized")	end
	b_Run_workbench: STRING_GENERAL is					do Result := locale.translation("Run Workbench")	end
	b_Toggle_stone_management: STRING_GENERAL is 		do Result := locale.translation("Link Context")	end
	b_Raise_all: STRING_GENERAL is						do Result := locale.translation("Raise Windows")	end
	b_Remove_class_cluster: STRING_GENERAL is			do Result := locale.translation("Remove Class/Cluster")	end
	b_Minimize_all: STRING_GENERAL is					do Result := locale.translation("Minimize All")	end
	b_Terminate_c_compilation: STRING_GENERAL is 		do Result := locale.translation("Terminate C Compilation")	end
	b_Expand_all: STRING_GENERAL is 					do Result := locale.translation("Expand All")	end
	b_Collapse_all: STRING_GENERAL is 					do Result := locale.translation("Collapse All")	end
	b_Dbg_exception_handler: STRING_GENERAL is			do Result := locale.translation("Exceptions")	end
	b_Dbg_assertion_checking_disable: STRING_GENERAL is	do Result := locale.translation("Disable assertion checking")	end
	b_Dbg_assertion_checking_restore: STRING_GENERAL is	do Result := locale.translation("Restore assertion checking")	end
	b_duplicate: STRING_GENERAL is						do Result := locale.translation ("Duplicate") end

	b_Yes: STRING_GENERAL is							do Result := locale.translation ("Yes") end
	b_No: STRING_GENERAL is								do Result := locale.translation("No")	end
	b_Ok: STRING_GENERAL is								do Result := locale.translation("OK")	end
	b_Cancel: STRING_GENERAL is							do Result := locale.translation("Cancel")	end
	b_Disable: STRING_GENERAL is							do Result := locale.translation("Disable") end
	b_Restore: STRING_GENERAL is							do Result := locale.translation("Restore") end
	b_Reset: STRING_GENERAL is							do Result := locale.translation("Reset") end
	b_start: STRING_GENERAL is							do Result := locale.translation("Start") end
	b_stop: STRING_GENERAL is							do Result := locale.translation("Stop") end
	b_overwrite: STRING_GENERAL is						do Result := locale.translation("Overwrite") end
	b_append: STRING_GENERAL is							do Result := locale.translation("Append") end
	b_ignore: STRING_GENERAL is							do Result := locale.translation("Ignore") end

	b_error: STRING_GENERAL is							do Result := locale.translation("Error") end
	b_errors: STRING_GENERAL is							do Result := locale.translation("Errors") end
	b_warning: STRING_GENERAL is						do Result := locale.translation("Warning") end
	b_warnings: STRING_GENERAL is						do Result := locale.translation("Warnings") end

	b_Activate_execution_recording: STRING_GENERAL is 		do Result := locale.translation("Record Execution")	end
	b_Deactivate_execution_recording: STRING_GENERAL is 	do Result := locale.translation("Disable Execution Recording")	end
	b_Activate_execution_replay_mode: STRING_GENERAL is 		do Result := locale.translation("Replay mode")	end
	b_Deactivate_execution_replay_mode: STRING_GENERAL is 	do Result := locale.translation("Execution mode")	end

	b_Exec_replay_back: STRING_GENERAL is	do Result := locale.translation("Replay Back")	end
	b_Exec_replay_forth: STRING_GENERAL is	do Result := locale.translation("Replay Forth")	end
	b_Exec_replay_left: STRING_GENERAL is	do Result := locale.translation("Replay Left")	end
	b_Exec_replay_right: STRING_GENERAL is	do Result := locale.translation("Replay Right")	end

	b_Control_debuggee_object_storage: STRING_GENERAL is	do Result := locale.translation("Debuggee Object Storage")	end
	b_Save_object: STRING_GENERAL is					do Result := locale.translation("Save Object")	end
	b_Load_object: STRING_GENERAL is					do Result := locale.translation("Load Object")	end

	b_keep_dialog_open: STRING_GENERAL is		do Result := locale.translation("Keep Dialog Open")	end
	b_bp_enable_disable_breakpoints: STRING_GENERAL is do Result := locale.translation("Enable/Disable Breakpoints")	end
	b_bp_reset_hits_count: STRING_GENERAL is do Result := locale.translation("Reset Hits Count")	end
	b_bp_activate_execution_recording: STRING_GENERAL is do Result := locale.translation("Record Execution")	end
	b_bp_change_assertion_checking: STRING_GENERAL is do Result := locale.translation("Disable/Restore Assertion Checking")	end
	b_bp_print_message: STRING_GENERAL is			do Result := locale.translation("Print Message")	end

	b_bp_add_when_hits_action: STRING_GENERAL is do Result := locale.translation("Add When Hits Action ...")	end
	b_bp_insert_keywords: STRING_GENERAL is			do Result := locale.translation("Insert special keywords")	end
	b_bp_custom_expression: STRING_GENERAL is			do Result := locale.translation("Custom Expression")	end
	b_bp_context_title: STRING_GENERAL is			do Result := locale.translation("Context")	end
	b_bp_when_hits_title: STRING_GENERAL is			do Result := locale.translation("When Hits ...")	end

feature -- Choices

	c_right_click_receiver: HASH_TABLE [STRING_GENERAL, STRING] is
			-- Choice names for the preference of right_click_receiver.
		once
			create Result.make (5)
			Result.put (c_new_window, co_new_window)
			Result.put (c_editor, co_editor)
			Result.put (c_context, co_context)
			Result.put (c_external_editor, co_external_editor)
			Result.put (c_new_tab_editor, co_new_tab_editor)
		ensure
			result_not_void: Result /= Void
		end

	c_new_window: STRING_GENERAL is 		do Result := locale.translation ("New window") end
	c_editor: STRING_GENERAL is 			do Result := locale.translation ("Current Editor") end
	c_context: STRING_GENERAL is 			do Result := locale.translation ("Context") end
	c_external_editor: STRING_GENERAL is 	do Result := locale.translation ("External Editor") end
	c_new_tab_editor: STRING_GENERAL is 	do Result := locale.translation ("New tab editor") end

	c_init_search_scope: HASH_TABLE [STRING_GENERAL, STRING] is
			-- Choice names for the preference of tools.search_tool.init_scope.
		once
			create Result.make (3)
			Result.put (l_current_editor, co_current_editor)
			Result.put (l_whole_project, co_whole_project)
			Result.put (l_custom, co_custom)
		ensure
			result_not_void: Result /= Void
		end

feature -- Choice original (No translation)

	co_new_window: STRING is "new_window"
			-- Preference that indicates that stones should be launched to a new development window.
	co_editor: STRING is "current_editor"
			-- Preference that indicates that stones should be launched to the current editor.
	co_context: STRING is "context"
			-- Preference that indicates that stones should be launched to the current context tool.
	co_external_editor: STRING is "external"
			-- Preference that indicates that stones should be launched to the external editor.
	co_new_tab_editor: STRING is "new_tab_editor"
			-- Preference that indicates that stones should be launched to a new tab editor.

	co_current_editor: STRING is 		"Current Editor"
	co_whole_project: STRING is 		"Whole Project"
	co_custom: STRING is 				"Custom"

feature -- Graphical degree output

	d_Classes_to_go: STRING is					do Result := locale.translation("Classes to Go:").out	end
	d_Clusters_to_go: STRING_GENERAL is					do Result := locale.translation("Clusters to Go:")	end
	d_Compilation_class: STRING is				do Result := locale.translation("Class:").out	end
	d_Compilation_cluster: STRING is			do Result := locale.translation("Cluster:").out	end
	d_Compilation_progress: STRING is			do Result := locale.translation("Compilation Progress for ").out	end
	d_Degree: STRING is							do Result := locale.translation("Degree:").out	end
	d_Documentation: STRING is					do Result := locale.translation("Documentation").out	end
	d_Features_processed: STRING is				do Result := locale.translation("Completed: ").out	end
	d_Features_to_go: STRING is					do Result := locale.translation("Remaining: ").out	end
	d_Generating: STRING is						do Result := locale.translation("Generating: ").out	end
	d_Resynchronizing_breakpoints: STRING is 	do Result := locale.translation("Resynchronizing Breakpoints").out	end
	d_Resynchronizing_tools: STRING is			do Result := locale.translation("Resynchronizing Tools").out	end
	d_Reverse_engineering: STRING is			do Result := locale.translation("Reverse Engineering Project").out	end
	d_Finished_removing_dead_code: STRING is	do Result := locale.translation("Dead Code Removal Completed").out	end

feature -- Help text

	h_No_help_available: STRING is				do Result := locale.translation("No help available for this element").out	end
	h_refactoring_compiled: STRING is			do Result := locale.translation("Renames only occurrences of the class name in compiled classes.").out	end
	h_refactoring_all_classes: STRING is		do Result := locale.translation("Renames occurrences of the class name in any class. (Slow)").out	end

feature -- File names

	default_stack_file_name: STRING is			"stack"

feature -- Accelerator, focus label and menu name

	m_About: STRING_GENERAL is
		once
			Result := locale.formatted_string (locale.translation("&About $1..."), [Workbench_name])
		end
	m_Advanced: STRING_GENERAL is				do Result := locale.translation("Ad&vanced")	end
	m_Add_to_favorites: STRING_GENERAL is		do Result := locale.translation("&Add to Favorites")	end
	m_add_first_breakpoints_in_class: STRING_GENERAL is 	do Result := locale.translation("Add first breakpoints in class" )	end
	m_add_first_breakpoints_in_feature: STRING_GENERAL is 	do Result := locale.translation("Add first breakpoints in feature" )	end
	f_add_new_expression: STRING_GENERAL is 	do Result := locale.translation ("Click here to add a new expression") end
	m_add_new_variable: STRING_GENERAL is 		do Result := locale.translation ("Add new variable") end
	f_add_a_new_variable: STRING_GENERAL is
		do
			Result := locale.translation ("[
					Add a new variable : double click or [enter]
					Use an existing variable: right click or [Ctrl+enter]
					]")
		end
	f_advanced_search: STRING_GENERAL is 		do Result := locale.translation ("Advanced search") end
	f_display_all_breakpoints_together: STRING_GENERAL is 		do Result := locale.translation ("Display all breakpoints together") end
	m_Address_toolbar: STRING_GENERAL is		do Result := locale.translation("&Address Bar")	end
	m_Apply: STRING_GENERAL is					do Result := locale.translation("&Apply")	end
	m_auto_expressions: STRING_GENERAL is		do Result := locale.translation("Auto expressions")	end
	m_auto_expression_context: STRING_GENERAL is		do Result := locale.translation("Auto expression")	end
	t_auto_expressions: STRING_GENERAL is		do Result := locale.translation("Enable auto expressions ?%N(add contextual symbols automatically)")	end
	l_all_classes: STRING_GENERAL is			do Result := locale.translation("All Classes")	end
	m_Breakpoints_tool: STRING_GENERAL is		do Result := locale.translation("Breakpoints")	end
	m_Breakpoint_index: STRING_GENERAL is		do Result := locale.translation("Breakpoint index:")	end
	m_Break_always: STRING_GENERAL is						do Result := locale.translation("Break always")	end
	m_Break_when_hit_count_equal: STRING_GENERAL is			do Result := locale.translation("Break when the hit count is equal to")	end
	m_Break_when_hit_count_multiple_of: STRING_GENERAL is	do Result := locale.translation("Break when the hit count is a multiple of")	end
	m_Break_when_hit_count_greater: STRING_GENERAL is		do Result := locale.translation("Break when the hit count is greater than or equal to")	end
	m_Break_when_hit_count_continue_execution: STRING_GENERAL is		do Result := locale.translation("Always continue execution")	end
	m_Object_viewer_tool: STRING_GENERAL is		do Result := locale.translation("Object Viewer")	end

	l_class_tree_assemblies: STRING_GENERAL is	do Result := locale.translation("Assemblies")	end
	l_class_tree_clusters: STRING_GENERAL is	do Result := locale.translation("Clusters")	end
	l_class_tree_libraries: STRING_GENERAL is	do Result := locale.translation("Libraries")	end
	l_class_tree_overrides: STRING_GENERAL is	do Result := locale.translation("Overrides")	end
	l_class_tree_targets: STRING_GENERAL is	do Result := locale.translation("Targets")	end

	f_Clear_breakpoints: STRING_GENERAL is		do Result := locale.translation("Remove all breakpoints")	end
	m_Clear_breakpoints: STRING_GENERAL is		do Result := locale.translation("Re&move All Breakpoints")	end
	f_close: STRING_GENERAL is					do Result := locale.translation("Close")	end
	m_Comment: STRING_GENERAL is					do Result := locale.translation("&Comment")	end
	m_Compilation_C_Workbench: STRING_GENERAL is	do Result := locale.translation("Compile W&orkbench C Code")	end
	m_Compilation_C_Final: STRING_GENERAL is		do Result := locale.translation("Compile F&inalized C Code")	end
	m_Contents: STRING_GENERAL is				do Result := locale.translation("&Contents")	end
	m_Customize_general: STRING_GENERAL is		do Result := locale.translation("&Customize Standard Toolbar...")	end
	m_Customize_project: STRING_GENERAL is		do Result := locale.translation("Customize P&roject Toolbar...")	end
	m_Customize_refactoring: STRING_GENERAL is	do Result := locale.translation("Customize Re&factoring Toolbar...")	end
	m_Cut: STRING_GENERAL is						do Result := locale.translation("Cu&t%TCtrl+X")	end
	f_Cut: STRING_GENERAL is					do Result := locale.translation("Cut (Ctrl+X)")	end
	m_Call_stack_tool: STRING_GENERAL is			do Result := locale.translation("Call stack")	end
	m_Cluster_tool: STRING_GENERAL is			do Result := locale.translation("&Clusters")	end
	l_compiled_classes: STRING_GENERAL is		do Result := locale.translation("Compiled Classes")	end
	m_Complete_word: STRING_GENERAL is			do Result := locale.translation("Complete &Word")	end
	m_Complete_class_name: STRING_GENERAL is		do Result := locale.translation("Complete Class &Name")	end
	m_Context_tool: STRING_GENERAL is			do Result := locale.translation("Conte&xt")	end
	m_Copy: STRING_GENERAL is					do Result := locale.translation("&Copy%TCtrl+C")	end

	m_Copy_cell_to_clipboard: STRING_GENERAL is					do Result := locale.translation("Copy Cell To Clipboard")	end
	m_Copy_row_to_clipboard: STRING_GENERAL is					do Result := locale.translation("Copy Row To Clipboard")	end
	f_Copy: STRING_GENERAL is					do Result := locale.translation("Copy (Ctrl+C)")	end
	m_copy_of (a_string: STRING_GENERAL): STRING_GENERAL is
		do
			Result := locale.formatted_string (locale.translation("Copy of $1"), [a_string])
		end
	m_Close: STRING_GENERAL is					do Result := locale.translation("&Close Window")	end
	m_Close_short: STRING_GENERAL is				do Result := locale.translation("&Close")	end
	f_Create_new_cluster: STRING_GENERAL is		do Result := locale.translation("Add a cluster")	end
	f_Create_new_library: STRING_GENERAL is		do Result := locale.translation("Add a library")	end
	f_Create_new_assembly: STRING_GENERAL is	do Result := locale.translation("Add an assembly")	end
	f_Create_new_precompile: STRING_GENERAL is 	do Result := locale.translation("Add a precompile")	end
	f_Create_new_class: STRING_GENERAL is		do Result := locale.translation("Create a new class")	end
	f_Create_new_feature: STRING_GENERAL is		do Result := locale.translation("Create a new feature")	end
	f_create_new_watch: STRING_GENERAL is		do Result := locale.translation ("Create new watch") end
	f_clear_watch_tool_expressions: STRING_GENERAL is		do Result := locale.translation ("Clear expressions") end

	m_Dbg_assertion_checking_disable: STRING_GENERAL is	do Result := locale.translation("Disable Assertion Checking")	end
	m_Dbg_assertion_checking_restore: STRING_GENERAL is	do Result := locale.translation("Restore Assertion Checking")	end
	m_Dbg_exception_handler: STRING_GENERAL is	do Result := locale.translation("Exception Handling")	end
	m_Debug_interrupt_new: STRING_GENERAL is		do Result := locale.translation("I&nterrupt Execution")	end
	f_Debug_edit_object: STRING_GENERAL is		do Result := locale.translation("Edit Object content")	end
	m_Debug_edit_object: STRING_GENERAL is		do Result := locale.translation("Edit Object Content")	end
	f_Debug_dynamic_eval: STRING_GENERAL is		do Result := locale.translation("Dynamic feature evaluation")	end
	m_Debug_dynamic_eval: STRING_GENERAL is		do Result := locale.translation("Dynamic Feature Evaluation")	end
	m_Debug_kill: STRING_GENERAL is				do Result := locale.translation("&Stop Execution")	end
	f_Debug_run: STRING_GENERAL is				do Result := locale.translation("Run")	end
	m_Debug_run: STRING_GENERAL is				do Result := locale.translation("&Run%TCtrl+R")	end
	m_Debug_run_new: STRING_GENERAL is			do Result := locale.translation("St&art")	end
	m_Debug_run_continue: STRING_GENERAL is		do Result := locale.translation("Continue")	end

	m_Force_debug_mode: STRING_GENERAL is		do Result := locale.translation("Force Debug Mode")	end
	m_Launch_With_Arguments: STRING_GENERAL is	do Result := locale.translation("Start With Arguments")	end
	f_diagram_delete: STRING_GENERAL is			do Result := locale.translation("Delete")	end
	l_data: STRING_GENERAL is					do Result := locale.translation("Data")	end
	l_details: STRING_GENERAL is				do Result := locale.translation("Details") end
	l_diagram_delete: STRING_GENERAL is			do Result := locale.translation("Delete graphical items, remove code from system")	end
	f_diagram_crop: STRING_GENERAL is			do Result := locale.translation("Crop diagram")	end
	m_diagram_crop: STRING_GENERAL is			do Result := locale.translation("&Crop Diagram")	end
	f_diagram_zoom_out: STRING_GENERAL is		do Result := locale.translation("Zoom out")	end
	f_diagram_put_right_angles: STRING_GENERAL is		do Result := locale.translation("Force right angles")	end
	f_diagram_remove_right_angles: STRING_GENERAL is	do Result := locale.translation("Remove right angles")	end
	m_diagram_link_tool: STRING_GENERAL is		do Result := locale.translation("&Put Right Angles")	end
	f_diagram_to_png: STRING_GENERAL is			do Result := locale.translation("Export diagram to PNG")	end
	m_diagram_to_png: STRING_GENERAL is			do Result := locale.translation("&Export Diagram to PNG")	end
	f_diagram_context_depth: STRING_GENERAL is  do Result := locale.translation("Select depth of relations")	end
	m_diagram_context_depth: STRING_GENERAL is  do Result := locale.translation("&Select Depth of Relations")	end
	f_diagram_delete_view: STRING_GENERAL is		do Result := locale.translation("Delete current view")	end
	f_diagram_reset_view: STRING_GENERAL is 		do Result := locale.translation("Reset current view")	end
	m_diagram_delete_view: STRING_GENERAL is		do Result := locale.translation("&Delete Current View")	end
	m_diagram_reset_view: STRING_GENERAL is		do Result := locale.translation("&Reset Current View")	end
	f_diagram_zoom_in: STRING_GENERAL is			do Result := locale.translation("Zoom in")	end
	f_diagram_fit_to_screen: STRING_GENERAL is	do Result := locale.translation("Fit to screen")	end
	f_diagram_undo: STRING_GENERAL is			do Result := locale.translation("Undo last action")	end
	f_diagram_hide_supplier: STRING_GENERAL is	do Result := locale.translation("Hide supplier links")	end
	f_diagram_show_supplier: STRING_GENERAL is	do Result := locale.translation("Show supplier links")	end

	l_diagram_supplier_visibility: STRING_GENERAL is do Result := locale.translation("Toggle visibility of supplier links")	end

	l_diagram_add_ancestors: STRING_GENERAL is do Result := locale.translation("Add class ancestors to diagram")	end
	l_diagram_add_descendents: STRING_GENERAL is do Result := locale.translation("Add class descendants to diagram")	end
	l_diagram_add_suppliers: STRING_GENERAL is do Result := locale.translation("Add class suppliers to diagram")	end
	l_diagram_add_clients: STRING_GENERAL is do Result := locale.translation("Add class clients to diagram")	end

	f_diagram_hide_labels: STRING_GENERAL is		do Result := locale.translation("Hide labels")	end
	f_diagram_show_labels: STRING_GENERAL is		do Result := locale.translation("Show labels")	end
	f_diagram_show_uml: STRING_GENERAL is		do Result := locale.translation("Show UML")	end
	f_diagram_show_bon: STRING_GENERAL is 		do Result := locale.translation("Show BON")	end
	f_diagram_hide_clusters: STRING_GENERAL is	do Result := locale.translation("Hide clusters")	end
	f_diagram_show_clusters: STRING_GENERAL is	do Result := locale.translation("Show clusters")	end
	f_diagram_show_legend: STRING_GENERAL is		do Result := locale.translation("Show cluster legend")	end
	f_diagram_hide_legend: STRING_GENERAL is		do Result := locale.translation("Hide cluster legend")	end
	f_diagram_remove_anchor: STRING_GENERAL is	do Result := locale.translation("Remove anchor")	end
	l_diagram_labels_visibility: STRING_GENERAL is	do Result := locale.translation("Toggle visibility of client link labels")	end
	l_diagram_uml_visibility: STRING_GENERAL is	do Result := locale.translation("Toggle between UML and BON view")	end
	l_diagram_clusters_visibility: STRING_GENERAL is	do Result := locale.translation("Toggle visibility of clusters")	end
	l_diagram_legend_visibility: STRING_GENERAL is	do Result := locale.translation("Toggle visibility of cluster legend")	end
	l_diagram_remove_anchor: STRING_GENERAL is	do Result := locale.translation("Remove anchor")	end
	l_diagram_force_directed: STRING_GENERAL is	do Result := locale.translation("Turn on/off physics")	end
	l_diagram_toggle_quality: STRING_GENERAL is	do Result := locale.translation("Toggle quality level")	end
	f_diagram_high_quality: STRING_GENERAL is 	do Result := locale.translation("Switch to high quality")	end
	f_diagram_low_quality: STRING_GENERAL is 	do Result := locale.translation("Switch to low quality")	end
	f_diagram_hide_inheritance: STRING_GENERAL is	do Result := locale.translation("Hide inheritance links")	end
	f_diagram_show_inheritance: STRING_GENERAL is	do Result := locale.translation("Show inheritance links")	end
	l_diagram_inheritance_visibility: STRING_GENERAL is do Result := locale.translation("Toggle visibility of inheritance links")	end
	f_diagram_redo: STRING_GENERAL is			do Result := locale.translation("Redo last action")	end
	f_diagram_fill_cluster: STRING_GENERAL is	do Result := locale.translation("Include all classes of cluster")	end
	f_diagram_history: STRING_GENERAL is		do Result := locale.translation("History tool")	end
	f_diagram_remove: STRING_GENERAL is			do Result := locale.translation("Hide figure")	end
	l_diagram_remove: STRING_GENERAL is			do Result := locale.translation("Delete graphical items")	end
	f_diagram_create_supplier_links: STRING_GENERAL is	do Result := locale.translation("Create new client-supplier links")	end
	f_diagram_create_aggregate_supplier_links: STRING_GENERAL is do Result := locale.translation("Create new aggregate client-supplier links")	end
	f_diagram_create_inheritance_links: STRING_GENERAL is do Result := locale.translation("Create new inheritance links")	end
	l_diagram_create_links: STRING_GENERAL is	do Result := locale.translation("Select type of new links")	end
	f_diagram_new_class: STRING_GENERAL is		do Result := locale.translation("Create a new class")	end
	f_diagram_change_header: STRING_GENERAL is	do Result := locale.translation("Change class name and generics")	end
	f_diagram_change_color: STRING_GENERAL is	do Result := locale.translation("Change color")	end
	f_diagram_force_directed_on: STRING_GENERAL is	do Result := locale.translation("Turn on physics")	end
	f_diagram_force_directed_off: STRING_GENERAL is	do Result := locale.translation("Turn off physics")	end
	f_diagram_force_settings: STRING_GENERAL is	do Result := locale.translation("Show physics settings dialog")	end
	f_Disable_stop_points: STRING_GENERAL is	do Result := locale.translation("Disable all breakpoints")	end
	f_display_breakpoints: STRING_GENERAL is	do Result := locale.translation("Display breakpoints separated by status")	end
	f_display_breakpoints_sep_by_status: STRING_GENERAL is	do Result := locale.translation("Display breakpoints separated by status")	end
	m_Disable_stop_points: STRING_GENERAL is	do Result := locale.translation("&Disable All Breakpoints")	end
	m_Debug_block: STRING_GENERAL is			do Result := locale.translation("E&mbed in %"Debug...%"%TCtrl+D")	end
	m_Execution_parameters: STRING_GENERAL is	do Result := locale.translation ("Execution &Parameters") end
	m_Editor: STRING_GENERAL is					do Result := locale.translation("&Editor")	end
	m_Eiffel_introduction: STRING_GENERAL is	do Result := locale.translation("&Introduction to Eiffel")	end
	f_Enable_stop_points: STRING_GENERAL is		do Result := locale.translation("Enable all breakpoints")	end
	m_Enable_stop_points: STRING_GENERAL is		do Result := locale.translation("&Enable All Breakpoints")	end
	m_environment_variables: STRING_GENERAL is		do Result := locale.translation("Environment variables")	end
	m_Exec_last: STRING_GENERAL is				do Result := locale.translation("&Out of Routine")	end
	m_Exec_nostop: STRING_GENERAL is			do Result := locale.translation("&Ignore Breakpoints")	end
	m_Exec_step: STRING_GENERAL is				do Result := locale.translation("&Step-by-Step")	end
	m_Exec_into: STRING_GENERAL is				do Result := locale.translation("Step In&to")	end
	m_Exit_project: STRING_GENERAL is			do Result := locale.translation("E&xit")	end
	m_Explorer_bar: STRING_GENERAL is			do Result := locale.translation("&Tools")	end
	m_Explorer_bar_item: STRING is do Result := locale.translation ("Explorer bar item") end
	m_Export_to: STRING_GENERAL is				do Result := locale.translation("Save Cop&y As...")	end
	m_Export_XMI: STRING_GENERAL is 			do Result := locale.translation("E&xport XMI...")	end
	m_Expression_evaluation: STRING_GENERAL is	do Result := locale.translation("Expression Evaluation")	end
	m_External_editor: STRING_GENERAL is		do Result := locale.translation("External E&ditor")	end
	m_Favorites_tool: STRING_GENERAL is			do Result := locale.translation("F&avorites")	end
	m_Features_tool: STRING_GENERAL is			do Result := locale.translation("&Features")	end
	m_threads_tool: STRING_GENERAL is			do Result := locale.translation ("Threads") end
	f_Finalize: STRING_GENERAL is				do Result := locale.translation("Finalize...")	end
	m_Finalize_new: STRING_GENERAL is			do Result := locale.translation("Finali&ze...")	end
	m_Find: STRING_GENERAL is					do Result := locale.translation("&Search")	end
	m_Find_next: STRING_GENERAL is				do Result := locale.translation("Find &Next")	end
	m_Find_previous: STRING_GENERAL is			do Result := locale.translation("Find &Previous")	end
	m_Find_next_selection: STRING_GENERAL is	do Result := locale.translation("Find Next &Selection")	end
	m_Find_previous_selection: STRING_GENERAL is do Result := locale.translation("Find P&revious Selection")	end
	f_Freeze: STRING_GENERAL is					do Result := locale.translation("Freeze...")	end
	m_Freeze_new: STRING_GENERAL is				do Result := locale.translation("&Freeze...")	end
	m_General_toolbar: STRING_GENERAL is		do Result := locale.translation("&Standard Buttons")	end
	m_Generate_documentation: STRING_GENERAL is do Result := locale.translation("Generate &Documentation...")	end
	m_Go_to: STRING_GENERAL is					do Result := locale.translation("&Go to...")	end
	m_Guided_tour: STRING_GENERAL is			do Result := locale.translation("&Guided Tour")	end
	m_grid_name (a_name: STRING_GENERAL): STRING_GENERAL is
		do Result := locale.formatted_string (locale.translation ("Grid %"$1%""), [a_name]) end
	m_Help: STRING_GENERAL is					do Result := locale.translation("&Help")	end
	m_Hide_favorites: STRING_GENERAL is			do Result := locale.translation("&Hide Favorites")	end
	m_Hide_formatting_marks: STRING_GENERAL is	do Result := locale.translation("&Hide Formatting Marks")	end
	m_History_forth: STRING_GENERAL is			do Result := locale.translation("&Forward")	end
	m_History_back: STRING_GENERAL is			do Result := locale.translation("&Back")	end
	f_History_forth: STRING_GENERAL is			do Result := locale.translation("Go forth")	end
	f_History_back: STRING_GENERAL is			do Result := locale.translation("Go back")	end
	m_How_to_s: STRING_GENERAL is				do Result := locale.translation("&How to's")	end
	m_If_block: STRING_GENERAL is				do Result := locale.translation("&Embed in %"if...%"%TCtrl+I")	end
	m_Indent: STRING_GENERAL is					do Result := locale.translation("&Indent Selection%TTab")	end
	m_keep_grid_layout: STRING_GENERAL is					do Result := locale.translation("Keep grid layout")	end
	m_Line_numbers: STRING_GENERAL is			do Result := locale.translation("Toggle &Line Numbers")	end
	m_lock_tool_bar: STRING_GENERAL is			do Result := locale.translation ("Lock the Toolbars") end
	m_lock_docking: STRING_GENERAL is			do Result := locale.translation ("Lock the Tools") end
	m_lock_docking_editor: STRING_GENERAL is	do Result := locale.translation ("Lock the Editors") end
	f_match_case_question: STRING_GENERAL is	do Result := locale.translation("Match case?")	end
	f_Melt: STRING_GENERAL is					do Result := locale.translation("Compile current project")	end
	m_Melt_new: STRING_GENERAL is				do Result := locale.translation("&Compile")	end
	m_New: STRING_GENERAL is					do Result := locale.translation("&New")	end
	l_new_name: STRING_GENERAL is				do Result := locale.translation("New Name:")	end
	f_New_window: STRING_GENERAL is				do Result := locale.translation("Create a new window")	end
	m_New_window: STRING_GENERAL is				do Result := locale.translation("New &Window")	end
	m_New_dynamic_lib: STRING_GENERAL is		do Result := locale.translation("&Dynamic Library Builder...")	end
	m_New_project: STRING_GENERAL is			do Result := locale.translation("&New Project...")	end
	f_move_item_up: STRING_GENERAL is				do Result := locale.translation ("Move item up") end
	f_move_item_down: STRING_GENERAL is				do Result := locale.translation ("Move item down") end
	m_Ok: STRING_GENERAL is						do Result := locale.translation("&OK")	end
	m_Open: STRING_GENERAL is					do Result := locale.translation("&Open...%TCtrl+O")	end
	m_open_layout: STRING_GENERAL is do Result := locale.translation ("Open Layout") end
	m_Open_new: STRING_GENERAL is				do Result := locale.translation("Op&en...")	end
	m_Open_project: STRING_GENERAL is			do Result := locale.translation("&Open Project...")	end
	f_Open_watch_tool_menu: STRING_GENERAL is 	do Result := locale.translation ("Open Watch tool menu") end
	f_Open_object_tool_menu: STRING_GENERAL is	do Result := locale.translation ("Open Objects tool menu") end
	m_objects_tool_layout_menu_title: STRING_GENERAL is	do Result := locale.translation ("Objects Tool") end
	m_objects_tool_layout_editor_title: STRING_GENERAL is	do Result := locale.translation ("Edit Layout") end
	m_objects_tool_layout_reset: STRING_GENERAL is	do Result := locale.translation ("Reset To Default") end
	m_objects_tool_layout_add_all: STRING_GENERAL is	do Result := locale.translation ("Add All") end
	m_objects_tool_layout_remove_all: STRING_GENERAL is	do Result := locale.translation ("Remove All") end
	f_original_value_is (k, s: STRING_GENERAL): STRING_GENERAL is
		require
			k_not_void: k /= Void
			s_not_void: s /= Void
		do
			Result := locale.formatted_string (locale.translation ("Original value is %"$1=$2%""), [k, s])
		end

	m_Organize_favorites: STRING_GENERAL is		do Result := locale.translation("&Organize Favorites...")	end
	m_Output: STRING_GENERAL is					do Result := locale.translation("&Output")	end
	f_Paste: STRING_GENERAL is					do Result := locale.translation("Paste (Ctrl+V)")	end
	m_Paste: STRING_GENERAL is					do Result := locale.translation("&Paste%TCtrl+V")	end
	m_Precompile_new: STRING_GENERAL is			do Result := locale.translation("&Precompile")	end
	f_Print: STRING_GENERAL is					do Result := locale.translation("Print")	end
	m_Print: STRING_GENERAL is					do Result := locale.translation("&Print")	end
	f_preferences: STRING_GENERAL is			do Result := locale.translation("Preferences")	end
	m_Preferences: STRING_GENERAL is			do Result := locale.translation("&Preferences...")	end
	m_Properties_tool: STRING_GENERAL is		do Result := locale.translation("Pr&operties")	end
	m_Profile_tool: STRING_GENERAL is			do Result := locale.translation("Pro&filer...")	end
	m_Project_toolbar: STRING_GENERAL is		do Result := locale.translation("&Project Bar")	end
	m_Refactoring_toolbar: STRING_GENERAL is	do Result := locale.translation("Re&factoring Bar")	end
	f_refactoring_pull: STRING_GENERAL is		do Result := locale.translation("Pull up Feature")	end
	f_refactoring_rename: STRING_GENERAL is		do Result := locale.translation("Rename Feature/Class")	end
	f_refactoring_undo: STRING_GENERAL is		do Result := locale.translation("Undo Last Refactoring (only works as long as no file that was refactored has been changed by hand)")	end
	f_refactoring_redo: STRING_GENERAL is		do Result := locale.translation("Redo Last Refactoring (only works as long as no file that was refactored has been changed by hand)")	end
	b_refactoring_pull: STRING_GENERAL is		do Result := locale.translation("Pull Up")	end
	b_refactoring_rename: STRING_GENERAL is		do Result := locale.translation("Rename")	end
	b_refactoring_undo: STRING_GENERAL is		do Result := locale.translation("Undo Refactoring")	end
	b_refactoring_redo: STRING_GENERAL is		do Result := locale.translation("Redo Refactoring")	end
	l_rename_file: STRING_GENERAL is			do Result := locale.translation("Rename File")	end
	l_regexp: STRING_GENERAL is					do Result := locale.translation("Regexp")	end
	l_replace_comments: STRING_GENERAL is		do Result := locale.translation("Replace Name in Comments")	end
	l_replace_strings: STRING_GENERAL is		do Result := locale.translation("Replace Name in Strings")	end
	m_Recent_project: STRING_GENERAL is			do Result := locale.translation("&Recent Projects")	end
	m_Redo: STRING_GENERAL is					do Result := locale.translation("Re&do%TCtrl+Y")	end
	f_Redo: STRING_GENERAL is					do Result := locale.translation("Redo (Ctrl+Y)")	end
	m_Restore_Editor_Area: STRING_GENERAL is	do Result := locale.translation("&Restore Editor Area")	end
	m_Restore_Editors: STRING_GENERAL is		do Result := locale.translation("&Restore Editors")	end
	m_Replace: STRING_GENERAL is				do Result := locale.translation("&Replace...")	end
	m_reset_layout: STRING_GENERAL is do Result := locale.translation ("Reset Tools layout") end
	f_Retarget_diagram: STRING_GENERAL is		do Result := locale.translation("Target to cluster or class")	end
	f_Run_finalized: STRING_GENERAL is			do Result := locale.translation("Run finalized system")	end
	m_Run_finalized: STRING_GENERAL is			do Result := locale.translation("&Run Finalized System")	end
	f_Run_workbench: STRING_GENERAL is			do Result := locale.translation("Run workbench system")	end
	m_Run_workbench: STRING_GENERAL is			do Result := locale.translation("&Run Workbench System")	end
	f_Save: STRING_GENERAL is					do Result := locale.translation("Save")	end
	m_Save_new: STRING_GENERAL is				do Result := locale.translation("&Save")	end
	m_Save_As: STRING_GENERAL is				do Result := locale.translation("S&ave As...")	end
	f_Save_all: STRING_GENERAL is 				do Result := locale.translation("Save All")	end
	m_Save_All: STRING_GENERAL is 				do Result := locale.translation("Save &All")	end
	m_save_layout_as: STRING_GENERAL is do Result := locale.translation ("Save Layout As...") end
	m_Search: STRING_GENERAL is					do Result := locale.translation("&Find...")	end
	m_Search_tool: STRING_GENERAL is			do Result := locale.translation("&Search")	end
	m_Select_all: STRING_GENERAL is				do Result := locale.translation("Select &All%TCtrl+A")	end
	m_Send_to: STRING_GENERAL is				do Result := locale.translation("Sen&d to")	end
	m_set_default_layout: STRING_GENERAL is do Result := locale.translation ("Set Current Layout As Default") end
	m_show_assigners: STRING_GENERAL is			do Result := locale.translation("A&ssigners")	end
	m_Show_class_cluster: STRING_GENERAL is		do Result := locale.translation("Find in Cluster Tree")	end
	m_show_creators: STRING_GENERAL is			do Result := locale.translation("C&reators")	end
	m_Show_favorites: STRING_GENERAL is			do Result := locale.translation("&Show Favorites")	end
	m_Show_formatting_marks: STRING_GENERAL is		do Result := locale.translation("&Show Formatting Marks")	end
	f_show_tool (a_tool_name: STRING_GENERAL): STRING_GENERAL is do	Result := locale.formatted_string (locale.translation ("Show $1"), [a_tool_name]) end
	m_Showancestors: STRING_GENERAL is			do Result := locale.translation("&Ancestors")	end
	m_Showattributes: STRING_GENERAL is			do Result := locale.translation("A&ttributes")	end
	m_Showcallers: STRING_GENERAL is			do Result := locale.translation("&Callers")	end
	m_Showcallees: STRING_GENERAL is 		do Result := locale.translation("Call&ees")	end
	m_Show_creation: STRING_GENERAL is 		do Result := locale.translation("Creat&ions")	end
	m_Show_assignees: STRING_GENERAL is 		do Result := locale.translation("&Assignees")	end
	m_Showclick: STRING_GENERAL is				do Result := locale.translation("C&lickable")	end
	m_Showclients: STRING_GENERAL is			do Result := locale.translation("Cli&ents")	end
	m_showcreators: STRING_GENERAL is			do Result := locale.translation("&Creators")	end
	m_Showdeferreds: STRING_GENERAL is			do Result := locale.translation("&Deferred")	end
	m_Showdescendants: STRING_GENERAL is		do Result := locale.translation("De&scendants")	end
	m_Showexported: STRING_GENERAL is			do Result := locale.translation("Ex&ported")	end
	m_Showexternals: STRING_GENERAL is			do Result := locale.translation("E&xternals")	end
	m_Showflat: STRING_GENERAL is				do Result := locale.translation("&Flat")	end
	m_Showfs: STRING_GENERAL is					do Result := locale.translation("&Interface")	end
	m_Showfuture: STRING_GENERAL is				do Result := locale.translation("&Descendant Versions")	end
	m_Showhistory: STRING_GENERAL is			do Result := locale.translation("&Implementers")	end
	m_Showindexing: STRING_GENERAL is			do Result := locale.translation("&Indexing clauses")	end
	m_show_invariants: STRING_GENERAL is		do Result := locale.translation("In&variants")	end
	m_Showonces: STRING_GENERAL is				do Result := locale.translation("O&nce/Constants")	end
	m_Showpast: STRING_GENERAL is				do Result := locale.translation("&Ancestor Versions")	end
	m_Showroutines: STRING_GENERAL is			do Result := locale.translation("&Routines")	end
	m_Showshort: STRING_GENERAL is				do Result := locale.translation("C&ontract")	end
	m_Showhomonyms: STRING_GENERAL is			do Result := locale.translation("&Homonyms")	end
	m_Showsuppliers: STRING_GENERAL is			do Result := locale.translation("S&uppliers")	end
	m_Showtext_new: STRING_GENERAL is			do Result := locale.translation("Te&xt")	end
	m_System_new: STRING_GENERAL is				do Result := locale.translation("Project &Settings...")	end
	m_Toolbars: STRING_GENERAL is				do Result := locale.translation("Tool&bars")	end
	m_To_lower: STRING_GENERAL is				do Result := locale.translation("Set to &Lowercase")	end
	m_To_upper: STRING_GENERAL is				do Result := locale.translation("Set to U&ppercase")	end
	m_Uncomment: STRING_GENERAL is				do Result := locale.translation("U&ncomment")	end
	f_Uncomment: STRING_GENERAL is				do Result := locale.translation("Uncomment selected lines")	end
	m_Undo: STRING_GENERAL is					do Result := locale.translation("&Undo%TCtrl+Z")	end
	f_Undo: STRING_GENERAL is					do Result := locale.translation("Undo (Ctrl+Z)")	end
	m_Unindent: STRING_GENERAL is				do Result := locale.translation("&Unindent Selection%TShift+Tab")	end
	f_use_regular_expression_question: STRING_GENERAL is do Result := locale.translation("Use regular expression?")	end
	m_Windows_tool: STRING_GENERAL is			do Result := locale.translation("&Windows")	end
	m_Watch_tool: STRING_GENERAL is				do Result := locale.translation("Watch Tool")	end
	m_Wizard_precompile: STRING_GENERAL is 		do Result := locale.translation("Precompilation &Wizard...")	end
	m_use_current_environment_variables: STRING_GENERAL is 		do Result := locale.translation("Use current environment variables")	end
	m_use_current_environment_value: STRING_GENERAL is 		do Result := locale.translation("Use current environment value")	end
	f_Wizard_precompile: STRING_GENERAL is		do Result := locale.translation("Wizard to precompile libraries")	end
	f_go_to_first_occurrence: STRING_GENERAL is do Result := locale.translation("Double click to go to first occurrence")	end
	f_show: STRING_GENERAL is do Result := locale.translation ("Show ") end
	f_hide: STRING_GENERAL is do Result := locale.translation ("Hide ") end
	f_switch_to_tree_view: STRING_GENERAL is do Result := locale.translation ("Switch to Tree View") end
	f_switch_to_flat_view: STRING_GENERAL is do Result := locale.translation ("Switch to Flat View") end
	l_choose_class_version: STRING_GENERAL is do Result := locale.translation ("Choose one version from the following:") end
	m_restart_application: STRING_GENERAL is do Result := locale.translation ("Restart application") end
	f_restart_application: STRING_GENERAL is do Result := locale.translation ("Restart application") end
	t_setup_customized_formatter: STRING_GENERAL is do Result := locale.translation ("Setup Customized Formatters") end
	f_customize_formatter: STRING_GENERAL is do Result := locale.translation ("Customize formatters") end
	f_add_formatter: STRING_GENERAL is do Result := locale.translation ("Add customized formatter") end
	f_remove_formatter: STRING_GENERAL is do Result := locale.translation ("Remove selected customized formatter") end
	l_formatter: STRING_GENERAL is do Result := locale.translation ("Formatter") end
	l_displayed_in: STRING_GENERAL is do Result := locale.translation ("Displayed in") end
	t_tool_name: STRING_GENERAL is do Result := locale.translation ("Tool") end
	t_formatter_displayer_name: STRING_GENERAL is do Result := locale.translation ("Formatter displayer") end
	l_display: STRING_GENERAL is do Result := locale.translation ("Display?") end
	l_select_formatter: STRING_GENERAL is do Result := locale.translation ("Please select a formatter.") end
	t_setup_formatter_tools (a_formatter_name: STRING_GENERAL): STRING_GENERAL is
		require
			a_formatter_name_attached: a_formatter_name /= Void
		do
			Result := locale.formatted_string (locale.translation ("Setup tools for formatter %"$1%""), [a_formatter_name])
		end
	t_customized_tool_setup: STRING_GENERAL is do Result := locale.translation ("Setup Customized Tools") end
	t_setup_customized_tool: STRING_GENERAL is do Result := locale.translation ("Setup customized tools") end
	l_select_tool: STRING_GENERAL is do Result := locale.translation ("Please select a tool.") end
	f_add_tool: STRING_GENERAL is do Result := locale.translation ("Add customized tool") end
	f_remove_tool: STRING_GENERAL is do Result := locale.translation ("Remove selected customized tool") end
	l_no_info_of_element: STRING_GENERAL is do Result := locale.translation ("Please select a programming element (target/group/class/feature...).") end
	l_setup_stone_handler (l_tool_name: STRING_GENERAL): STRING_GENERAL
		do
			Result := locale.formatted_string (locale.translation ("Setup stone handlers for tool %"$1%""), [l_tool_name])
		end
	l_stone_name: STRING_GENERAL is do Result := locale.translation ("Stone name") end
	l_feature_stone_name: STRING_GENERAL is do Result := locale.translation ("Feature stone") end
	l_uncompiled_class_stone_name: STRING_GENERAL is do Result := locale.translation ("Uncompiled class stone") end
	l_compiled_class_stone_name: STRING_GENERAL is do Result := locale.translation ("Compiled class stone") end
	l_group_stone_name: STRING_GENERAL is do Result := locale.translation ("Group stone") end
	l_target_stone_name: STRING_GENERAL is do Result := locale.translation ("Target stone") end

	m_Activate_execution_recording: STRING_GENERAL is 		do Result := locale.translation("Activate Execution Recording")	end
	m_Deactivate_execution_recording: STRING_GENERAL is 	do Result := locale.translation("Deactivate Execution Recording")	end
	m_Activate_execution_replay_mode: STRING_GENERAL is 		do Result := locale.translation("Activate Replay Mode")	end
	m_Deactivate_execution_replay_mode: STRING_GENERAL is 	do Result := locale.translation("Deactivate Replay Mode")	end

	m_Exec_replay_back: STRING_GENERAL is	do Result := locale.translation("Replay Execution Back")	end
	m_Exec_replay_forth: STRING_GENERAL is	do Result := locale.translation("Replay Execution Forth")	end
	m_Exec_replay_left: STRING_GENERAL is	do Result := locale.translation("Replay Execution Left")	end
	m_Exec_replay_right: STRING_GENERAL is	do Result := locale.translation("Replay Execution Right")	end


	m_Control_debuggee_object_storage: STRING_GENERAL is	do Result := locale.translation("Control Debuggee Object Storage")	end
	m_Save_debuggee_object: STRING_GENERAL is	do Result := locale.translation("Save Debuggee Object")	end

feature -- Menu entries

	m_go_to_next_error: STRING_GENERAL is 				do Result := locale.translation ("Go to Next &Error") end
	m_go_to_previous_error: STRING_GENERAL is 			do Result := locale.translation ("Go to Previous E&rror") end
	m_go_to_next_warning: STRING_GENERAL is 			do Result := locale.translation ("Go to Next &Warning") end
	m_go_to_previous_warning: STRING_GENERAL is 		do Result := locale.translation ("Go to Previous War&ning") end

feature -- Tool tips

	f_go_to_next_error: STRING_GENERAL is 				do Result := locale.translation ("Navigates to the next error or the first error found if the end of the list is reached") end
	f_go_to_previous_error: STRING_GENERAL is 			do Result := locale.translation ("Navigates to the previous error or the last error found if the start of the list is reached") end
	f_go_to_next_warning: STRING_GENERAL is 			do Result := locale.translation ("Navigates to the next warning or the first warning found if the end of the list is reached") end
	f_go_to_previous_warning: STRING_GENERAL is 		do Result := locale.translation ("Navigates to the previous warning or the last warning found if the start of the list is reached") end
	f_filter_warnings: STRING_GENERAL is 				do Result := locale.translation ("Filter shown and navigatable warnings") end
	f_toogle_expand_errors: STRING_GENERAL is do Result := locale.translation("Automatically expands errors to reveal the full verbose error information.")	end

	f_stack_information: STRING_GENERAL is 		do Result := locale.translation ("Specific information related to current call stack (exception,...)") end
	f_current_object: STRING_GENERAL is 		do Result := locale.translation ("`Current' object associated to selected call stack element") end
	f_arguments: STRING_GENERAL is 				do Result := locale.translation ("Arguments value(s) associated to selected call stack element") end
	f_locals: STRING_GENERAL is 				do Result := locale.translation ("Locals value(s) associated to selected call stack element") end
	f_result: STRING_GENERAL is 				do Result := locale.translation ("`Result' value associated to selected call stack element") end
	f_dropped_references: STRING_GENERAL is 	do Result := locale.translation ("Debugged object dropped onto Objects tool") end

feature -- Formatter displayer names

	l_class_tree_displayer_help: STRING_GENERAL do Result := locale.translation ("This view is suitable for displaying class hierarchy%Nsuch as class ancestors/descendants") end
	l_class_flat_displayer_help: STRING_GENERAL do Result := locale.translation ("This view is suitable for displaying class list%Nsuch as class clients/suppliers") end
	l_class_feature_displayer_help: STRING_GENERAL do Result := locale.translation ("This view is suitable for displaying features in form of list from a class%Nsuch as attributes/routines") end
	l_feature_displayer_help: STRING_GENERAL do Result := locale.translation ("This view is suitable for displaying different versions of a feature%Nsuch as feature implementors/ancestor versions/descendant versions") end
	l_feature_caller_displayer_help: STRING_GENERAL do Result := locale.translation ("This view is suitable for displaying feature callers") end
	l_feature_callee_displayer_help: STRING_GENERAL do Result := locale.translation ("This view is suitable for displaying feature callees") end
	l_domain_displayer_help: STRING_GENERAL do Result := locale.translation ("This view can be used to display result of all formatters%Nthus it is used as a default view for formatters") end

	l_class_tree_displayer: STRING_GENERAL do Result := locale.translation ("Class tree view") end
	l_class_flat_displayer: STRING_GENERAL do Result := locale.translation ("Class list view") end
	l_class_feature_displayer: STRING_GENERAL do Result := locale.translation ("Feature list view") end
	l_feature_displayer: STRING_GENERAL do Result := locale.translation ("Feature version view") end

	l_feature_caller_displayer: STRING_GENERAL do Result := locale.translation ("Feature caller view") end
	l_feature_callee_displayer: STRING_GENERAL do Result := locale.translation ("Feature callee view") end
	l_dependency_displayer: STRING_GENERAL do Result := locale.translation ("Dependency view") end
	l_domain_displayer: STRING_GENERAL do Result := locale.translation ("Domain view") end

	l_formatter_header_help: STRING_GENERAL do Result := locale.translation ("Message that will be displayed in the formatter view when calculation has finished.") end
	l_formatter_placeholder: STRING_GENERAL do Result := locale.translation ("%"$target%" serves as a placeholder which will be replaced by the input to current formatter.") end
	l_formatter_temp_header_help: STRING_GENERAL do Result := locale.translation ("Message that will be displayed in the formatter view when calculation is going on.") end
	l_formatter_filter_help: STRING_GENERAL do Result := locale.translation ("Display non visible items?") end
	l_formatter_scope_help: STRING_GENERAL do Result := locale.translation ("Is this formatter of per EiffelStudio scope or per target scope?") end
	l_formatter_displayed_in_help: STRING_GENERAL do Result := locale.translation ("In which tool(s) will this formatter be displayed") end
	l_formatter_metric_help: STRING_GENERAL do Result := locale.translation ("From the result of which metric is this formatter generated?") end
	l_formatter_default_header (l_ellipse: STRING_GENERAL): STRING_GENERAL
		do
			Result := locale.formatted_string (locale.translation ("$1 from $target"), [l_ellipse])
		end
	l_formatter_default_temp_header (l_ellipse: STRING_GENERAL): STRING_GENERAL
		do
			Result := locale.formatted_string (locale.translation ("Extracting $1 from $target ..."), [l_ellipse])
		end

	l_formatter_invalid_metric: STRING_GENERAL do Result := locale.translation ("Specified metric is not defined or invalid, this will cause current formatter not usable") end
	l_add_stone_handler: STRING_GENERAL is do Result := locale.translation ("Add new stone handler") end
	l_remove_stone_handler: STRING_GENERAL is do Result := locale.translation ("Remove selected stone handler") end
	l_stone_handler: STRING_GENERAL is do Result := locale.translation ("Stone handler") end
	l_stone_handler_help: STRING_GENERAL is do Result := locale.translation ("Specify default tools for specific stones") end

feature -- Toggles

	f_hide_alias: STRING_GENERAL is			do Result := locale.translation("Hide Alias Name")	end
	f_hide_assigner: STRING_GENERAL is		do Result := locale.translation("Hide Assigner Command Name")	end
	f_hide_signature: STRING_GENERAL is		do Result := locale.translation("Hide Signature")	end
	f_show_alias: STRING_GENERAL is			do Result := locale.translation("Show Alias Name")	end
	f_show_assigner: STRING_GENERAL is		do Result := locale.translation("Show Assigner Command Name")	end
	f_show_signature: STRING_GENERAL is		do Result := locale.translation("Show Signature")	end
	l_toggle_alias: STRING_GENERAL is		do Result := locale.translation("Toggle visibility of feature alias name")	end
	l_toggle_assigner: STRING_GENERAL is	do Result := locale.translation("Toggle visibility of assigner command name")	end
	l_toggle_signature: STRING_GENERAL is	do Result := locale.translation("Toggle visibility of feature signature")	end

feature -- Menu mnenomics

	m_Add_exported_feature: STRING_GENERAL is	do Result := locale.translation("&Add...")	end
	m_Bkpt_info: STRING_GENERAL is				do Result := locale.translation("Brea&kpoint Information")	end
	m_Class_info: STRING_GENERAL is				do Result := locale.translation("Cla&ss Views")	end
	m_Check_exports: STRING_GENERAL is			do Result := locale.translation("Chec&k Export Clauses")	end
	m_Create_new_cluster: STRING_GENERAL is		do Result := locale.translation("Add C&luster...")	end
	m_Create_new_library: STRING_GENERAL is		do Result := locale.translation("Add L&ibrary...")	end
	m_Create_new_precompile: STRING_GENERAL is	do Result := locale.translation("Add &Precompile")	end
	m_Create_new_assembly: STRING_GENERAL is	do Result := locale.translation("Add &Assembly...")	end
	m_Create_new_class: STRING_GENERAL is		do Result := locale.translation("&New Class...")	end
	m_Create_new_feature: STRING_GENERAL is		do Result := locale.translation("New Fea&ture...")	end
	m_Debug: STRING_GENERAL is					do Result := locale.translation("E&xecution")	end
	m_Disable_this_bkpt: STRING_GENERAL is		do Result := locale.translation("&Disable This Breakpoint")	end
	m_Display_error_help: STRING_GENERAL is		do Result := locale.translation("Compilation Error &Wizard...")	end
	m_Display_system_info: STRING_GENERAL is	do Result := locale.translation("S&ystem Info")	end
	m_Edit: STRING_GENERAL is					do Result := locale.translation("&Edit")	end
	m_Edit_condition: STRING_GENERAL is			do Result := locale.translation("E&dit Condition")	end
	m_Edit_execution_parameters: STRING_GENERAL do Result := locale.translation("Edit Execution Parameters")	end
	m_Edit_exported_feature: STRING_GENERAL is	do Result := locale.translation("&Edit...")	end
	m_Edit_external_commands: STRING_GENERAL is	do Result := locale.translation("&External Commands...")	end
	m_Enable_this_bkpt: STRING_GENERAL is		do Result := locale.translation("&Enable This Breakpoint")	end
	m_Favorites: STRING_GENERAL is				do Result := locale.translation("Fav&orites")	end
	m_Feature_info: STRING_GENERAL is			do Result := locale.translation("Feat&ure Views")	end
	m_File: STRING_GENERAL is					do Result := locale.translation("&File")	end
	m_Formats: STRING_GENERAL is				do Result := locale.translation("F&ormat")	end
	m_Formatter_separators: ARRAY [STRING_GENERAL] is
		do
			Result := << locale.translation("Text Generators"), locale.translation("Class Relations"),
				     locale.translation("Restrictors"), locale.translation("Main Editor Views")>>
		end
	m_History: STRING_GENERAL is				do Result := locale.translation("&Go to")	end
	m_Hit_count: STRING_GENERAL is				do Result := locale.translation("Hit Count")	end
	m_Maximize: STRING_GENERAL is				do Result := locale.translation("Ma&ximize")	end
	m_Maximize_Editor_Area: STRING_GENERAL is	do Result := locale.translation("Ma&ximize Editor Area")	end
	m_Minimize: STRING_GENERAL is				do Result := locale.translation("Mi&nimize")	end
	m_Minimize_all: STRING_GENERAL is			do Result := locale.translation("&Minimize All")	end
	m_Minimize_Editors: STRING_GENERAL is		do Result := locale.translation("&Minimize Editors")	end
	f_New_tab: STRING_GENERAL is 				do Result := locale.translation("New Tab")	end
	m_New_tab: STRING_GENERAL is				do Result := locale.translation("New Ta&b")	end
	m_New_editor: STRING_GENERAL is				do Result := locale.translation("New Ed&itor Window")	end
	m_New_context_tool: STRING_GENERAL is		do Result := locale.translation("New Con&text Window")	end
	m_Object: STRING_GENERAL is					do Result := locale.translation("&Object")	end
	m_Object_tools: STRING_GENERAL is			do Result := locale.translation("&Object Tools")	end
	m_Open_eac_browser: STRING_GENERAL is		do Result := locale.translation("EAC Browser")	end
	m_Pretty_print: STRING_GENERAL is			do Result := locale.translation("Expand an Object")	end
	m_Project: STRING_GENERAL is				do Result := locale.translation("&Project")	end
	m_Override_scan: STRING_GENERAL is			do Result := locale.translation("Recompile &Overrides")	end
	m_Discover_melt: STRING_GENERAL is			do Result := locale.translation("Find &Added Classes && Recompile")	end
	m_Raise: STRING_GENERAL is					do Result := locale.translation("&Raise")	end
	m_Raise_all: STRING_GENERAL is				do Result := locale.translation("&Raise All")	end
	m_Raise_all_unsaved: STRING_GENERAL is		do Result := locale.translation("Raise &Unsaved Windows")	end
	m_Remove_class_cluster: STRING_GENERAL is	do Result := locale.translation("&Remove Current Item")	end
	m_Remove_exported_feature: STRING_GENERAL is	do Result := locale.translation("&Remove")	end
	m_Remove_condition: STRING_GENERAL is		do Result := locale.translation("Remove Condition")	end
	m_Remove_this_bkpt: STRING_GENERAL is		do Result := locale.translation("&Remove This Breakpoint")	end
	m_Edit_this_bkpt: STRING_GENERAL is		do Result := locale.translation("&Edit This Breakpoint")	end
	m_Eidt_in_external_editor: STRING is	do Result := locale.translation("&Edit in External Editor") end
	m_Run_to_this_point: STRING_GENERAL is		do Result := locale.translation("&Run to This Point")	end
	m_Send_stone_to_context: STRING_GENERAL is	do Result := locale.translation("S&ynchronize Context Tool")	end
	m_Set_conditional_breakpoint: STRING_GENERAL is do Result := locale.translation("Set &Conditional Breakpoint")	end
	m_Set_critical_stack_depth: STRING_GENERAL is do Result := locale.translation("Overflow &Prevention...")	end
	m_Set_slice_size: STRING_GENERAL is			do Result := locale.translation("&Alter size New")	end
	m_Special: STRING_GENERAL is				do Result := locale.translation("&Special")	end
	m_Separate_stone: STRING_GENERAL is			do Result := locale.translation("Unlin&k Context Tool")	end
	m_Tools: STRING_GENERAL is					do Result := locale.translation("&Tools")	end
	m_Unify_stone: STRING_GENERAL is			do Result := locale.translation("Lin&k Context Tool")	end

	m_When_hits: STRING_GENERAL is				do Result := locale.translation("When Hits ...")	end

	m_Window: STRING_GENERAL is					do Result := locale.translation("&Window")	end
	m_Refactoring: STRING_GENERAL is			do Result := locale.translation("&Refactoring")	end

feature -- Context menu

	m_add_to: STRING_GENERAL is					do Result := locale.translation("&Add to")	end
	m_add_subcluster: STRING_GENERAL is			do Result := locale.translation("Add &subcluster")	end
	m_Assembly: STRING_GENERAL is				do Result := locale.translation ("Assembly") end
	m_center_diagram: STRING_GENERAL is			do Result := locale.translation ("Center target in diagram") end
	m_change_color: STRING_GENERAL is			do Result := locale.translation ("Change color") end
	m_clone_metric: STRING_GENERAL is			do Result := locale.translation ("Clone metric") end
	m_delete: STRING_GENERAL is					do Result := b_delete_command	end
	m_diagram_with: STRING_GENERAL is	do Result := locale.translation ("Diagram with") end
	m_expanded_object_view: STRING_GENERAL is	do Result := locale.translation ("Expanded object view") end
	m_include_all_classes: STRING_GENERAL is	do Result := locale.translation ("Include all classes") end
	m_import_metrics_from_file: STRING_GENERAL is do Result := locale.translation("Import metrics from file") end
	m_input_domain: STRING_GENERAL is			do Result := locale.translation("&Input domain") end
	m_library: STRING_GENERAL is				do Result := locale.translation ("Library") end
	m_move_down: STRING_GENERAL is				do Result := locale.translation ("Move down") end
	m_move_up: STRING_GENERAL is				do Result := locale.translation ("Move up") end
	m_new_metric: STRING_GENERAL is				do Result := locale.translation ("New metric") end
	m_open_user_defined_metric: STRING_GENERAL is	do Result := locale.translation ("Open user defined metrics externally") end
	m_Pick: STRING_GENERAL is					do Result := locale.translation("&Pick") end

	m_context_menu_pick (a_type, a_name: STRING_GENERAL): STRING_GENERAL
		require
			exists: a_type /= Void and a_name /= Void
		do
			Result := locale.formatted_string (locale.translation ("&Pick $1 '$2'"), [a_type, a_name])
		end

	m_context_menu_retarget (a_type, a_name: STRING_GENERAL): STRING_GENERAL
		require
			exists: a_type /= Void and a_name /= Void
		do
			Result := locale.formatted_string (locale.translation ("Retarget to $1 '$2'"), [a_type, a_name])
		end

	m_context_menu_new_tab (a_type, a_name: STRING_GENERAL): STRING_GENERAL
		require
			exists: a_type /= Void and a_name /= Void
		do
			Result := locale.formatted_string (locale.translation ("New Ta&b $1 '$2'"), [a_type, a_name])
		end

	m_context_menu_new_window (a_type, a_name: STRING_GENERAL): STRING_GENERAL
		require
			exists: a_type /= Void and a_name /= Void
		do
			Result := locale.formatted_string (locale.translation ("New &Window $1 '$2'"), [a_type, a_name])
		end

	m_context_menu_external_editor (a_type, a_name: STRING_GENERAL): STRING_GENERAL
		require
			exists: a_type /= Void and a_name /= Void
		do
			Result := locale.formatted_string (locale.translation ("External E&ditor $1 '$2'"), [a_type, a_name])
		end

	m_quick_metric: STRING_GENERAL is			do Result := locale.translation("Quick metric") end
	m_reload_metrics: STRING_GENERAL is			do Result := locale.translation("&Reload metrics") end
	m_remove: STRING_GENERAL					do Result := locale.translation ("&Remove") end
	m_remove_all: STRING_GENERAL				do Result := locale.translation ("Remove &all") end
	m_remove_from_diagram: STRING_GENERAL		do Result := locale.translation ("&Remove from diagram") end
	m_remove_from_favorites: STRING_GENERAL		do Result := locale.translation ("&Remove from Favorites") end
	m_search_scope: STRING_GENERAL		do Result := locale.translation ("Search scope") end
	m_show_diagram_history: STRING_GENERAL is	do Result := locale.translation("&Show diagram history")	end
	m_Show: STRING_GENERAL is					do Result := locale.translation("&Show")	end
	m_synchronize_in_tools: STRING_GENERAL is	do Result := locale.translation("Synchronize in tools")	end
	m_View: STRING_GENERAL is					do Result := locale.translation("&View")	end

feature -- Label texts

	l_Ace_file_for_frame: STRING_GENERAL is		do Result := locale.translation("Configuration file")	end
	l_action_colon: STRING_GENERAL is			do Result := locale.translation("Action:")	end
	l_Active_query: STRING_GENERAL is			do Result := locale.translation("Active query")	end
	l_Address_colon: STRING_GENERAL is				do Result := locale.translation("Address:")	end
	l_Address: STRING_GENERAL is				do Result := locale.translation("Address")	end
	l_add_a_valuable: STRING_GENERAL is				do Result := locale.translation("Add a variable (double click or Enter); Use an existing variable (right click or Ctrl+Enter)")	end
	l_add_project_config_file: STRING_GENERAL is	do Result := locale.translation("Add Project...")	end
	l_additional_details: STRING_GENERAL is		do Result := locale.translation("Additional details")	end
	l_All: STRING_GENERAL is					do Result := locale.translation("recursive")	end
	l_all_classes_in_same_cluster: STRING_GENERAL is	do Result := locale.translation("All classes in same cluster")	end
	l_Alias_name: STRING_GENERAL is				do Result := locale.translation("Alias:")	end
	l_Ancestors: STRING_GENERAL is				do Result := locale.translation("Ancestors")	end
	l_apply_changes_to_view_named: STRING_GENERAL is	do Result := locale.translation("Apply changes to view named: ")	end
	l_Arguments: STRING_GENERAL is				do Result := locale.translation("Arguments")	end
	l_assigners: STRING_GENERAL is				do Result := locale.translation("Assigners")	end
	l_Attribute: STRING_GENERAL is				do Result := locale.translation("Attribute")	end
	l_Attributes: STRING_GENERAL is				do Result := locale.translation("Attributes")	end
	l_auto: STRING_GENERAL is					do Result := locale.translation ("auto") end
	l_Available_buttons_text: STRING_GENERAL is do Result := locale.translation("Available buttons")	end
	l_Basic_application: STRING_GENERAL is		do Result := locale.translation("Basic application (no graphics library included)")	end
	l_Basic_text: STRING_GENERAL is				do Result := locale.translation("Basic text view")	end
	l_building_flat_view: STRING_GENERAL is		do Result := locale.translation ("Building flat view ...") end
	l_building_tree_view: STRING_GENERAL is		do Result := locale.translation ("Building tree view ...") end
	l_capture: STRING_GENERAL is 				do Result := locale.translation ("Capture") end
	l_Callers: STRING_GENERAL is				do Result := locale.translation("Callers")	end
	l_Calling_convention: STRING_GENERAL is		do Result := locale.translation("Calling convention:")	end
	l_center_attraction: STRING_GENERAL is		do Result := locale.translation("Center attraction:")	end
	l_center_attraction_value (a_value: STRING_GENERAL): STRING_GENERAL is	do Result := locale.formatted_string (locale.translation("Center attraction ($1%%)"), [a_value])	end
	l_chart: STRING_GENERAL is		do Result := locale.translation("Chart") end
	l_relations: STRING_GENERAL is		do Result := locale.translation("Relations")	end
	l_text: STRING_GENERAL is		do Result := locale.translation("Text")	end
	l_contract: STRING_GENERAL is		do Result := locale.translation("Contract")	end
	l_flat_contracts:  STRING_GENERAL is		do Result := locale.translation("Flat contracts")	end
	l_Continue_execution: STRING_GENERAL is			do Result := locale.translation("Continue execution")	end
	l_Choose_folder: STRING_GENERAL is			do Result := locale.translation("Select the destination folder ")	end
	l_one_target_among: STRING_GENERAL is			do Result := locale.translation("Choose one target among: ")	end
	l_Only_available_for_stopped_application: STRING_GENERAL is do Result := locale.translation("This feature is only available when debugging, and when the execution is stopped.")	end

	l_class: STRING_GENERAL is					do Result := locale.translation ("Class") end
	l_class_address: STRING_GENERAL is			do Result := locale.translation ("Class address") end
	l_class_colon: STRING_GENERAL is					do Result := locale.translation("Class:")	end
	l_class_label: STRING_GENERAL is			do Result := locale.translation ("Class label") end
	l_class_is_not_writable (a_class: STRING_GENERAL): STRING_GENERAL is
		require
			a_class_not_void: a_class /= Void
		do
			Result := locale.formatted_string (locale.translation("The class $1 is not writable."), [a_class])
		end
	l_class_is_not_editable: STRING_GENERAL is	do Result := locale.translation ("Class is not editable.%N") end
	l_class_is_not_in_anymore (a_class_name, a_group_id: STRING): STRING is
		do
			Result := locale.formatted_string (locale.translation ("Class $1 is not in $2 anymore."), [a_class_name, a_group_id])
		end
	l_class_name (a_class: STRING_GENERAL): STRING_GENERAL is
		require a_class_not_void: a_class /= Void
		do Result := locale.formatted_string (locale.translation("Class name: $1"), [a_class])	end
	l_class_name_not_valid: STRING_GENERAL is					do Result := locale.translation("The class name is not valid.")	end
	l_clean: STRING_GENERAL is					do Result := locale.translation("Clean")	end
	l_clean_user_file: STRING_GENERAL is		do Result := locale.translation("Reset user settings")	end
	l_Clients: STRING_GENERAL is				do Result := locale.translation("Clients")	end
	l_Clients_stiffness: STRING_GENERAL is				do Result := locale.translation("Client stiffness:")	end
	l_Clients_stiffness_value (a_value: STRING_GENERAL): STRING_GENERAL is	do Result := locale.formatted_string (locale.translation ("Client stiffness ($1%%)"), [a_value])	end
	l_Clickable: STRING_GENERAL is				do Result := locale.translation("Clickable view")	end
	l_cluster: STRING_GENERAL is				do Result := locale.translation ("Cluster") end
	l_cluster_colon: STRING_GENERAL is			do Result := locale.translation("Cluster:")	end
	l_cluster_is_not_in_the_system_anymore (a_cluster: STRING): STRING is
		do
			Result := locale.formatted_string (locale.translation ("Cluster $1 is not in the system anymore."), [a_cluster])
		end
	l_Cluster_name: STRING_GENERAL is			do Result := locale.translation("Cluster name ")	end
	l_Cluster_options: STRING_GENERAL is		do Result := locale.translation("Cluster options ")	end
	l_Command_error_output: STRING_GENERAL is	do Result := locale.translation("Command error output:%N")	end
	l_Command_line: STRING_GENERAL is			do Result := locale.translation("Command line:")	end
	l_Command_normal_output: STRING_GENERAL is	do Result := locale.translation("Command output:%N")	end
	l_Compiled_class: STRING_GENERAL is			do Result := locale.translation("Only compiled classes")	end
	l_compile: STRING_GENERAL is				do Result := locale.translation("Compile")	end
	l_Compile_first: STRING_GENERAL is			do Result := locale.translation("Compile to have information")	end
	l_Compile_project: STRING_GENERAL is		do Result := locale.translation("Compile project")	end
	l_Condition: STRING_GENERAL is				do Result := locale.translation("Condition")	end
	l_Confirm_kill: STRING_GENERAL is			do Result := locale.translation("Are you sure you want to stop the execution?")	end
	l_Confirm_kill_and_restart: STRING_GENERAL is			do Result := locale.translation("Are you sure you want to stop and restart the execution?")	end

	l_constructing_diagram_for (a_name: STRING_GENERAL): STRING_GENERAL is			do Result := locale.formatted_string (locale.translation("Constructing diagram for $1"), [a_name])	end
	l_Context: STRING_GENERAL is				do Result := locale.translation("Context")	end
	l_context_dot: STRING_GENERAL is			do Result := locale.translation("Context ...") end
	l_Creation: STRING_GENERAL is				do Result := locale.translation("Creation procedure:")	end
	l_creators: STRING_GENERAL is				do Result := locale.translation("Creators")	end
	l_Culture: STRING_GENERAL is				do Result := locale.translation ("Culture") end
	l_Current_context: STRING_GENERAL is		do Result := locale.translation("Current feature")	end
	l_Current_editor: STRING_GENERAL is			do Result := locale.translation("Current editor")	end
	l_Current_hit_count: STRING_GENERAL is		do Result := locale.translation("Current hit count:")	end
	l_Current_hit_count_short: STRING_GENERAL is		do Result := locale.translation("hits: ")	end
	l_Current_object: STRING_GENERAL is			do Result := locale.translation("Current object")	end
	l_Custom: STRING_GENERAL is 				do Result := locale.translation("Custom")	end

	l_c_compilation_manager_launch_failed (a_sub: BOOLEAN): STRING_GENERAL is
		local
			l_exe: STRING
		do
			if a_sub then
				l_exe := ".exe"
			else
				l_exe := ""
			end
			Result := locale.formatted_string (locale.translation (
						"C-compilation manager launch failed.%NCheck if finish_freezing$1%
						% exists and works correctly."
					), [l_exe])
		end

	l_c_compilation_produced_errors (a_dir: STRING_GENERAL): STRING_GENERAL is
		do
			Result := locale.formatted_string (locale.translation (
						"C-compilation produced errors.%N%
						%Run your Makefile utility program from the directory `%
						%$1`%Nto see what went wrong.%N%NClick OK to terminate.%
						%%NClick Cancel to open a command line console.%N"
					), [a_dir])
		end

	l_c_compilation_and_external_command_running: STRING_GENERAL is
		do Result := locale.translation("A C Compilation and an external command are currently running.%N%
								%They need to be terminated before EiffelStudio can exist.%N%N%
								%Cancel C compilation, terminate external command and exit?%N")	end
	l_c_compilation_running: STRING_GENERAL is
		do Result := locale.translation("A C Compilation is currently running.%N%
								%It needs to be terminated before EiffelStudio can exist.%N%N%
								%Cancel C compilation and exit?%N")	end
	l_cwd (a_working_directory: STRING_GENERAL): STRING_GENERAL is
		do Result := locale.formatted_string (locale.translation ("cwd=%"$1%""), [a_working_directory]) end

	l_external_command_running: STRING_GENERAL is
		do Result := locale.translation("An external command is currently running.%N%
								%It need to be terminated before EiffelStudio can exist.%N%N%
								%Terminate external command and exit?%N")	end

	l_debugger_exception_message: STRING_GENERAL is do Result := locale.translation("Debugger :: Exception message")	end
	l_default: STRING_GENERAL is				do Result := locale.translation ("default") end
	l_Deferred: STRING_GENERAL is				do Result := locale.translation("deferred")	end
	l_Deferreds: STRING_GENERAL is				do Result := locale.translation("Deferred features")	end
	l_Deleting_dialog_default: STRING_GENERAL is do Result := locale.translation("Creating new project, please wait...")	end
	l_Descendants: STRING_GENERAL is			do Result := locale.translation("Descendants")	end
	l_descending_class_already_has_feature (a_class: STRING_GENERAL): STRING_GENERAL is
		require
			a_class_not_void: a_class /= Void
		do
			Result := locale.formatted_string (locale.translation("The descending class $1 already has another feature with the new name."), [a_class])
		end

	l_description: STRING_GENERAL is 			do Result := locale.translation ("Description") end
	l_Diagram_delete_view_cmd: STRING_GENERAL is	do Result := locale.translation("Do you really want to delete current view?")	end
	l_Diagram_reset_view_cmd: STRING_GENERAL is		do Result := locale.translation("Do you really want to reset current view?")	end
	l_diagram_statistic (a_nclass, a_ncslink, a_nilink, a_ncluster,a_physics, a_draw, a_draws: STRING_GENERAL): STRING_GENERAL is
		do
			Result := locale.formatted_string (
						locale.translation (
						"Classes:  $1%N%
						%CS_Links: $2%N%
						%I_Links:  $3%N%
						%Clusters: $4%N%
						%Physics ms: $5%N%
						%Draw ms: $6%N%
						%Draws: $7"
						),
						[a_nclass, a_ncslink, a_nilink, a_ncluster, a_physics, a_draw, a_draws])
		end

	l_Discard_convert_project_dialog: STRING_GENERAL is	do Result := locale.translation("always convert old projects.")	end
	l_Discard_build_precompile_dialog: STRING_GENERAL is do Result := locale.translation("always build precompile.")	end
	l_Discard_finalize_assertions: STRING_GENERAL is do Result := locale.translation("always discard assertions when finalizing.")	end
	l_Discard_finalize_precompile_dialog: STRING_GENERAL is do Result := locale.translation("always finalize.")	end
	l_Discard_freeze_dialog: STRING_GENERAL is	do Result := locale.translation("always compile C/++ code.")	end
	l_Discard_save_before_compile_dialog: STRING_GENERAL is	do Result := locale.translation("always save files before compiling.")	end
	l_Discard_starting_dialog: STRING_GENERAL is do Result := locale.translation("hide this dialog at startup.")	end
	l_Discard_replace_all_warning_dialog: STRING_GENERAL is do Result := locale.translation("always replace all.")	end
	l_Discard_terminate_freezing: STRING_GENERAL is do Result := locale.translation("always terminate freezing when needed.")	end
	l_Discard_terminate_external_command: STRING_GENERAL is do Result := locale.translation("always terminate running external command.")	end
	l_Discard_terminate_finalizing: STRING_GENERAL is do Result := locale.translation("always terminate finalizing when needed.")	end
	l_discard_cancel_c_compilation_and_external_command: STRING_GENERAL is do Result := locale.translation("always cancel C/C++ compilation, terminate external command when exiting.")	end
	l_discard_cancel_c_compilation: STRING_GENERAL is	do Result := locale.translation("always cancel C/C++ compilation when exiting.")	end
	l_discard_terminate_external_command_when_exit: STRING_GENERAL is	do Result := locale.translation("always terminate external command when exiting.")	end

	l_Display_call_stack_warning: STRING_GENERAL is	do Result := locale.translation("Display a warning when the call stack depth reaches:")	end
	l_Displayed_buttons_text: STRING_GENERAL is do Result := locale.translation("Displayed buttons")	end
	l_display_window: STRING_GENERAL is			do Result := "Display window" end
	l_Dont_ask_me_again: STRING_GENERAL is		do Result := locale.translation("Do not ask me again")	end
	l_Do_not_detect_stack_overflows: STRING_GENERAL is do Result := locale.translation("Do not detect stack overflows")	end
	l_Do_not_show_again: STRING_GENERAL is		do Result := locale.translation("Do not show again")	end
	l_Dropped_references: STRING_GENERAL is		do Result := locale.translation("Dropped references")	end
	l_Dummy: STRING_GENERAL is					do Result := locale.translation("Should not be read")	end
	l_Not_empty: STRING_GENERAL is				do Result := locale.translation("Generate default feature clauses")	end
	l_no_break_point: STRING_GENERAL is				do Result := locale.translation("No breakpoints")	end
	l_no_limit: STRING_GENERAL is				do Result := locale.translation ("no limit") end
	l_no_project: STRING_GENERAL is				do Result := locale.translation ("No project") end
	l_edit_project: STRING_GENERAL is			do Result := locale.translation("Edit Project")	end
	l_edit_text: STRING_GENERAL is				do Result := locale.translation("Edit Text") end
	l_eiffel_class: STRING_GENERAL is			do Result := locale.translation ("Eiffel Class") end
	l_eiffel_cluster: STRING_GENERAL is			do Result := locale.translation ("Eiffel Cluster") end
	l_Elements: STRING_GENERAL is				do Result := locale.translation("elements.")	end
	l_enabled: STRING_GENERAL is				do Result := locale.translation("Enabled")	end
	l_Enter_folder_name: STRING_GENERAL is		do Result := locale.translation("Enter the name of the new folder: ")	end
	l_Entry_colon: STRING_GENERAL is			do Result := locale.translation("Entry: ") end
	l_environment: STRING_GENERAL is					do Result := locale.translation("Environment")	end
	l_error: STRING_GENERAL is					do Result := locale.translation("Error")	end
	l_error_message:  STRING_GENERAL is					do Result := locale.translation("Error message :")	end
	l_error_on_expression (a_expression: STRING_GENERAL): STRING_GENERAL is
		require
			a_expression_not_void: a_expression /= Void
		do
			Result := locale.formatted_string (locale.translation("Error on expression : %"$1%""), [a_expression])
		end

	l_Executing_command: STRING_GENERAL is		do Result := locale.translation("Command is currently executing.%NPress OK to ignore the output.")	end
	l_Execution_interrupted: STRING_GENERAL is	do Result := locale.translation("Execution interrupted")	end
	l_exception_double_click_text: STRING_GENERAL is do Result := locale.translation ("Double click to see Exception or Ctrl-C to copy to clipboard") end
	l_exception_raised: STRING_GENERAL is do Result := locale.translation ("Exception raised") end
	l_exception_message_from_debugger: STRING_GENERAL is do Result := locale.translation ("Exception message from debugger") end
	l_Exit_application: STRING_GENERAL is
		once
			Result := locale.formatted_string(locale.translation("Are you sure you want to quit $1?"), [Workbench_name])
		end
	l_Exit_warning: STRING_GENERAL is			do Result := locale.translation("Some files have not been saved. Do you want to save them before exiting?")	end
	l_Expanded: STRING_GENERAL is				do Result := locale.translation("expanded")	end
	l_Explicit_exception_pending: STRING_GENERAL is do Result := locale.translation("Explicit exception pending")	end
	l_exploring_ancestor_of (a_class: STRING_GENERAL): STRING_GENERAL is				do Result := locale.formatted_string (locale.translation("Exploring ancestors of $1"), [a_class])	end
	l_exploring_descendants_of (a_class: STRING_GENERAL): STRING_GENERAL is				do Result := locale.formatted_string (locale.translation("Exploring descendants of $1"), [a_class])	end
	l_exploring_clinets_of (a_class: STRING_GENERAL): STRING_GENERAL is					do Result := locale.formatted_string (locale.translation("Exploring clients of $1"), [a_class])	end
	l_exploring_suppliers_of (a_class: STRING_GENERAL): STRING_GENERAL is				do Result := locale.formatted_string (locale.translation("Exploring suppliers of $1"), [a_class])	end
	l_Exported: STRING_GENERAL is				do Result := locale.translation("Exported features")	end
	l_Expression: STRING_GENERAL is				do Result := locale.translation("Expression")	end
	l_false: STRING_GENERAL is					do Result := locale.translation ("False") end
	l_External: STRING_GENERAL is				do Result := locale.translation("External features")	end
	l_Feature: STRING_GENERAL is				do Result := locale.translation("Feature")	end
	l_Feature_colon: STRING_GENERAL is				do Result := locale.translation("Feature:")	end
	l_feature_count (a_count: INTEGER): STRING_GENERAL is
		do
			Result := locale.formatted_string (locale.plural_translation ("$1 feature", "$1 features", a_count), [a_count])
		end
	l_feature_address: STRING_GENERAL is				do Result := locale.translation("Feature address")	end
	l_feature_label: STRING_GENERAL is				do Result := locale.translation("Feature label")	end
	l_feature_list: STRING_GENERAL is				do Result := locale.translation("Feature list")	end
	l_Feature_properties: STRING_GENERAL is		do Result := locale.translation("Feature properties")	end
	l_force_inheritance: STRING_GENERAL is do Result := locale.translation ("Force inheritance on child elements.")	end
	l_file_location: STRING_GENERAL is 			do Result := locale.translation ("File location") end
	l_File_name: STRING_GENERAL is				do Result := locale.translation("File name:")	end
	l_file_changed_by_other_tool: STRING_GENERAL is do Result := locale.translation ("File has been changed by another tool/editor%NDo you want to load the changes?") end
	l_Filter_exceptions: STRING_GENERAL is		do Result := locale.translation ("Filter exceptions") end
	l_filter_warnings: STRING_GENERAL is		do Result := locale.translation ("Show warnings:") end
	l_finalize: STRING_GENERAL is				do Result := locale.translation("Finalize")	end
	l_Finalized_mode: STRING_GENERAL is 		do Result := locale.translation("Finalized mode")	end
	l_finish_to_generate: STRING_GENERAL is 	do Result := locale.translation("Click `Finish' to generate the documentation.")	end
	l_first_chance: STRING_GENERAL is 			do Result := locale.translation ("First chance") end
	l_Flat_view: STRING_GENERAL is				do Result := locale.translation ("Flat view") end
	l_Flatshort: STRING_GENERAL is				do Result := locale.translation("Interface view")	end
	l_found: STRING_GENERAL is 					do Result := locale.translation ("Found") end
	l_freeze: STRING_GENERAL is					do Result := locale.translation("Freeze")	end
	l_fresh_compilation: STRING_GENERAL is		do Result := locale.translation("Recompile project")	end
	l_general: STRING_GENERAL is				do Result := locale.translation("General")	end
	l_Generate_profile_from_rtir: STRING_GENERAL is do Result := locale.translation("Generate profile from Run-time information record")	end
	l_Generate_creation: STRING_GENERAL is		do Result := locale.translation("Generate creation procedure")	end
	l_generate_set_procedure: STRING_GENERAL is	do Result := locale.translation ("Generate set procedure") end
	l_grid_column_layout: STRING_GENERAL is		do Result := locale.translation ("Grid column layout") end
			-- Preferece name prefix. For "debugger.grid_column_layout_XX".
	l_Has_changed: STRING_GENERAL is			do Result := locale.translation("Has Changed")	end
	l_Homonyms: STRING_GENERAL is				do Result := locale.translation("Homonyms")	end
	l_Homonym_confirmation: STRING_GENERAL is	do Result := locale.translation("Extracting the homonyms may take a long time.%NAre you sure you want to continue?")	end
	l_Identification: STRING_GENERAL is			do Result := locale.translation("Identification")	end
	l_Ignore_external_exceptions: STRING_GENERAL is do Result := locale.translation ("Ignore external exceptions") end
	l_inheritance_cycle_was_created: STRING_GENERAL is			do Result := locale.translation("An inheritance cycle was created.%NDo you still want to add this link?")	end
	l_inheritance_stiffness: STRING_GENERAL is			do Result := locale.translation("Inheritance stiffness:")	end
	l_inheritance_stiffness_100: STRING_GENERAL is			do Result := locale.translation("Inheritance stiffness (100%%)")	end
	l_inheritance_stiffness_value (a_value: STRING_GENERAL): STRING_GENERAL is	do Result := locale.formatted_string (locale.translation ("Inheritance stiffness ($1%%)"), [a_value])	end
	l_Implicit_exception_pending: STRING_GENERAL is do Result := locale.translation("Implicit exception pending")	end
	l_Implementers: STRING_GENERAL is			do Result := locale.translation("Implementers")	end
	l_Inactive_subqueries: STRING_GENERAL is	do Result := locale.translation("Inactive subqueries")	end
	l_include_colon: STRING_GENERAL is	do Result := locale.translation("Include:")	end
	l_include: STRING_GENERAL is 				do Result := locale.translation("Include")	end
	l_Index: STRING_GENERAL is					do Result := locale.translation("Index:")	end
	l_indexing_clause_error: STRING_GENERAL is			do Result := locale.translation("Indexing clause has syntax error")	end
	l_invariants: STRING_GENERAL is				do Result := locale.translation("Invariants")	end
	l_Is_true: STRING_GENERAL is				do Result := locale.translation("Is True")	end
	l_Language_type: STRING_GENERAL is			do Result := locale.translation("Language type")	end
	l_Library: STRING_GENERAL is				do Result := locale.translation("library")	end
	l_line: STRING_GENERAL is 					do Result := locale.translation ("Line") end
	l_line_number: STRING_GENERAL is			do Result := locale.translation ("Line number") end
	l_line_number_range (a_number: STRING_GENERAL): STRING_GENERAL is		do Result := locale.formatted_string (locale.translation ("Line number (1 - $1)"), [a_number]) end
	l_Literal_value: STRING_GENERAL is			do Result := locale.translation("Literal Value")	end
	l_Loaded_project: STRING_GENERAL is			do Result := locale.translation("Loaded project: ")	end
	l_Loading_diagram: STRING is				"Loading diagram:"
	l_Location_colon: STRING_GENERAL is 				do Result := locale.translation("Location: ")	end
	l_Locals: STRING_GENERAL is					do Result := locale.translation("Locals")	end
	l_Min_index: STRING_GENERAL is				do Result := locale.translation("Minimum index displayed")	end
	l_Match_case: STRING_GENERAL is				do Result := locale.translation("Match case")	end

	l_matches_of_total_preferences (a_count: INTEGER; a_total_count: INTEGER): STRING_GENERAL is
		require
			a_count_not_void: a_count /= Void
			a_total_count_not_void: a_total_count /= Void
		do
				-- Actually it should have two plural forms, one for the number of matches and the other for the number of preferences
				-- But since the number of preferences is always greater than one anyway we just go for the number of matches
			Result := locale.formatted_string (locale.plural_translation ("$1 match of $2 total preferences" ,"$1 matches of $2 total preferences", a_count), [a_count, a_total_count])
		end

	l_count_preferences (a_count: STRING_GENERAL): STRING_GENERAL is
		require
			a_count_not_void: a_count /= Void
		do
			Result := locale.formatted_string (locale.translation ("$1 preferences"), [a_count])
		end

	l_Max_index: STRING_GENERAL is				do Result := locale.translation("Maximum index displayed")	end
	l_Max_displayed_string_size: STRING_GENERAL is do Result := locale.translation("Maximum displayed string size")	end
	l_More_items: STRING_GENERAL is				do Result := locale.translation("Display limit reached")	end
	l_Name: STRING_GENERAL is					do Result := locale.translation("Name")	end
	l_Name_colon: STRING_GENERAL is				do Result := locale.translation("Name:")	end
	l_New_breakpoint: STRING_GENERAL is			do Result := locale.translation("New breakpoint(s) to commit")	end
	l_note: STRING_GENERAL is					do Result := locale.translation ("Note") end
	l_no_description_text: STRING_GENERAL is 	do Result := locale.translation ("No description available for this preference.") end
	l_no_default_value: STRING_GENERAL is		do Result := locale.translation ("No default value") end
	l_No_feature: STRING_GENERAL is				do Result := locale.translation("Select a fully compiled feature to have information about it.")	end
	l_No_feature_group_clause: STRING_GENERAL is do Result := locale.translation("[Unnamed feature clause]")	end
	l_No_text_text: STRING_GENERAL is 			do Result := locale.translation("No text labels")	end
	l_no_feature_bra: STRING_GENERAL is 		do Result := locale.translation ("(no_feature)") end
	l_no_class_bra: STRING_GENERAL is 		do Result := locale.translation ("(no_class)") end
	l_no_cluster_bra: STRING_GENERAL is 		do Result := locale.translation ("(no_cluster)") end
	l_no_views_are_available: STRING_GENERAL is 		do Result := locale.translation ("No views are available for this cluster") end
	l_Not_in_system_no_info: STRING_GENERAL is	do Result := locale.translation("Select a class which is fully compiled to have information about it.")	end
	l_Not_yet_called: STRING_GENERAL is			do Result := locale.translation("Not yet called")	end
	l_Called: STRING_GENERAL is			do Result := locale.translation("Called")	end
	l_in_n_classes (n: INTEGER): STRING_GENERAL is
		do
			Result := locale.formatted_string (locale.plural_translation ("in $1 class", "in $1 classes", n), [n])
		end
	l_n_matches (n: INTEGER): STRING_GENERAL is
		do
			Result := locale.formatted_string (locale.plural_translation ("$1 match", "$1 matches", n), [n])
		end
	l_Object_attributes: STRING_GENERAL is		do Result := locale.translation("Attributes")	end
	l_object_tool_left: STRING_GENERAL is		do Result := locale.translation("Objects tool: left")	end
	l_object_tool_right: STRING_GENERAL is		do Result := locale.translation("Objects tool: right")	end
	l_On_object: STRING_GENERAL is				do Result := locale.translation("On object")	end
	l_As_object: STRING_GENERAL is				do Result := locale.translation("As object")	end
	l_Onces: STRING_GENERAL is					do Result := locale.translation("Once routines and constants")	end
	l_Once_routines: STRING_GENERAL is			do Result := locale.translation("Once routines")	end
	l_only_classes_in_same_cluster: STRING_GENERAL is			do Result := locale.translation("Only classes in same cluster")	end
	l_open: STRING_GENERAL is					do Result := locale.translation("Open")	end
	l_Open_a_project: STRING_GENERAL is			do Result := locale.translation("Open a project")	end
	l_Open_project: STRING_GENERAL is 			do Result := locale.translation("Open project")	end
	l_Options: STRING_GENERAL is 				do Result := locale.translation("Options")	end
	l_Options_colon: STRING_GENERAL is 				do Result := locale.translation("Options: ")	end
	l_Output_switches: STRING_GENERAL is		do Result := locale.translation("Output switches")	end
	l_Outside_ide: STRING_GENERAL is 			do Result := locale.translation ("Outside EiffelStudio") end
	l_Parent_cluster: STRING_GENERAL is			do Result := locale.translation("Parent cluster")	end
	l_parents: STRING_GENERAL is				do Result := locale.translation("Parents:")	end
	l_Path: STRING_GENERAL is					do Result := locale.translation("Path")	end
	l_Platform: STRING_GENERAL is				do Result := locale.translation ("Platform") end
	l_position: STRING_GENERAL is 				do Result := locale.translation ("Position") end
	l_Possible_overflow: STRING_GENERAL is		do Result := locale.translation("Possible stack overflow")	end
	l_precompile: STRING_GENERAL is				do Result := locale.translation("Precompile")	end
	l_preferences_delayed_resources: STRING_GENERAL is do Result := locale.translation ("The changes you have made to the following resources%Nwill be taken into account after you restart.") end
	l_Print_message: STRING_GENERAL is			do Result := locale.translation("Print a message:")	end
	l_Print_message_help: STRING_GENERAL is
		do
			Result := locale.translation ("[
					You can include the value of an expression in the message by
					placing it in curly braces, such as "The value of x is {x}.".
					To insert a curly brace, use "\{". To insert a backslash, use "\\".
					
					The following special keywords will be replaced with their current values:
						$HITCOUNT - breakpoint's hit count
						$ADDRESS - current object address
						$CALL - current call
						$CALLSTACK - current call stack
						$CLASS - current class name
						$FEATURE - current feature name
						$THREADID - current thread id
					]")
		end
	l_procedure: STRING_GENERAL is			do Result := locale.translation("Procedure")	end
	l_Profiler_used: STRING_GENERAL is			do Result := locale.translation("Profiler used to produce the above record: ")	end
	l_profile_no: STRING_GENERAL is			do Result := locale.translation("profile #")	end
	l_Project_location: STRING_GENERAL is		do Result := locale.translation("The project location is the place where compilation%Nfiles will be generated by the compiler")	end
	l_Public_key_token: STRING_GENERAL is		do Result := locale.translation ("PublicKeyToken") end
	l_Put_text_right_text: STRING_GENERAL is 	do Result := locale.translation("Show selective text on the right of buttons")	end
	l_Show_all_text: STRING_GENERAL is			do Result := locale.translation("Show text labels")	end
	l_Switching_to_debug_mode: STRING_GENERAL is do Result := locale.translation("Switching to debug mode...")	end
	l_Switching_to_normal_mode: STRING_GENERAL is do Result := locale.translation("Switching to edit mode...")	end

	l_Query: STRING_GENERAL is					do Result := locale.translation("Query")	end
	l_refresh_tools: STRING_GENERAL is			do Result := locale.translation("Refresh tools")	end
	l_remove_project: STRING_GENERAL is			do Result := locale.translation("Remove Project")	end
	l_Remove_object: STRING_GENERAL is			do Result := locale.translation("Remove")	end
	l_Remove_object_desc: STRING_GENERAL is		do Result := locale.translation("Remove an object from the tree")	end
	l_removing_unneeded_items: STRING_GENERAL is do Result := locale.translation ("Removing unneeded items") end
	l_Replace_with: STRING_GENERAL is			do Result := locale.translation("Replace with: ")	end
	l_Replace_with_ellipsis: STRING_GENERAL is	do Result := locale.translation("Replace with...")	end
	l_Replace_all: STRING_GENERAL is			do Result := locale.translation("Replace all")	end
	l_request_restart: STRING_GENERAL is		do Result := locale.translation (" (REQUIRES RESTART)") end
	l_restore_defaults: STRING_GENERAL is 		do Result := locale.translation ("Restore Defaults") end
	l_restore_default: STRING_GENERAL is 		do Result := locale.translation ("Restore Default") end
	l_restore_preference_string: STRING_GENERAL is do Result := locale.translation ("This will reset ALL preferences to their default values%N and all previous settings will be overwritten.  Are you sure?") end
	l_Result: STRING_GENERAL is					do Result := locale.translation("Result")	end
	l_repulsion: STRING_GENERAL is					do Result := locale.translation("Repulsion:")	end
	l_repulsion_value (a_value: STRING_GENERAL): STRING_GENERAL is	do Result := locale.formatted_string (locale.translation("Repulsion ($1%%)"), [a_value])	end
	l_rollback_question: STRING_GENERAL is		do Result := locale.translation("Rollback?")	end
	l_Root_class: STRING_GENERAL is				do Result := locale.translation("Root class name: ")	end
	l_Root_class_name: STRING_GENERAL is		do Result := locale.translation("Root class: ")	end
	l_Root_cluster_name: STRING_GENERAL is		do Result := locale.translation("Root cluster: ")	end
	l_Root_feature_name: STRING_GENERAL is		do Result := locale.translation("Root feature: ")	end
	l_Routine_ancestors: STRING_GENERAL is		do Result := locale.translation("Ancestor versions")	end
	l_Routine_descendants: STRING_GENERAL is	do Result := locale.translation("Descendant versions")	end
	l_Routine_flat: STRING_GENERAL is			do Result := locale.translation("flat view")	end
	l_Routines: STRING_GENERAL is				do Result := locale.translation("Routines")	end
	l_Runtime_information_record: STRING_GENERAL is do Result := locale.translation("Run-time information record")	end
	l_Same_class_name: STRING_GENERAL is		do Result := locale.translation("---")	end
	l_Scope: STRING_GENERAL is 					do Result := locale.translation("Scope")	end
	l_Search_backward: STRING_GENERAL is		do Result := locale.translation("Search backwards")	end
	l_Search_for: STRING_GENERAL is				do Result := locale.translation("Search for: ")	end
	l_Search_options_show: STRING_GENERAL is	do Result := locale.translation("Scope >>")	end
	l_Search_options_hide: STRING_GENERAL is	do Result := locale.translation("Scope <<")	end
	l_Search_report_show: STRING_GENERAL is		do Result := locale.translation("Report >>")	end
	l_Search_report_hide: STRING_GENERAL is 	do Result := locale.translation("Report <<")	end
	l_select_all: STRING_GENERAL is 			do Result := locale.translation("Select all")	end
	l_select_none: STRING_GENERAL is 			do Result := locale.translation("Select none")	end
	l_Set_as_default: STRING_GENERAL is			do Result := locale.translation("Set as default")	end
	l_Set_slice_limits: STRING is				do Result := locale.translation ("Slice limits") end
	l_Set_slice_limits_desc: STRING_GENERAL is	do Result := locale.translation("Set which values are shown in special objects")	end
	l_settings: STRING_GENERAL is				do Result := locale.translation ("Settings") end
	l_Short: STRING_GENERAL is					do Result := locale.translation("Contract view")	end
	l_Short_name: STRING_GENERAL is				do Result := locale.translation("Short Name")	end
	l_Show_all_call_stack: STRING_GENERAL is	do Result := locale.translation("Show all stack elements")	end
	l_Show_only_n_elements: STRING_GENERAL is	do Result := locale.translation("Show only:")	end
	l_Showallcallers: STRING_GENERAL is			do Result := locale.translation("Show all callers")	end
	l_Showcallers: STRING_GENERAL is			do Result := locale.translation("Show static callers")	end
	l_Showstops: STRING_GENERAL is				do Result := locale.translation("Show stop points")	end
	l_Slice_taken_into_account1: STRING_GENERAL is do Result := locale.translation("Warning: Modifications will be taken into account")	end
	l_Slice_taken_into_account2: STRING_GENERAL is do Result := locale.translation("for the next objects you will add in the object tree.")	end
	l_space_disabled: STRING_GENERAL is 		do Result := locale.translation(" disabled")	end
	l_space_enabled: STRING_GENERAL is 			do Result := locale.translation(" enabled")	end
	l_space_error: STRING_GENERAL is 			do Result := locale.translation(" error")	end
	l_Specify_arguments: STRING_GENERAL is		do Result := locale.translation("Specify arguments")	end
	l_Stack_information: STRING_GENERAL is		do Result := locale.translation("Stack information")	end
	l_status: STRING_GENERAL is					do Result := locale.translation ("Status") end
	l_tags: STRING_GENERAL is					do Result := locale.translation ("Tags") end
	l_Stepped: STRING_GENERAL is				do Result := locale.translation("Step completed")	end
	l_stiffness_value (a_value: STRING_GENERAL): STRING_GENERAL is	do Result := locale.formatted_string (locale.translation("Stiffness ($1%%)"), [a_value])	end
	l_Stop_point_reached: STRING_GENERAL is		do Result := locale.translation("Breakpoint reached")	end
	l_Sub_cluster: STRING_GENERAL is			do Result := locale.translation("Subcluster")	end
	l_Sub_clusters: STRING_GENERAL is			do Result := locale.translation("Recursive")	end
	l_super_cluster: STRING_GENERAL is			do Result := locale.translation("Super-clusters")	end
	l_subclusters: STRING_GENERAL is			do Result := locale.translation("Sub-clusters")	end
	l_Subquery: STRING_GENERAL is				do Result := locale.translation("Define new subquery")	end
	l_Suppliers: STRING_GENERAL is				do Result := locale.translation("Suppliers")	end
	l_Switch_num_format: STRING_GENERAL is 		do Result := locale.translation("Switch numerical formating")	end
	l_Switch_num_format_desc: STRING_GENERAL is do Result := locale.translation("Display numerical value as Hexadecimal or Decimal formating")	end
	l_synchronizing_classes: STRING_GENERAL is do Result := locale.translation ("Synchronizing classes") end
	l_synchronizing_class_relations: STRING_GENERAL is do Result := locale.translation ("Synchronizing class relations") end
	l_synchronizing_clusters: STRING_GENERAL is do Result := locale.translation ("Synchronizing clusters") end
	l_synchronizing_clusters_relations: STRING_GENERAL is do Result := locale.translation ("Synchronizing cluster relations") end
	l_synchronizing_diagram_tool: STRING_GENERAL is do Result := locale.translation ("Synchronizing diagram tool: ") end
	l_synchronizing_links: STRING_GENERAL is do Result := locale.translation ("Synchronizing links") end
	l_Syntax_error: STRING_GENERAL is			do Result := locale.translation("Class text has syntax error")	end
	l_System_name: STRING_GENERAL is			do Result := locale.translation("System name: ")	end
	l_System_properties: STRING_GENERAL is		do Result := locale.translation("System properties")	end
	l_System_running: STRING_GENERAL is			do Result := locale.translation("System running")	end
	l_System_launched: STRING_GENERAL is		do Result := locale.translation("System launched")	end
	l_System_not_running: STRING_GENERAL is		do Result := locale.translation("System not running")	end
	l_Tab_output: STRING_GENERAL is 			do Result := locale.translation("Output")	end
	l_Tab_class_info: STRING_GENERAL is 		do Result := locale.translation("Class")	end
	l_Tab_feature_info: STRING_GENERAL is 		do Result := locale.translation("Feature")	end
	l_Tab_diagram: STRING_GENERAL is 			do Result := locale.translation("Diagram")	end
	l_target: STRING_GENERAL is					do Result := locale.translation("Target")	end
	l_target_does_not_exist (a_target: STRING_GENERAL): STRING_GENERAL is
		require
			a_target_not_void: a_target /= Void
		do
			Result := locale.formatted_string (locale.translation ("Target `$1' does not exist or is not compilable.%NChoose one target among:"), [a_target])
		end
	l_tags_colon: STRING_GENERAL is			do Result := locale.translation("Tags:")	end
	l_Text_loaded: STRING_GENERAL is			do Result := locale.translation("Text finished loading")	end
	l_Text_saved: STRING_GENERAL is				do Result := locale.translation("Text was saved")	end
	l_the_feature_name_is_not_valid: STRING_GENERAL is 	do Result := locale.translation("The feature name is not valid.")	end
	l_there_is_already_a_feature_in (a_class: STRING_GENERAL): STRING_GENERAL is
		require
			a_class_not_void: a_class /= Void
		do
			Result := locale.formatted_string (locale.translation ("There is already a feature with this name in class $1. This would lead to a conflict."), [a_class])
		end

	l_there_is_already_a_class_with_the_same_name: STRING_GENERAL is do Result := locale.translation("There is already a class with the same name.")	end
	l_Three_dots: STRING_GENERAL is				do Result := locale.translation("...")	end
	l_tree_or_flat_view: STRING_GENERAL is		do Result := locale.translation ("Tree/Flat View") end
	l_Tree_view: STRING_GENERAL is				do Result := locale.translation ("Tree View") end
	l_true: STRING_GENERAL is					do Result := locale.translation ("True") end
	l_try_saving_file_and_searching: STRING_GENERAL is 	do Result := locale.translation ("Item expires. Try saving file and searching again.") end
	l_try_searching: STRING_GENERAL is 	do Result := locale.translation ("Item expires. Try searching again.") end
	l_Text_loading: STRING_GENERAL is		do Result := locale.translation("Current text is being loaded. It is therefore%Nnot editable nor pickable.")	end
	l_Toolbar_select_text_position: STRING_GENERAL is do Result := locale.translation("Text option: ")	end
	l_Toolbar_select_has_gray_icons: STRING_GENERAL is do Result := locale.translation("Icon option: ")	end
	l_Top_level: STRING_GENERAL is				do Result := locale.translation("Top-level")	end
	l_Type: STRING_GENERAL is					do Result := locale.translation("Type")	end
	l_undo_not_possible: STRING_GENERAL is			do Result := locale.translation("Undo not possible.")	end
	l_Unknown_status: STRING_GENERAL is			do Result := locale.translation("Unknown application status")	end
	l_Unknown_class_name: STRING_GENERAL is		do Result := locale.translation("Unknown class name")	end
	l_unhandled: STRING_GENERAL is 				do Result := locale.translation ("UnHandled") end
	l_unselected: STRING_GENERAL is 				do Result := locale.translation ("Unselected") end
	l_up_to_depth_of: STRING_GENERAL is 				do Result := locale.translation ("Up to depth of") end
	l_Use_existing_profile: STRING_GENERAL is	do Result := locale.translation("Use existing profile: ")	end
	l_Use_regular_expression: STRING_GENERAL is do Result := locale.translation("Use regular expression")	end
	l_Use_wildcards: STRING_GENERAL is			do Result := locale.translation("Use wildcards")	end
	l_Use_wizard: STRING_GENERAL is 			do Result := locale.translation("Create project")	end
	l_user_set: STRING_GENERAL is				do Result := locale.translation ("user set") end
	l_use_inherited: STRING_GENERAL is do Result := locale.translation ("Use inherited value.")	end
	l_Value: STRING_GENERAL is					do Result := locale.translation("Value")	end
	l_variable_count (a_variable_count: INTEGER): STRING_GENERAL is
		do
			Result := locale.formatted_string (locale.plural_translation ("$1 variable", "$1 variables", a_variable_count), [a_variable_count])
		end

	l_Version: STRING_GENERAL is				do Result := locale.translation ("Version") end
	l_viewer_display_complete_object: STRING_GENERAL is do Result := locale.translation("Display Complete Object") end
	l_viewer_display_auto_upper_limit: STRING_GENERAL is do Result := locale.translation("Auto Set Upper Limit") end
	l_viewer_enable_word_wrapping: STRING_GENERAL is do Result := locale.translation("Enable Word Wrapping") end
	l_copy_text_to_clipboard: STRING_GENERAL is do Result := locale.translation("Copy Text To Clipboard") end
	l_view_label: STRING_GENERAL is do Result := locale.translation ("View label") end
	t_viewer_string_display: STRING_GENERAL is do Result := locale.translation("String Display") end
	l_viewer_string_display_full_string_length (n: INTEGER): STRING_GENERAL is
		do
			Result := locale.formatted_string (locale.translation ("Full string length = $1"), [n])
		end
	l_dbg_unable_to_get_value_message: STRING_GENERAL is do Result := locale.translation("Sorry a problem occurred, %Nwe are not able to show you the value ...%N") end
	l_slice_limits: STRING_GENERAL is do Result := locale.translation ("Slice limits") end
	l_set_slice_values: STRING_GENERAL is do Result := locale.translation("Set Slice Values") end
	l_to: STRING_GENERAL is do Result := locale.translation("to") end
	t_viewer_object_dumper_title: STRING_GENERAL is do Result := locale.translation ("Object Dump") end
	t_viewer_object_browser_title: STRING_GENERAL is do Result := locale.translation ("Object Browse") end
	l_viewer_drop_object_here: STRING_GENERAL is do Result := locale.translation ("<< Drop object here >>") end
	t_viewer_xml_display_title: STRING_GENERAL is do Result := locale.translation ("XML display") end
	l_select_viewer: STRING_GENERAL is do Result := locale.translation ("Select Viewer") end

	l_When_breakpoint_is_hit: STRING_GENERAL is	do Result := locale.translation("When the breakpoint is hit:")	end
	l_Whole_project: STRING_GENERAL is			do Result := locale.translation("Whole project")	end
	l_Whole_word: STRING_GENERAL is				do Result := locale.translation("Whole word")	end
	l_Windows_only: STRING_GENERAL is			do Result := locale.translation("(Windows only)")	end
	l_Workbench_mode: STRING_GENERAL is 		do Result := locale.translation("Workbench mode")	end
	l_working_directory: STRING_GENERAL is 		do Result := locale.translation("Working directory")	end
	l_Working_formatter (a_command_name, a_object_name: STRING_GENERAL; a_for_class: BOOLEAN): STRING_GENERAL is
		require
			a_command_name_not_void: a_command_name /= Void
			a_object_name_not_voi: a_object_name /= Void
		do
			if a_for_class then
				Result := locale.formatted_string (locale.translation("Extracting $1 of class $2..."), [a_command_name, a_object_name])
			else
				Result := locale.formatted_string (locale.translation("Extracting $1 of feature `$2'..."), [a_command_name, a_object_name])
			end
		end

	l_Header_class (a_command_name, a_class_name: STRING_GENERAL): STRING_GENERAL is
		require
			a_command_name_not_void: a_command_name /= Void
			a_class_name_not_void: a_class_name /= Void
		do
			Result := locale.formatted_string (locale.translation ("$1 of class $2"), [a_command_name, a_class_name])
		end

	l_Header_feature (a_command_name, a_feat_name, a_class_name: STRING_GENERAL): STRING_GENERAL is
		require
			a_command_name_not_void: a_command_name /= Void
			a_feat_name_not_void: a_feat_name /= Void
			a_class_name_not_void: a_class_name /= Void
		do
			Result := locale.formatted_string (locale.translation ("$1 of feature `$2' of class $3"), [a_command_name, a_feat_name, a_class_name])
		end

	l_Header_dependency (a_command_name, a_object_name: STRING_GENERAL): STRING_GENERAL is
		require
			a_command_name_not_void: a_command_name /= Void
			a_object_name: a_object_name /= Void
		do
			Result := locale.formatted_string (locale.translation ("$1 of $2"), [a_command_name, a_object_name])
		end

	l_temp_header_dependency (a_command_name, a_object_name: STRING_GENERAL): STRING_GENERAL is
		require
			a_command_name_not_void: a_command_name /= Void
			a_object_name: a_object_name /= Void
		do
			Result := locale.formatted_string (locale.translation ("Extracting $1 of $2 ..."), [a_command_name, a_object_name])
		end

	l_history_discarded_string: STRING_GENERAL is do Result := locale.translation ("--- History discarded ---") end

	l_item_is_attached_to (a_title, a_name: STRING_GENERAL): STRING_GENERAL is
		require
			a_title_not_void: a_title /= Void
			a_name_not_void: a_name /= Void
		do
			Result := locale.formatted_string (locale.translation ("Item [$1] is attached to %"$2%""), [a_title, a_name])
		end

	l_move_to (a_title, a_name: STRING_GENERAL): STRING_GENERAL is
		require
			a_title_not_void: a_title /= Void
			a_name_not_void: a_name /= Void
		do
			Result := locale.formatted_string (locale.translation ("Move [$1] to %"$2%""), [a_title, a_name])
		end

	l_from_class (a_class: STRING_GENERAL): STRING_GENERAL is
		require
			a_class_not_void: a_class /= Void
		do
			Result := locale.formatted_string (locale.translation (" (from $1)"), [a_class])
		end

	l_one_from_two (a_one, a_two: STRING_GENERAL): STRING_GENERAL is
		require
			a_one_not_void: a_one /= Void
			a_two_not_void: a_two /= Void
		do
			Result := locale.formatted_string (locale.translation ("$1 (from $2)"), [a_one, a_two])
		end

	l_feature_has_rescue_clause: STRING_GENERAL is
		do
			Result := locale.translation ("%N   + feature has a rescue clause")
		end

	l_module_is (a_module: STRING_GENERAL): STRING_GENERAL is
		require
			a_module_not_void: a_module /= Void
		do
			Result := locale.formatted_string (locale.translation ("%N   + Module = $1"), [a_module])
		end

	l_break_index_is (a_index: STRING_GENERAL): STRING_GENERAL is
		require
			a_index_not_void: a_index /= Void
		do
			Result := locale.formatted_string (locale.translation ("%N   + break index = $1"), [a_index])
		end

	l_address_is (a_address: STRING_GENERAL): STRING_GENERAL is
		require
			a_address_not_void: a_address /= Void
		do
			Result := locale.formatted_string (locale.translation ("%N   + address     = <$1>"), [a_address])
		end

	l_context_is (a_context: STRING_GENERAL): STRING_GENERAL is
		require
			a_context_not_void: a_context /= Void
		do
			Result := locale.formatted_string (locale.translation ("%NCONTEXT: $1%N"), [a_context])
		end

	l_not_eiffel_class_file (a_stone_signature, a_file_name: STRING_GENERAL): STRING_GENERAL is
		require
			a_stone_signature_not_void: a_stone_signature /= Void
			a_file_name_not_void: a_file_name /= Void
		do
			Result := locale.formatted_string (locale.translation ("$1(not an Eiffel class file)   located in $2"), [a_stone_signature, a_file_name])
		end

	l_classi_header (a_sig, a_group_name, a_file_name: STRING_GENERAL): STRING_GENERAL is
		require
			a_sig_not_void: a_sig /= Void
			a_group_name_not_void: a_group_name /= Void
			a_file_name_not_void: a_file_name /= Void
		do
			Result := locale.formatted_string (locale.translation ("$1  in cluster $2  (not in system)  located in $3"), [a_sig, a_group_name, a_file_name])
		end

	l_classc_header (a_sig, a_group_name, a_file_name: STRING_GENERAL): STRING_GENERAL is
		require
			a_sig_not_void: a_sig /= Void
			a_group_name_not_void: a_group_name /= Void
			a_file_name_not_void: a_file_name /= Void
		do
			Result := locale.formatted_string (locale.translation ("$1  in cluster $2  located in $3"), [a_sig, a_group_name, a_file_name])
		end

	l_classc_header_precompiled (a_sig, a_group_name: STRING_GENERAL): STRING_GENERAL is
		require
			a_sig_not_void: a_sig /= Void
			a_group_name_not_void: a_group_name /= Void
		do
			Result := locale.formatted_string (locale.translation ("$1  in cluster $2  (precompiled)"), [a_sig, a_group_name])
		end

	l_located_in (a_s: STRING_GENERAL): STRING_GENERAL is
		require
			a_s_not_void: a_s /= Void
		do
			Result := locale.formatted_string (locale.translation (" (located in $1)"), [a_s])
		end

	l_replace_report (a_item_num, a_class_num: INTEGER): STRING_GENERAL is
		do
			Result := locale.formatted_string (locale.plural_translation ("   $1 replaced in $2 class", "   $1 replaced in $2 classes", a_class_num), [a_item_num, a_class_num])
		end

	l_from (a_str1, a_str2: STRING_GENERAL): STRING_GENERAL is
		require
			a_str1_not_void: a_str1 /= Void
			a_str2_not_void: a_str2 /= Void
		do
			Result := locale.formatted_string (locale.translation ("$1 from $2"), [a_str1, a_str2])
		end

	l_object_name: STRING_GENERAL is do Result := locale.translation ("OBJECT NAME: ") end
	l_compilation_equal_melted: STRING_GENERAL is do Result := locale.translation ("%N   + compilation = melted") end
	l_compilation_was_not_successful: STRING_GENERAL is do Result := locale.translation ("Compilation was not successful.") end
	l_expression_capital: STRING_GENERAL is do Result := locale.translation ("EXPRESSION: ") end
	l_disabled: STRING_GENERAL is do Result := locale.translation ("Disabled") end
	l_updating (a_class: STRING_GENERAL): STRING_GENERAL is
		require
			a_class_not_void: a_class /= Void
		do
			Result := locale.formatted_string (locale.translation ("Updating $1"), [a_class])
		end

	l_update_the_view: STRING_GENERAL is do Result := locale.translation ("Updating the view ...") end
	l_unevaluated: STRING_GENERAL is do Result := locale.translation ("Unevaluated") end
	l_error_occurred: STRING_GENERAL is do Result := locale.translation ("ERROR OCCURRED: %N") end
	l_error_occurred_click: STRING_GENERAL is do Result := locale.translation ("Error occurred (double click to see details)") end
	l_error_with_line (a_name: STRING_GENERAL; a_line: STRING_GENERAL): STRING_GENERAL is
		do
			Result := locale.formatted_string (locale.translation ("Error with `$1' line $2"), [a_name, a_line])
		end

	l_exception_object: STRING_GENERAL is do Result := locale.translation ("Exception object") end
	l_exclude_colon: STRING_GENERAL is	do Result := locale.translation("Exclude:")	end
	l_type_capital: STRING_GENERAL is do Result := locale.translation ("TYPE: ") end
	l_value_capital: STRING_GENERAL is do Result := locale.translation ("VALUE: ") end
	l_precompiled: STRING_GENERAL is do Result := locale.translation ("  (precompiled)") end
	l_Tab_external_output: STRING_GENERAL is    do Result := locale.translation("Console")	end
	l_Tab_C_output: STRING_GENERAL is    		do Result := locale.translation("C Output")	end
	l_Tab_warning_output: STRING_GENERAL is    	do Result := locale.translation("Warnings")	end
	l_Tab_error_output: STRING_GENERAL is    	do Result := locale.translation("Errors")	end
	l_show_feature_from_any: STRING_GENERAL is  do Result := locale.translation("Features from ANY")	end
	l_show_tooltip: STRING_GENERAL is do Result := locale.translation("Tooltip")	end
	h_show_feature_from_any: STRING_GENERAL is  do Result := locale.translation("Show unchanged features from class ANY?")	end
	h_show_tooltip: STRING_GENERAL is do Result := locale.translation("Show tooltips?")	end
	h_show_item_location: STRING_GENERAL is do Result := locale.translation("Show class location?")	end
	l_class_browser_classes: STRING_GENERAL is do Result := locale.translation("Class")	end
	l_class_browser_Path: STRING_GENERAL is do Result := locale.translation("Path")	end
	l_class_browser_features: STRING_GENERAL is do Result := locale.translation("Feature")	end
	l_version_from: STRING_GENERAL is do Result := locale.translation("Declared in class")	end
	l_version_in (a_class: STRING_GENERAL): STRING_GENERAL is do Result := locale.formatted_string (locale.translation("Version from class $1"), [a_class])	end
	l_branch (a_bra: INTEGER): STRING_GENERAL is do Result := locale.formatted_string (locale.translation("Branch #$1"), [a_bra.out]) end
	l_version_from_message: STRING is " (version from)"
	l_expand_layer: STRING_GENERAL is do Result := locale.translation("Expand selected level(s)")	end
	l_collapse_layer: STRING_GENERAL is do Result := locale.translation("Collapse selected level(s)")	end
	l_collapse_all_layers: STRING_GENERAL is do Result := locale.translation("Collapse all selected level(s)")	end
	l_searching_selected_file: STRING_GENERAL is do Result := locale.translation("Searching selected file...")	end
	l_selected_file_not_found: STRING_GENERAL is do Result := locale.translation("Selected text is not a valid file name or the file cannot be found")	end
	l_select_cluster_to_display: STRING_GENERAL is do Result := locale.translation("Select a cluster to display available views")	end
	l_select_cluster_to_generate: STRING_GENERAL is do Result := locale.translation("Select clusters to generate documentation for")	end
	l_select_diagrams_to_generate: STRING_GENERAL is do Result := locale.translation("Select the diagrams to generate")	end
	l_select_directory_to_generate: STRING_GENERAL is do Result := locale.translation("Select directory to generate the documentation in")	end
	l_select_feature_type: STRING_GENERAL is do Result := locale.translation("Select feature type")	end
	l_select_format_for_output: STRING_GENERAL is do Result := locale.translation("Select format for output")	end
	l_select_format_to_use: STRING_GENERAL is do Result := locale.translation("Select the formats to use")	end
	l_select_indexing_to_generate: STRING_GENERAL is do Result := locale.translation("Select indexing items to include in HTML meta tags")	end
	l_select_the_view: STRING_GENERAL is do Result := locale.translation("Select the view you want to use")	end
	l_select_another_view: STRING_GENERAL is do Result := locale.translation("Select another view if you want to save current placement.")	end
	l_stiffness: STRING_GENERAL is do Result := locale.translation("Stiffness:")	end
	l_wrap: STRING_GENERAL is do Result := locale.translation("wrap")	end
	l_manage_external_commands: STRING_GENERAL is do Result := locale.translation("Add, remove or edit external commands")	end
	l_module: STRING_GENERAL is do Result := locale.translation ("Module") end
	l_callees: STRING_GENERAL is do Result := locale.translation("Callees")	end
	l_assignees: STRING_GENERAL is do Result := locale.translation("Assignees")	end
	l_created: STRING_GENERAL is do Result := locale.translation("Creations")	end
	l_filter: STRING_GENERAL is do Result := locale.translation("Filter: ")	end
	l_function: STRING_GENERAL is do Result := locale.translation("Function")	end
	l_view: STRING_GENERAL is do Result := locale.translation ("View ") end
	l_zoom: STRING_GENERAL is do Result := locale.translation ("Zoom ") end
	l_viewpoints: STRING_GENERAL is do Result := locale.translation("Viewpoints")	end
	l_viewpoints_colon: STRING_GENERAL is do Result := locale.translation("Viewpoints: ")	end
	l_Tab_metrics: STRING_GENERAL is do Result := locale.translation("Metric")	end
	l_callers_from_client_class: STRING_GENERAL is do Result := locale.translation("Callers from client class") end
	l_callees_from_supplier_class: STRING_GENERAL is do Result := locale.translation("Callees from supplier class") end
	l_from_x: STRING is do Result := locale.translation ("From ") end
	h_categorize_folder: STRING_GENERAL is do Result := locale.translation("Categorize classes in folder?") end
	h_show_syntactical_classes: STRING_GENERAL is do Result := locale.translation("Show only syntactically referenced classes?") end
	h_show_normal_referenced_classes: STRING_GENERAL is do Result := locale.translation("Show normal referenced classes?") end
	h_show_ancestor_classes: STRING_GENERAL is do Result := locale.translation("Show ancestor classes?") end
	h_show_descendant_classes: STRING_GENERAL is do Result := locale.translation("Show descendant classes?") end
	l_invalid_item: STRING is do Result := locale.translation ("Invalid item") end
	l_application_target: STRING is do Result := locale.translation ("Application target") end
	l_delayed_item: STRING is do Result := locale.translation ("Delayed item") end
	l_ellipsis: STRING is "..."
	l_ancestor_of: STRING is do Result := locale.translation ("Ancestor of ") end
	l_descendant_of: STRING is do Result := locale.translation ("Descendant of ") end
	l_syntactical_supplier_of: STRING is do Result := locale.translation ("Syntactical supplier of ") end
	l_syntactical_client_of: STRING is do Result := locale.translation ("Syntactical client of ") end

	l_Tab_dependency_info: STRING_GENERAL is do Result := locale.translation("Dependency")	end
	l_client_class: STRING_GENERAL is do Result := locale.translation("Client class")	end
	l_supplier_class: STRING_GENERAL is do Result := locale.translation("Supplier class")	end
	l_client_group: STRING_GENERAL is do Result := locale.translation("Client group")	end
	l_supplier_group: STRING_GENERAL is do Result := locale.translation("Supplier group")	end
	h_show_dependency_on_self: STRING_GENERAL is do Result := locale.translation("Show dependency on self?")	end
	l_of: STRING_GENERAL is do Result := locale.translation(" of ")	end
	l_offset_is (a_offset: STRING_GENERAL): STRING_GENERAL is
		require
			a_offset_not_void: a_offset /= Void
		do
			Result := locale.formatted_string (locale.translation ("offset $1"), [a_offset])
		end

	l_hit_count_is (a_hit_count: INTEGER): STRING_GENERAL is
		do
			Result := locale.formatted_string (locale.plural_translation ("$1 hit", "$1 hits", a_hit_count), [a_hit_count])
		end

	l_info_cannot_be_retrieved: STRING_GENERAL is do Result := locale.translation("Information cannot be retrieved.")	end
	l_feature_in_client_class: STRING_GENERAL is do Result := locale.translation("Feature in client class")	end
	l_feature_in_supplier_class: STRING_GENERAL is do Result := locale.translation("Feature in supplier class")	end
	l_select_element_to_show_info: STRING_GENERAL is do Result := locale.translation("Select a target/group/folder/class to show information about it.")	end
	l_location: STRING_GENERAL is do Result := locale.translation("Location")	end

	l_file_exits (s: STRING_GENERAL): STRING_GENERAL is
		require
			s_not_void: s /= Void
		do
			Result := locale.formatted_string (locale.translation ("File $1 already exists,%N Do you want to ?"), [s])
		end

	l_target_domain_item: STRING_GENERAL is do Result := locale.translation ("target item") end
	l_group_domain_item: STRING_GENERAL is do Result := locale.translation ("group item") end
	l_folder_domain_item: STRING_GENERAL is do Result := locale.translation ("folder item") end
	l_class_domain_item: STRING_GENERAL is do Result := locale.translation ("class item") end
	l_feature_domain_item: STRING_GENERAL is do Result := locale.translation ("feature item") end
	l_delayed_domain_item: STRING_GENERAL is do Result := locale.translation ("delayed item") end

	h_search_for_class_recursively: STRING_GENERAL is do Result := locale.translation ("Search folder for classes recursively?") end
	l_save_layout_name: STRING_GENERAL is do Result := locale.translation ("Enter or select a name to save the current layout as.") end
	l_shortcut_modification_denied: STRING_GENERAL is do Result := locale.translation ("Shortcut modification failed. It is either used by a fixed shortcut or reserved by the system.") end
	l_layout_name: STRING_GENERAL is do Result := locale.translation ("Name:") end
	l_existing_layout_names: STRING_GENERAL is do Result := locale.translation ("Existing Layouts:") end
	l_overwrite_layout (a_name: STRING_GENERAL): STRING_GENERAL is do Result := locale.formatted_string (locale.translation ("A layout with the name '$1' already exists. Do you want to overwrite?"), [a_name]) end
	l_open_layout_error: STRING_GENERAL is do Result := locale.translation ("Open layout error. Opening default layout instead.") end
	l_open_layout_not_possible: STRING_GENERAL is do Result := locale.translation ("It's not possible to open named layout which saved in normal mode during debugging. Please stop debugging first.") end
	l_open_exception_dialog_tooltip: STRING_GENERAL is do Result := locale.translation ("Open exception dialog for more details") end

	h_click_to_open: STRING_GENERAL is do Result := locale.translation ("Click to open") end
	l_layout: STRING_GENERAL is do Result := locale.translation ("Layout") end
	l_tooltip_lbl: STRING_GENERAL is do Result := locale.translation ("Tooltip") end
	l_header: STRING_GENERAL is do Result := locale.translation ("Header") end
	l_temp_header: STRING_GENERAL is do Result := locale.translation ("Temporary header") end
	l_pixmap_file: STRING_GENERAL is do Result := locale.translation ("Pixmap File") end
	l_metric_name: STRING_GENERAL is do Result := locale.translation ("Metric Name") end
	l_metric_filter: STRING_GENERAL is do Result := locale.translation ("Metric Filter") end
	l_eiffelstudio: STRING_GENERAL is do Result := locale.translation ("EiffelStudio") end
	l_locale: STRING_GENERAL is do Result := locale.translation ("Locale:") end
	l_target_scope_customzied_formatter_not_saved: STRING_GENERAL is do Result := locale.translation ("The customized formatters with target scope will not be saved because a project has not been loaded.") end
	l_discard_target_scope_customized_formatter: STRING_GENERAL is do Result := locale.translation ("Don't ask me again and discard%Nunsaved target scope customized formatters.") end

	l_go_to_next_error: STRING_GENERAL is 				do Result := locale.translation ("Go to next error") end
	l_go_to_previous_error: STRING_GENERAL is 			do Result := locale.translation ("Go to previous error") end
	l_go_to_next_warning: STRING_GENERAL is 			do Result := locale.translation ("Go to next warning") end
	l_go_to_previous_warning: STRING_GENERAL is 		do Result := locale.translation ("Go to previous warning") end

	l_always_compile_before_debug:STRING_GENERAL is 	do Result := locale.translation ("always compile before executing.") end

	l_show_help:STRING_GENERAL is 	do Result := locale.translation ("Show Help...") end
	l_hide_help:STRING_GENERAL is 	do Result := locale.translation ("Hide Help...") end

feature -- Label text, no translation (for the editor)

	le_version_from_message: STRING is " (version from)"
	le_branch (a_bra: INTEGER): STRING is do Result := "Branch #" + a_bra.out end
	le_Location_colon: STRING is 				"Location: "
	le_Stop_point_reached: STRING is		"Breakpoint reached"
	le_Execution_interrupted: STRING is	"Execution interrupted"
	le_Explicit_exception_pending: STRING is "Explicit exception pending"
	le_Implicit_exception_pending: STRING is "Implicit exception pending"
	le_New_breakpoint: STRING is			"New breakpoint(s) to commit"
	le_Stepped: STRING is				"Step completed"
	le_Unknown_status: STRING is			"Unknown application status"
	le_versions: STRING is 				"versions"

feature -- Stone names

	s_Class_stone: STRING_GENERAL is			do Result := locale.translation("Class ")	end
	s_Cluster_stone: STRING_GENERAL is			do Result := locale.translation("Cluster ")	end
	s_Feature_stone: STRING_GENERAL is			do Result := locale.translation("Feature ")	end
	s_Assembly_stone: STRING_GENERAL is			do Result := locale.translation("Assembly ")	end
	s_folder_stone: STRING_GENERAL is			do Result := locale.translation("Folder ")	end
	s_library_stone: STRING_GENERAL is			do Result := locale.translation("Library ")	end
	s_target_stone: STRING_GENERAL is 			do Result := locale.translation("Target ")	end

feature -- Fixed shortcut names

	fs_focus_on_editor: STRING_GENERAL is			do Result := locale.translation ("Focus on current editor") end
	fs_undo_command: STRING_GENERAL is				do Result := locale.translation ("Undo command") end
	fs_redo_command: STRING_GENERAL is				do Result := locale.translation ("Redo command") end
	fs_close_window: STRING_GENERAL is				do Result := locale.translation ("Close window") end
	fs_cut: STRING_GENERAL is						do Result := locale.translation ("Cut") end
	fs_copy: STRING_GENERAL is						do Result := locale.translation ("Copy") end
	fs_paste: STRING_GENERAL is						do Result := locale.translation ("Paste") end
	fs_select_all: STRING_GENERAL is				do Result := locale.translation ("Select all") end
	fs_indent: STRING_GENERAL is					do Result := locale.translation ("Indent") end
	fs_unindent: STRING_GENERAL is					do Result := locale.translation ("Unindent") end
	fs_debug_menu: STRING_GENERAL is				do Result := locale.translation ("Execution menu") end

feature -- Title part

	t_About: STRING_GENERAL is
		once
			Result := locale.formatted_string (locale.translation ("About $1"), [workbench_name])
		end
	t_Add_search_scope: STRING_GENERAL is				do Result := locale.translation("Add Search Scope")	end
	t_Alias: STRING_GENERAL is							do Result := locale.translation("Alias")	end
	t_Calling_convention: STRING_GENERAL is				do Result := locale.translation("Calling Convention")	end
	t_Choose_class: STRING_GENERAL is					do Result := locale.translation("Choose a Class")	end
	t_Choose_directory: STRING_GENERAL is 				do Result := locale.translation("Choose Your Directory")	end
	t_Choose_folder_name: STRING_GENERAL is				do Result := locale.translation("Choose a Folder Name")	end
	t_choose_name_for_new_configuration_file: STRING_GENERAL is do Result := locale.translation ("Choose name for new configuration file") end
	t_Choose_project_and_directory: STRING_GENERAL is 	do Result := locale.translation("Choose Your Project Name and Directory")	end
	t_Class: STRING_GENERAL is							do Result := locale.translation("Class")	end
	t_Clients_of: STRING_GENERAL is						do Result := locale.translation("Clients of Class ")	end
	t_Creation_routine: STRING_GENERAL is				do Result := locale.translation("Creation Procedure")	end
	t_configuration_loading_error: STRING_GENERAL is	do Result := locale.translation("Configuration Loading Error")	end
	t_configuration_loading_message: STRING_GENERAL is	do Result := locale.translation("Configuration Loading Message")	end
	t_confirmation: STRING_GENERAL is					do Result := locale.translation ("Confirmation") end
	t_Customize_toolbar_text: STRING_GENERAL is 		do Result := locale.translation("Customize Toolbar")	end
	t_Default_print_job_name: STRING_GENERAL is
		once
			Result := locale.formatted_string (locale.translation("From $1"), [Workbench_name])
		end
	t_Deleting_files: STRING_GENERAL is					do Result := locale.translation("Deleting Files")	end
	t_Dummy: STRING_GENERAL is							do Result := locale.translation("Dummy")	end
	t_Dynamic_lib_window: STRING_GENERAL is 			do Result := locale.translation("Dynamic Library Builder")	end
	t_Dynamic_type: STRING_GENERAL is					do Result := locale.translation("In Class")	end
	t_Enter_condition: STRING_GENERAL is				do Result := locale.translation("Enter Condition")	end
	t_error: STRING_GENERAL is 							do Result := locale.translation ("Error") end
	t_Exported_feature: STRING_GENERAL is				do Result := locale.translation("Feature")	end
	t_Expression_evaluation: STRING_GENERAL is			do Result := locale.translation("Evaluation")	end
	t_Extended_explanation: STRING_GENERAL is			do Result := locale.translation("Compilation Error Wizard")	end
	t_external_command: STRING_GENERAL is				do Result := locale.translation("External Command")	end
	t_external_commands: STRING_GENERAL is				do Result := locale.translation("External Commands")	end
	t_External_edition: STRING_GENERAL is				do Result := locale.translation("External Edition")	end
	t_Feature: STRING_GENERAL is						do Result := locale.translation("In Feature")	end
	t_Feature_properties: STRING_GENERAL is				do Result := locale.translation("Feature Properties")	end
	t_File_selection: STRING_GENERAL is					do Result := locale.translation("File Selection")	end
	t_Find: STRING_GENERAL is							do Result := locale.translation("Find: ")	end
	t_finish_freezing_status: STRING_GENERAL is			do Result := locale.translation("Finish Freezing Status")	end
	t_Index: STRING_GENERAL is							do Result := locale.translation("Index")	end
	t_New_class: STRING_GENERAL is						do Result := locale.translation("New Class")	end
	t_New_cluster: STRING_GENERAL is					do Result := locale.translation("Add Cluster")	end
	t_New_expression: STRING_GENERAL is					do Result := locale.translation("New Expression")	end
	t_Edit_expression: STRING_GENERAL is				do Result := locale.translation("Edit Expression")	end
	t_New_project: STRING_GENERAL is					do Result := locale.translation("New Project")	end
	t_Open_backup: STRING_GENERAL is					do Result := locale.translation("Backup Found")	end
	t_Organize_favorites: STRING_GENERAL is				do Result := locale.translation("Organize Favorites")	end
	t_Profile_query_window: STRING_GENERAL is			do Result := locale.translation("Profile Query Window")	end
	t_Profiler_wizard: STRING_GENERAL is				do Result := locale.translation("Profiler Wizard")	end
	t_Project: STRING is
		once
			Result := Workbench_name
		end
	t_project_documentation: STRING_GENERAL is				do Result := locale.translation("Project documentation")	end
	t_Preference_window: STRING_GENERAL is				do Result := locale.translation("Preferences")	end
	t_save_backup: STRING_GENERAL is					do Result := locale.translation ("Save Backup") end
	t_Select_class: STRING_GENERAL is					do Result := locale.translation("Select Class")	end
	t_Select_cluster: STRING_GENERAL is					do Result := locale.translation("Select Cluster")	end
	t_Select_feature: STRING_GENERAL is					do Result := locale.translation("Select Feature")	end
	t_Select_a_file: STRING_GENERAL is					do Result := locale.translation("Select a File")	end
	t_Select_a_directory: STRING_GENERAL is				do Result := locale.translation("Select a Directory")	end
	t_Set_stack_depth: STRING_GENERAL is				do Result := locale.translation("Maximum Call Stack Depth")	end
	t_Set_critical_stack_depth: STRING_GENERAL is		do Result := locale.translation("Overflow Prevention")	end
	t_Static_type: STRING_GENERAL is					do Result := locale.translation("From Class")	end
	t_Starting_dialog: STRING is
		once
			Result := Workbench_name
		end
	t_precompile_progress: STRING_GENERAL is 			do Result := locale.translation ("Precompilation Progress") end
	t_Slice_limits: STRING_GENERAL is					do Result := locale.translation("Choose New Slice Limits for Special Objects")	end
	t_System: STRING_GENERAL is							do Result := locale.translation("Project Settings")	end
	t_target_selection: STRING_GENERAL is 				do Result := locale.translation ("Target Selection") end
	t_this_file_has_been_modified: STRING_GENERAL is 	do Result := locale.translation ("This file has been modified by another editor.") end
	t_Empty_development_window: STRING_GENERAL is 		do Result := locale.translation("Empty Development Tool")	end
	t_Autocomplete_window: STRING_GENERAL is			do Result := locale.translation("Auto-Complete")	end
	t_Diagram_class_header: STRING_GENERAL is			do Result := locale.translation("Class Header")	end
	t_Diagram_set_center_class (a_class_name: STRING_GENERAL): STRING_GENERAL is
		require
			a_class_name_not_void: a_class_name /= Void
		do
			Result := locale.formatted_string (locale.translation("Set Center Class: $1"), [a_class_name])
		end
	t_Diagram_context_depth: STRING_GENERAL is			do Result := locale.translation("Select Depths")	end
	t_Diagram_link_tool: STRING_GENERAL is				do Result := locale.translation("Link Tool")	end
	t_Diagram_delete_client_link: STRING_GENERAL is 	do Result := locale.translation("Choose Feature(s) to Delete")	end
	t_Diagram_history_tool: STRING_GENERAL is			do Result := locale.translation("History Tool")	end

	t_Diagram_move_class_cmd (a_name: STRING_GENERAL): STRING_GENERAL is
		require
			exists: a_name /= Void
		do
			Result := locale.formatted_string(locale.translation("Move Class '$1'"), [a_name])
		end

	t_Diagram_move_cluster_cmd (a_name: STRING_GENERAL): STRING_GENERAL is
		require
			exists: a_name /= Void
		do
			Result := locale.formatted_string(locale.translation("Move Cluster '$1'"),[a_name])
		end

	t_Diagram_move_midpoint_cmd: STRING_GENERAL is		do Result := locale.translation("Move Midpoint")	end

	t_Diagram_add_cs_link_cmd (client_name, supplier_name: STRING_GENERAL): STRING_GENERAL is
		require
			exists: client_name /= Void	and supplier_name /= Void
		do
			Result := locale.formatted_string(locale.translation("Add Client-Supplier Relation Between '$1' and '$2'"), [client_name, supplier_name])
		end

	t_Diagram_add_inh_link_cmd (ancestor_name, descendant_name: STRING_GENERAL): STRING_GENERAL is
		require
			exists: ancestor_name /= Void and descendant_name /= Void
		do
			Result := locale.formatted_string(locale.translation("Add Inheritance Relation Between '$1' and '$2'"), [ancestor_name, descendant_name])
		end

	t_Diagram_include_class_cmd (a_name: STRING_GENERAL): STRING_GENERAL is
		require
			exists: a_name /= Void
		do
			Result := locale.formatted_string(locale.translation("Include Class '$1'"), [a_name])
		end

	t_Diagram_include_cluster_cmd (a_name: STRING_GENERAL): STRING_GENERAL is
		require
			exists: a_name /= Void
		do
			Result := locale.formatted_string(locale.translation("Include Cluster '$1'"), [a_name])
		end

	t_Diagram_include_library_cmd (a_name: STRING_GENERAL): STRING_GENERAL is
		require
			exists: a_name /= Void
		do
			Result := locale.formatted_string(locale.translation("Include Library '$1'"),[a_name])
		end

	t_Diagram_insert_midpoint_cmd: STRING_GENERAL is	do Result := locale.translation("Insert Midpoint")	end
	t_Diagram_change_color_cmd: STRING_GENERAL is		do Result := locale.translation("Change Class Color")	end

	t_Diagram_rename_class_locally_cmd (old_name, new_name: STRING_GENERAL): STRING_GENERAL is
		require
			exists: old_name /= Void and new_name /= Void
		do
			Result := locale.formatted_string(locale.translation("Rename Class '$1' Locally to '$2'"), [old_name,new_name])
		end

	t_Diagram_rename_class_globally_cmd (old_name, new_name: STRING_GENERAL): STRING_GENERAL is
		require
			exists: old_name /= Void and new_name /= Void
		do
			Result := locale.formatted_string(locale.translation("Rename Class '$1' Globally to '$2'"), [old_name, new_name])
		end

	t_Diagram_delete_client_link_cmd (a_name: STRING_GENERAL): STRING_GENERAL is
		require
			exists: a_name /= Void
		do
			Result := locale.formatted_string(locale.translation("Delete Client Link '$1'") , [a_name])
		end

	t_Diagram_delete_inheritance_link_cmd (an_ancestor, a_descendant: STRING_GENERAL): STRING_GENERAL is
		require
			exists: an_ancestor /= Void and a_descendant /= Void
		do
			Result := locale.formatted_string(locale.translation("Delete Inheritance Link Between '$1' and '$2'"), [an_ancestor,a_descendant])
		end

	t_Diagram_erase_cluster_cmd (a_name: STRING_GENERAL): STRING_GENERAL is
		require
			exists: a_name /= Void
		do
			Result := locale.formatted_string(locale.translation("Erase Cluster '$1'"), [a_name])
		end

	t_Diagram_delete_midpoint_cmd: STRING_GENERAL is	do Result := locale.translation("Erase Midpoint")	end

	t_Diagram_erase_class_cmd (a_name: STRING_GENERAL): STRING_GENERAL is
		require
			exists: a_name /= Void
		do
			Result := locale.formatted_string(locale.translation("Erase Class '$1'"), [a_name])
		end

	t_Diagram_erase_classes_cmd: STRING_GENERAL is		do Result := locale.translation("Erase Classes")	end
	t_Diagram_put_right_angles_cmd: STRING_GENERAL is	do Result := locale.translation("Put Right Angles")	end
	t_Diagram_remove_right_angles_cmd: STRING_GENERAL is	do Result := locale.translation("Remove Right Angles")	end
	t_Diagram_put_one_handle_left_cmd: STRING_GENERAL is	do Result := locale.translation("Put Handle Left")	end
	t_Diagram_put_one_handle_right_cmd: STRING_GENERAL is	do Result := locale.translation("Put Handle Right")	end
	t_Diagram_put_two_handles_left_cmd: STRING_GENERAL is	do Result := locale.translation("Put Two Handles Left")	end
	t_Diagram_put_two_handles_right_cmd: STRING_GENERAL is	do Result := locale.translation("Put Two Handles Right")	end
	t_Diagram_remove_handles_cmd: STRING_GENERAL is		do Result := locale.translation("Remove Handles")	end
	t_Diagram_zoom_in_cmd: STRING_GENERAL is			do Result := locale.translation("Zoom In")	end
	t_Diagram_zoom_out_cmd: STRING_GENERAL is			do Result := locale.translation("Zoom Out")	end
	t_Diagram_zoom_cmd: STRING_GENERAL is				do Result := locale.translation("Zoom")	end

	t_Diagram_cluster_expand (a_name: STRING_GENERAL): STRING_GENERAL is
		require
			exists: a_name /= Void
		do
			Result := locale.formatted_string(locale.translation("Expand cluster '$1'"), [ a_name])
		end

	t_Diagram_cluster_collapse (a_name: STRING_GENERAL): STRING_GENERAL is
		require
			exists: a_name /= Void
		do
			Result := locale.formatted_string(locale.translation("Collapse Cluster '$1'"), [a_name])
		end

	t_Diagram_disable_high_quality: STRING_GENERAL is	do Result := locale.translation("Disable High Quality")	end
	t_Diagram_enable_high_quality: STRING_GENERAL is	do Result := locale.translation("Enable High Quality")	end

	t_first_match_reached: STRING_GENERAL is	do Result := locale.translation("Initial match reached.")	end
	t_finish_freezing_launch_error: STRING_GENERAL is 	do Result := locale.translation("finish_freezing Launch Error")	end
	t_bottom_reached: STRING_GENERAL is 	do Result := locale.translation("Bottom reached.")	end
	t_go_to_line: STRING_GENERAL is				do Result := locale.translation ("Go to line") end
	t_refactoring_feature_rename: STRING_GENERAL is	do Result := locale.translation("Refactoring: Feature Rename (Compiled Classes)")	end
	t_refactoring_class_select: STRING_GENERAL is do Result := locale.translation("Select Class")	end
	t_refactoring_class_rename: STRING_GENERAL is do Result := locale.translation("Refactoring: Class Rename")	end
	t_select_working_directory: STRING_GENERAL is do Result := locale.translation("Select working directory")	end

	t_Breakpoints_tool: STRING_GENERAL is				do Result := locale.translation ("Breakpoints")	end
	t_Call_stack_tool: STRING_GENERAL is				do Result := locale.translation ("Call Stack")	end
	t_Cluster_tool: STRING_GENERAL is					do Result := locale.translation ("Clusters")	end
	t_Context_tool: STRING_GENERAL is					do Result := locale.translation ("Context")	end
	t_Object_viewer_tool: STRING_GENERAL is				do Result := locale.translation ("Object Viewer")	end
	t_Favorites_tool: STRING_GENERAL is					do Result := locale.translation ("Favorites")	end
	t_metric_tool: STRING_GENERAL is 					do Result := locale.translation ("Metrics")	end
	t_Object_tool: STRING_GENERAL is					do Result := locale.translation ("Objects")	end
	t_threads_tool: STRING_GENERAL is					do Result := locale.translation ("Threads")	end
	t_Properties_tool: STRING_GENERAL is				do Result := locale.translation ("Properties")	end
	t_question: STRING_GENERAL is 						do Result := locale.translation ("Question") end
	t_Search_tool: STRING_GENERAL is					do Result := locale.translation ("Search")	end
	t_Search_Report_tool: STRING_GENERAL is				do Result := locale.translation ("Search Report")	end
	t_Windows_tool: STRING_GENERAL is					do Result := locale.translation ("Windows")	end
	t_Watch_tool: STRING_GENERAL is						do Result := locale.translation ("Watch")	end
	t_watch_tool_error_message: STRING_GENERAL is		do Result := locale.translation ("Watch tool :: error message")	end
	t_warning: STRING_GENERAL is 						do Result := locale.translation ("Warning") end
	t_Features_tool: STRING_GENERAL is					do Result := locale.translation ("Features")	end
	t_Editor: STRING_GENERAL is							do Result := locale.translation("Editor")	end
	t_execution_parameters: STRING_GENERAL is			do Result := locale.translation("Execution Parameters")	end
	t_contract_tool: STRING_GENERAL is					do Result := locale.translation ("Contract Editor") end

	t_Standard_toolbar: STRING_GENERAL is				do Result := locale.translation ("Standard Buttons") end
	t_Address_toolbar: STRING_GENERAL is				do Result := locale.translation ("Address Bar") end
	t_physics_setting: STRING_GENERAL is				do Result := locale.translation ("Physics settings") end
	t_Project_toolbar: STRING_GENERAL is				do Result := locale.translation ("Project Bar") end
	t_Refactory_toolbar: STRING_GENERAL is				do Result := locale.translation ("Refactoring Bar") end

	t_dialog_title (a_name: STRING_GENERAL): STRING_GENERAL is
		do
			Result := locale.formatted_string (locale.translation ("Edit $1"), [a_name])
		end

	t_Save_layout_as: STRING_GENERAL is 				do Result := locale.translation ("Save Layout As...") end
	t_Open_layout: STRING_GENERAL is					do Result := locale.translation ("Open Layout") end
	t_Overwite_layout: STRING_GENERAL is				do Result := locale.translation ("Overwrite Layout") end
	t_open_c_file: STRING_GENERAL is					do Result := locale.translation ("Open C file") end
	t_reference_position: STRING_GENERAL is				do Result := locale.translation ("Positions") end
	t_customized_formatter_setup: STRING_GENERAL is 	do Result := locale.translation ("Setup customized formatters") end
	t_errors_and_warnings_tool: STRING_GENERAL is		do Result := locale.translation ("Error List") end

	t_eiffelstudio_error: STRING_GENERAL is				do Result := locale.translation ("EiffelStudio Error") end
	t_eiffelstudio_warning: STRING_GENERAL is			do Result := locale.translation ("EiffelStudio Warning") end
	t_eiffelstudio_question: STRING_GENERAL is			do Result := locale.translation ("EiffelStudio Question") end
	t_eiffelstudio_info: STRING_GENERAL is				do Result := locale.translation ("EiffelStudio Information") end
	t_debugger_error: STRING_GENERAL is					do Result := locale.translation ("EiffelStudio Error") end
	t_debugger_warning: STRING_GENERAL is				do Result := locale.translation ("EiffelStudio Warning") end
	t_debugger_question: STRING_GENERAL is				do Result := locale.translation ("EiffelStudio Question") end
	t_debugger_info: STRING_GENERAL is					do Result := locale.translation ("EiffelStudio Information") end

feature -- Sub titles

		-- Debugger
	st_compile_changes: STRING_GENERAL is		do Result := locale.translation ("Uncompile changes") end
	st_exit_eiffelstudio: STRING_GENERAL is		do Result := locale.translation ("Exit EiffelStudio") end
	st_unsaved_changed: STRING_GENERAL is		do Result := locale.translation ("You have unsaved changes") end
	st_cleaning_project: STRING_GENERAL is		do Result := locale.translation ("Cleaning project...") end

feature -- Titles translation needless (Title Original) for preference strings.

	to_Breakpoints_tool: STRING is				"Breakpoints"
	to_Call_stack_tool: STRING is				"Call Stack"
	to_Cluster_tool: STRING is					"Clusters"
	to_Context_tool: STRING is					"Context"
	to_Favorites_tool: STRING is				"Favorites"
	to_Object_tool: STRING is					"Objects"
	to_threads_tool: STRING is					"Threads"
	to_Properties_tool: STRING is				"Properties"
	to_Search_tool: STRING is					"Search"
	to_Search_Report_tool: STRING is			"Search Report"
	to_Windows_tool: STRING is					"Windows"
	to_Watch_tool: STRING is					"Watch"
	to_Object_viewer_tool: STRING is			"Object Viewer"
	to_Features_tool: STRING is					"Features"
	to_Editor: STRING is						"Editor"

	to_Output_tool: STRING is					"Output"
	to_Diagram_tool: STRING is					"Diagram"
	to_Class_tool: STRING is					"Class"
	to_Feature_relation_tool: STRING is			"Feature Relation"
	to_Dependency_tool: STRING is				"Dependency"
	to_Metric_tool: STRING is					"Metrics"
	to_External_Ouput_tool: STRING is			"External Output"
	to_C_Output_tool: STRING is					"C Output"
	to_Error_list_tool: STRING is				"Error List"

	to_name: STRING is 							"Name"
	to_expression: STRING is 					"Expression"
	to_value: STRING is							"Value"
	to_type: STRING is							"Type"
	to_address: STRING is						"Address"
	to_context: STRING is						"Context"
	to_context_dot: STRING is					"Context ..."

	to_Address_toolbar: STRING is				"Address Bar"
	to_Standard_toolbar: STRING is				"Standard Buttons"
	to_Project_toolbar: STRING is				"Project Bar"
	to_Refactory_toolbar: STRING is				"Refactoring Bar"

feature -- Description texts

	e_Add_exported_feature: STRING_GENERAL is	do Result := locale.translation("Add a new feature to this dynamic library definition")	end
	e_Bkpt_info: STRING_GENERAL is				do Result := locale.translation("Show information about breakpoints")	end
	e_Check_exports: STRING_GENERAL is			do Result := locale.translation("Check the validity of the library definition")	end
	e_Compilation_failed: STRING_GENERAL is		do Result := locale.translation("Eiffel Compilation Failed")	end
	e_Compilation_succeeded: STRING_GENERAL is	do Result := locale.translation("Eiffel Compilation Succeeded")	end
	e_freezing_failed: STRING_GENERAL is 		do Result := locale.translation("Background Workbench C Compilation Failed")	end
	e_finalizing_failed: STRING_GENERAL is		do Result := locale.translation("Background Finalized C compilation Failed")	end
	e_Force_debug_mode: STRING_GENERAL is		do Result := locale.translation("Force the environment to stay in debug mode")	end
	e_freezing_launch_failed: STRING_GENERAL is 		do Result := locale.translation("Background Workbench C Compilation Launch Failed")	end
	e_finalizing_launch_failed: STRING_GENERAL is		do Result := locale.translation("Background Finalized C Compilation Launch Failed")	end
	e_freezing_launched: STRING_GENERAL is 		do Result := locale.translation("Background Workbench C Compilation Launched")	end
	e_finalizing_launched: STRING_GENERAL is 	do Result := locale.translation("Background Finalized C Compilation Launched")	end
	e_freezing_succeeded: STRING_GENERAL is 	do Result := locale.translation("Background Workbench C Compilation Succeeded")	end
	e_finalizing_succeeded: STRING_GENERAL is	do Result := locale.translation("Background Finalized C Compilation Succeeded")	end
	e_freezing_terminated: STRING_GENERAL is 	do Result := locale.translation("Background Workbench C Compilation Terminated")	end
	e_finalizing_terminated: STRING_GENERAL is 	do Result := locale.translation("Background Finalized C Compilation Terminated")	end
	e_C_compilation_failed: STRING_GENERAL is 	do Result := locale.translation("Background C Compilation Failed")	end
	e_C_compilation_launch_failed: STRING_GENERAL is do Result := locale.translation("Background C Compilation Launch Failed")	end
	e_C_compilation_terminated: STRING_GENERAL is do Result := locale.translation("Background C Compilation Terminated")	end
	e_C_compilication_launched: STRING_GENERAL is do Result := locale.translation("Background C Compilation Launched")	end
	e_C_compilation_succeeded: STRING_GENERAL is do Result := locale.translation("Background C Compilation Succeeded")	end
	e_C_compilation_running: STRING_GENERAL is  do Result := locale.translation("Background C Compilation in Progress")	end
	e_Compiling: STRING_GENERAL is				do Result := locale.translation("System is being compiled")	end
	e_Copy_call_stack_to_clipboard: STRING_GENERAL is do Result := locale.translation("Copy call stack to clipboard")	end
	e_Cursor_position: STRING_GENERAL is		do Result := locale.translation("Cursor position (line:column)")	end
	e_Diagram_hole: STRING_GENERAL is			do Result := locale.translation("Please drop a class or a cluster on this button %N%
										%to view its diagram.%N%
										%Use right click for both pick and drop actions.")	end
	e_Diagram_class_header: STRING_GENERAL is 	do Result := locale.translation("Please drop a class on this button.%NUse right click for both%N%
										%pick and drop actions.")	end
	e_Diagram_remove_anchor: STRING_GENERAL is	do Result := locale.translation("Please drop a class or a cluster with an%Nanchor on this button.%NUse right click for both%N%
										%pick and drop actions.")	end
	e_Diagram_create_class: STRING_GENERAL is	do Result := locale.translation("Please drop this button on the diagram.%N%
										%Use right click for both%Npick and drop actions.")	end
	e_Diagram_delete_figure: STRING_GENERAL is	do Result := locale.translation("Please drop a class, a cluster or a midpoint%N%
										%on this button. Use right click for both%Npick and drop actions.")	end
	e_Diagram_add_class_figure_relations: STRING_GENERAL is do Result := locale.translation("A class figure(s) must either be selected%N%
										%or dropped on this button via right clicking.")	end
	e_Diagram_delete_item: STRING_GENERAL is	do Result := locale.translation("Please drop a class, a cluster or a link%N%
										%on this button. Use right click for both%Npick and drop actions.")	end
	e_Display_error_help: STRING_GENERAL is		do Result := locale.translation("Give help on compilation errors")	end
	e_Display_system_info: STRING_GENERAL is	do Result := locale.translation("Display information concerning current system")	end
	e_Drop_an_error_stone: STRING is	do Result := locale.translation(ee_Drop_an_error_stone)	end
	e_Edit_exported_feature: STRING_GENERAL is	do Result := locale.translation("Edit the properties of the selected feature")	end
	e_Edit_expression: STRING_GENERAL is		do Result := locale.translation("Edit the selected expression")	end
	e_Edited: STRING_GENERAL is					do Result := locale.translation("Some classes were edited since last compilation")	end
	e_Exec_debug: STRING_GENERAL is				do Result := locale.translation("Start execution and stop at breakpoints")	end
	e_Exec_debug_continue: STRING_GENERAL is	do Result := locale.translation("Continue execution and stop at breakpoints")	end
	e_Exec_kill: STRING_GENERAL is				do Result := locale.translation("Stop execution")	end
	e_Exec_into: STRING_GENERAL is				do Result := locale.translation("Step into a routine")	end
	e_Exec_no_stop: STRING_GENERAL is			do Result := locale.translation("Start execution without stopping at breakpoints")	end
	e_Exec_out: STRING_GENERAL is				do Result := locale.translation("Step out of a routine")	end
	e_Exec_step: STRING_GENERAL is				do Result := locale.translation("Execute execution one step at a time")	end
	e_Exec_stop: STRING_GENERAL is				do Result := locale.translation("Pause execution at current point")	end
	e_Exec_recompile: STRING_GENERAL is         do Result := locale.translation("Recompiling project will end current execution.") end
	e_History_back: STRING_GENERAL is			do Result := locale.translation("Back")	end
	e_History_forth: STRING_GENERAL is			do Result := locale.translation("Forward")	end
	e_Minimize_all: STRING_GENERAL is			do Result := locale.translation("Minimize all windows")	end
	e_New_context_tool: STRING_GENERAL is		do Result := locale.translation("Open a new context window")	end
	e_New_dynamic_lib_definition: STRING_GENERAL is	do Result := locale.translation("Create a new dynamic library definition")	end
	e_New_editor: STRING_GENERAL is				do Result := locale.translation("Open a new editor window")	end
	e_New_expression: STRING_GENERAL is			do Result := locale.translation("Create a new expression")	end
	e_Not_running: STRING_GENERAL is			do Result := locale.translation("Application is not running")	end
	e_Open_dynamic_lib_definition: STRING_GENERAL is do Result := locale.translation("Open a dynamic library definition")	end
	e_Open_file: STRING_GENERAL is				do Result := locale.translation("Open a file")	end
	e_Open_eac_browser: STRING_GENERAL is		do Result := locale.translation("Open the Eiffel Assembly Cache browser tool")	end
	e_Paste: STRING_GENERAL is					do Result := locale.translation("Paste")	end
	e_Paused: STRING_GENERAL is					do Result := locale.translation("Application is paused")	end
	e_Pretty_print: STRING_GENERAL is			do Result := locale.translation("Display an expanded view of objects")	end
	e_Print: STRING_GENERAL is					do Result := locale.translation("Print the currently edited text")	end
	e_Project_name: STRING_GENERAL is			do Result := locale.translation("Name of the current project")	end
	e_Project_settings: STRING_GENERAL is		do Result := locale.translation("Change project settings, right click to open external editor")	end
	e_override_scan: STRING_GENERAL is			do Result := locale.translation("Recompile override clusters")	end
	e_discover_melt: STRING_GENERAL is			do Result := locale.translation("Discover unreferenced externally added classes and recompile.")	end
	e_Raise_all: STRING_GENERAL is				do Result := locale.translation("Raise all windows")	end
	e_Raise_all_unsaved: STRING_GENERAL is		do Result := locale.translation("Raise all unsaved windows")	end
	e_Redo: STRING_GENERAL is					do Result := locale.translation("Redo")	end
	e_Remove_class_cluster: STRING_GENERAL is	do Result := locale.translation("Remove a class or a cluster from the system")	end
	e_Remove_exported_feature: STRING_GENERAL is	do Result := locale.translation("Remove the selected feature from this dynamic library definition")	end
	e_Remove_expressions: STRING_GENERAL is		do Result := locale.translation("Remove selected expressions")	end
	e_Remove_object: STRING_GENERAL is			do Result := locale.translation("Remove currently selected object")	end
	e_Restore_normal_mode: STRING_GENERAL is	do Result := locale.translation("Restore the environment to normal mode")	end
	e_Running: STRING_GENERAL is				do Result := locale.translation("Application is running")	end
	e_Running_no_stop_points: STRING_GENERAL is	do Result := locale.translation("Application is running (ignoring breakpoints)")	end
	e_Save_call_stack: STRING_GENERAL is		do Result := locale.translation("Save call stack to a text file")	end
	e_Save_exception_into: STRING_GENERAL is		do Result := locale.translation("Save exception message to a text file")	end
	e_Save_dynamic_lib_definition: STRING_GENERAL is do Result := locale.translation("Save this dynamic library definition")	end
	e_Show_class_cluster: STRING_GENERAL is		do Result := locale.translation("Locate currently edited class or cluster")	end
	e_Send_stone_to_context: STRING_GENERAL is	do Result := locale.translation("Synchronize context")	end
	e_description: STRING is do Result := "Separator" end
	e_Separate_stone: STRING_GENERAL is			do Result := locale.translation("Unlink the context tool from the other components")	end
	e_Set_stack_depth: STRING_GENERAL is		do Result := locale.translation("Set maximum call stack depth")	end
	e_Shell: STRING_GENERAL is					do Result := locale.translation("Send to external editor")	end
	e_Switch_num_format_to_hex: STRING_GENERAL is do Result := locale.translation("Switch to hexadecimal format")	end
	e_Switch_num_format_to_dec: STRING_GENERAL is do Result := locale.translation("Switch to decimal format")	end
	e_Switch_num_formating: STRING is do Result := locale.translation ("Hexadecimal/Decimal formating") end
	e_Toggle_state_of_expressions: STRING_GENERAL is		do Result := locale.translation("Enable/Disable expressions")	end
	e_Toggle_stone_management: STRING_GENERAL is do Result := locale.translation("Link or not the context tool to other components")	end
	e_Undo: STRING_GENERAL is					do Result := locale.translation("Undo")	end
	e_Up_to_date: STRING_GENERAL is				do Result := locale.translation("Executable is up-to-date")	end
	e_Unify_stone: STRING_GENERAL is			do Result := locale.translation("Link the context tool to the other components")	end
	e_Terminate_c_compilation: STRING_GENERAL is do Result := locale.translation("Terminate current C compilation in progress")	end

	e_Dbg_exception_handler: STRING_GENERAL is do Result := locale.translation("Exception handling")	end
	e_Dbg_assertion_checking: STRING_GENERAL is do Result := locale.translation("Disable or restore assertion checking handling during execution")	end

	e_open_selection_in_editor: STRING_GENERAL is do Result := locale.translation("Open selected file name in specified external editor")	end
	e_save_c_compilation_output: STRING_GENERAL is do Result := locale.translation("Save C Compilation output to file")	end
	e_go_to_w_code_dir: STRING_GENERAL is do Result := locale.translation("Go to W_code directory of this system, or right click to open W_code in specified file browser")	end
	e_go_to_f_code_dir: STRING_GENERAL is do Result := locale.translation("Go to F_code directory of this system, or right click to open F_code in specified file browser")	end
	e_open_c_file: STRING_GENERAL is do Result := locale.translation ("Drop a class/feature here to open its corresponding C file/function in external editor.") end
	e_go_to_project_dir: STRING_GENERAL is do Result := locale.translation ("Go to project directory of this system, or right click to open that directory in specified file browser") end
	e_f_code: STRING_GENERAL is do Result := locale.translation("F_code")	end
	e_w_code: STRING_GENERAL is do Result := locale.translation("W_code")	end
	e_open_project: STRING_GENERAL is do Result := locale.translation ("Project") end
	e_no_text_is_selected: STRING_GENERAL is do Result := locale.translation("No file name is selected.")	end
	e_selected_text_is_not_file: STRING_GENERAL is do Result := locale.translation("Selected text is not a correct file name.")	end
	e_external_editor_not_defined: STRING_GENERAL is do Result := locale.translation("External editor not defined")	end
	e_external_command_is_running: STRING_GENERAL is do Result := locale.translation("An external command is running now. %NPlease wait until it exits.")	end
	e_external_command_list_full: STRING_GENERAL is do Result := locale.translation("Your external command list is full.%NUse Tools->External Command... to delete one.")	end
	e_working_directory_invalid (a_directory: STRING_GENERAL): STRING_GENERAL is
		do
			Result := locale.formatted_string (locale.translation("Cannot change to directory %"$1%"."), [a_directory])
		end
	e_external_command_not_launched: STRING_GENERAL is do Result := locale.translation("External command not launched.")	end
	e_refactoring_undo_sure: STRING_GENERAL is do Result := locale.translation("Are you sure you want to undo the refactoring?%N If classes have been modified since the refactoring this can lead to corrupt classes and lost information!")	end
	e_refactoring_redo_sure: STRING_GENERAL is do Result := locale.translation("Are you sure you want to redo the refactoring?%N If classes have been modified since the undo of the refactoring this can lead to corrupt classes and lost information!")	end
	e_show_help: STRING_GENERAL is do Result := locale.translation("Click to show the help documentation.")	end
	e_show_help_unavailable: STRING_GENERAL is do Result := locale.translation("No help provider is available to show help for this dialog!")	end


feature -- Description text, no translation (for the editor).

	ee_Compilation_failed: STRING is			"Eiffel Compilation Failed"
	ee_Compilation_succeeded: STRING is			"Eiffel Compilation Succeeded"
	ee_freezing_failed: STRING is 				"Background Workbench C Compilation Failed"
	ee_finalizing_failed: STRING is				"Background Finalized C compilation Failed"
	ee_freezing_launch_failed: STRING is 		"Background Workbench C Compilation Launch Failed"
	ee_finalizing_launch_failed: STRING is		"Background Finalized C Compilation Launch Failed"
	ee_freezing_launched: STRING is 			"Background Workbench C Compilation Launched"
	ee_finalizing_launched: STRING is 			"Background Finalized C Compilation Launched"
	ee_freezing_succeeded: STRING is 			"Background Workbench C Compilation Succeeded"
	ee_finalizing_succeeded: STRING is			"Background Finalized C Compilation Succeeded"
	ee_freezing_terminated: STRING is 			"Background Workbench C Compilation Terminated"
	ee_finalizing_terminated: STRING is		 	"Background Finalized C Compilation Terminated"
	ee_C_compilation_failed: STRING is 			"Background C Compilation Failed"
	ee_C_compilation_launch_failed: STRING is 	"Background C Compilation Launch Failed"
	ee_C_compilation_terminated: STRING is 		"Background C Compilation Terminated"
	ee_C_compilication_launched: STRING is 		"Background C Compilation Launched"
	ee_C_compilation_succeeded: STRING is 		"Background C Compilation Succeeded"
	ee_C_compilation_running: STRING is  		"Background C Compilation in Progress"
	ee_Compiling: STRING is						"System is being compiled"
	ee_Drop_an_error_stone: STRING is	"Pick the code of a compilation error (such as VEEN, VTCT,...)%N%
										%and drop it here to have extended information about it."
	ee_Running: STRING is				"Application is running"
	ee_Running_no_stop_points: STRING is	"Application is running (ignoring breakpoints)"


	e_Activate_execution_recording: STRING_GENERAL is	do Result := locale.translation("Activate execution recording")	end
	e_Deactivate_execution_recording: STRING_GENERAL is	do Result := locale.translation("Deactivate execution recording")	end

	e_Activate_execution_replay_mode: STRING_GENERAL is	do Result := locale.translation("Activate execution replay mode")	end
	e_Deactivate_execution_replay_mode: STRING_GENERAL is	do Result := locale.translation("Deactivate execution replay mode")	end

	e_Exec_replay: STRING_GENERAL is	do Result := locale.translation("Replay the execution")	end
	e_Exec_replay_back: STRING_GENERAL is	do Result := locale.translation("Replay back the execution")	end
	e_Exec_replay_forth: STRING_GENERAL is	do Result := locale.translation("Replay forth the execution")	end
	e_Exec_replay_left: STRING_GENERAL is	do Result := locale.translation("Replay left the execution")	end
	e_Exec_replay_right: STRING_GENERAL is	do Result := locale.translation("Replay right the execution")	end

	e_Control_debuggee_object_storage: STRING_GENERAL is	do Result := locale.translation("Control debuggee object storage")	end
	e_Operation_succeeded: STRING_GENERAL is	do Result := locale.translation("Operation succeeded.")	end
	e_Operation_failed: STRING_GENERAL is	do Result := locale.translation("Operation failed.") end

feature -- Error

	err_error: STRING_GENERAL is do Result := locale.translation ("Error ") end

feature -- Wizard texts

	wt_Profiler_welcome: STRING_GENERAL is do Result := locale.translation("Welcome to the Profiler Wizard")	end
	wb_Profiler_welcome: STRING_GENERAL is
				do Result := locale.translation("Using this wizard you can analyze the result of a profiling.%N%
				%%N%
				%Profiling a system is used to analyze its run-time properties%N%
				%and in particular the cost of each routine: number of calls,%N%
				%time spent, etc. The profiler is a precious tool to understand%N%
				%and optimize a system.%N%
				%%N%
				%To continue you need to have already executed your system%N%
				%with the profiler activated. If this is not the case, please%N%
				%refer to the documentation on how to profile a system.%N%
				%%N%
				%%N%
				%To continue, click Next.")	end

	wt_Compilation_mode: STRING_GENERAL is do Result := locale.translation("Compilation mode")	end
	ws_Compilation_mode: STRING_GENERAL is do Result := locale.translation("Select the Compilation mode.")	end

	wt_Execution_Profile: STRING_GENERAL is do Result := locale.translation("Execution Profile")	end
	ws_Execution_Profile: STRING_GENERAL is do Result := locale.translation("Reuse or Generate an Execution Profile.")	end
	wb_Execution_Profile: STRING_GENERAL is
			do Result := locale.translation("You can generate the Execution Profile from a Run-time Information Record%N%
			%created by a profiler, or you can reuse an existing Execution Profile if you%N%
			%have already generated one for this system.")	end

	wt_Execution_Profile_Generation: STRING_GENERAL is do Result := locale.translation("Execution Profile Generation")	end
	ws_Execution_Profile_Generation: STRING_GENERAL is do Result := locale.translation("Select a Run-time information record to generate the Execution profile")	end
	wb_Execution_Profile_Generation: STRING_GENERAL is
				do Result := locale.translation("Once an execution of an instrumented system has generated the proper file,%N%
				%you must process it through a profile converter to produce the Execution%N%
				%Profile. The need for the converter comes from the various formats that%N%
				%profilers use to record run-time information during an execution.%N%
				%%N%
				%Provide the Run-time information record produced by the profiler and%N%
				%select the profiler used to create this record.%
				%%N%
				%The Execution Profile will be generated under the file %"profinfo.pfi%".")	end

	wt_Switches_and_query: STRING_GENERAL is do Result := locale.translation("Switches and Query")	end
	ws_Switches_and_query: STRING_GENERAL is do Result := locale.translation("Select the information you need and formulate your query.")	end

	wt_Generation_error: STRING_GENERAL is do Result := locale.translation("Generation Error")	end
	wb_Click_back_and_correct_error: STRING_GENERAL is do Result := locale.translation("Click Back if you can correct the problem or Click Abort.")	end

	wt_Runtime_information_record_error: STRING_GENERAL is do Result := locale.translation("Runtime Information Record Error")	end
	wb_Runtime_information_record_error (generation_path: STRING_GENERAL): STRING_GENERAL is
		do
			Result := locale.formatted_string (locale.translation(
				"The file you have supplied as Runtime Information Record%N%
				%does not exist or is not valid.%N%
				%Do not forget that the Runtime Information Record has to%N%
				%be located in the project directory:%N$1%
				%%N%N%
				%Please provide a valid file or execute your profiler again to%N%
				%generate a valid Runtime Information Record.%N%
				%%N%
				%Click Back and select a valid file or Click Abort."), [generation_path])
		end

	wt_Execution_profile_error: STRING_GENERAL is do Result := locale.translation("Execution Profile Error")	end
	wb_Execution_profile_error: STRING_GENERAL is
				do Result := locale.translation("The file you have supplied as existring Execution Provide does%N%
				%not exist or is not valid. Please provide a valid file or generate%N%
				%a new one.%N%
				%Click Back and select a valid file or choose the generate option.")	end;

feature -- Translation (unrecommended to use)

	find_translation (a_string: STRING_GENERAL): STRING_GENERAL is
			-- Find translation to `a_string'.
			-- unrecommended to use
		require
			a_string_not_void: a_string /= Void
		do
			Result := locale.translation (a_string)
		ensure
			result_not_void: Result /= Void
		end

feature -- String escape

	escaped_string_for_menu_item (a_str: STRING): STRING is
			-- Escaped string for menu item.
			-- "&" is escaped by "&&" because in menu item, "&" is used as accelerator indicator.
		require
			a_str_attached: a_str /= Void
		do
			Result := a_str.twin
			Result.replace_substring_all ("&", "&&")
		ensure
			result_attached: Result /= Void
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

end -- class INTERFACE_NAMES


