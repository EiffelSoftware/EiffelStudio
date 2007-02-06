indexing
	description:
		"Constants for command names, etc."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	conventions:
		"a_: Accelerator key combination; %
		%b_: Button text; %
		%d_: Degree outputter; %
		%f_: Focus label text (tooltips); %
		%h_: Help text; %
		%i_: Icon ids for windows (ignored for motif); %
		%m_: Mnemonic (menu entry); %
		%l_: Label texts; %
		%n_: widget Names; %
		%s_: Stone names; %
		%t_: Title (part); %
		%e_: Short description, explanation; %
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

	b_Abort: STRING_GENERAL is							do Result := locale.translate("Abort")	end
	b_Add: STRING_GENERAL is 							do Result := locale.translate("Add")	end
	b_Add_text: STRING_GENERAL is 						do Result := locale.translate("Add ->")	end
	b_alphabetical_class_list: STRING_GENERAL is 		do Result := locale.translate("Alphabetical class list")	end
	b_alphabetical_cluster_list: STRING_GENERAL is 		do Result := locale.translate("Alphabetical cluster list")	end
	b_And: STRING_GENERAL is							do Result := locale.translate("And")	end
	b_Apply: STRING_GENERAL is							do Result := locale.translate("Apply")	end
	b_Browse: STRING_GENERAL is							do Result := locale.translate("Browse...")	end
	b_C_functions: STRING_GENERAL is					do Result := locale.translate("C Functions")	end
	b_change: STRING_GENERAL is 						do Result := locale.translate ("Change")	end
	b_Close: STRING_GENERAL is							do Result := locale.translate("Close")	end
	b_Close_tool (a_tool: STRING_GENERAL): STRING_GENERAL is
		require a_tool_not_void: a_tool /= Void
		do	Result := locale.format_string (locale.translate ("Close $1"), [a_tool]) end
	b_cluster_charts: STRING_GENERAL is					do Result := locale.translate("Cluster charts")	end
	b_cluster_diagram: STRING_GENERAL is				do Result := locale.translate("Cluster diagrams (may take a long time!)")	end
	b_cluster_hierarchy: STRING_GENERAL is				do Result := locale.translate("Cluster hierarchy")	end
	b_Continue_anyway: STRING_GENERAL is				do Result := locale.translate("Continue Anyway")	end
	b_Continue_on_condition_failure: STRING_GENERAL is  do Result := locale.translate("Continue if evaluation fails")	end
	b_Create: STRING_GENERAL is							do Result := locale.translate("Create")	end
	b_Create_folder: STRING_GENERAL is					do Result := locale.translate("Create Folder...")	end
	b_Delete_command: STRING_GENERAL is					do Result := locale.translate("Delete")	end
	b_Descendant_time: STRING_GENERAL is				do Result := locale.translate("Descendant Time")	end
	b_Debugging_options: STRING_GENERAL is				do Result := locale.translate ("Debugging options") end
	b_Discard_assertions: STRING_GENERAL is				do Result := locale.translate("Discard Assertions")	end
	b_Display_Exception_Trace: STRING_GENERAL is		do Result := locale.translate("Display Exception Trace")	end
	b_do_nothing: STRING_GENERAL is 					do Result := locale.translate("Do nothing")	end
	b_Down_text: STRING_GENERAL is 						do Result := locale.translate("Down")	end
	b_Edit_ace: STRING_GENERAL is						do Result := locale.translate("Edit")	end
	b_Edit_command: STRING_GENERAL is					do Result := locale.translate("Edit...")	end
	b_Eiffel_features: STRING_GENERAL is				do Result := locale.translate("Eiffel Features")	end

	b_Force_debug_mode: STRING_GENERAL is				do Result := locale.translate("Force Debug Mode")	end

	b_Feature_name: STRING_GENERAL is					do Result := locale.translate("Feature Name")	end
	b_Finish: STRING_GENERAL is							do Result := locale.translate("Finish")	end
	b_Function_time: STRING_GENERAL is					do Result := locale.translate("Function Time")	end
	b_Keep_assertions: STRING_GENERAL is				do Result := locale.translate("Keep Assertions")	end
	b_Load_ace: STRING_GENERAL is						do Result := locale.translate("Load From...")	end
	b_Move_to_folder: STRING_GENERAL is					do Result := locale.translate("Move to Folder...")	end
	b_New_ace: STRING_GENERAL is						do Result := locale.translate("Reset")	end
	b_New_command: STRING_GENERAL is					do Result := locale.translate("Add...")	end
	b_New_favorite_class: STRING_GENERAL is				do Result := locale.translate("New Favorite Class...")	end
	b_New_tab: STRING_GENERAL is 						do Result := locale.translate("New Tab")	end
	b_Next: STRING_GENERAL is							do Result := locale.translate("Next")	end
	b_Number_of_calls: STRING_GENERAL is				do Result := locale.translate("Number of Calls")	end
	b_Open_original: STRING_GENERAL is					do Result := locale.translate("Open Original File")	end
	b_Open_backup: STRING_GENERAL is					do Result := locale.translate("Open Backup File")	end
	b_Or: STRING_GENERAL is								do Result := locale.translate("Or")	end
	b_Percentage: STRING_GENERAL is						do Result := locale.translate("Percentage")	end
	b_put_handle_left: STRING_GENERAL is				do Result := locale.translate("Put handle left")	end
	b_put_handle_right: STRING_GENERAL is				do Result := locale.translate("Put handle right")	end
	b_put_two_handle_right: STRING_GENERAL is			do Result := locale.translate("Put two handles right")	end
	b_put_two_handle_left: STRING_GENERAL is			do Result := locale.translate("Put two handles left")	end

	b_Replace: STRING_GENERAL is						do Result := locale.translate("Replace")	end
	b_Replace_all: STRING_GENERAL is					do Result := locale.translate("Replace all")	end
	b_Recursive_functions: STRING_GENERAL is			do Result := locale.translate("Recursive Functions")	end
	b_Reload: STRING_GENERAL is							do Result := locale.translate("Reload")	end
	b_Remove: STRING_GENERAL is							do Result := locale.translate("Remove")	end
	b_Remove_all: STRING_GENERAL is						do Result := locale.translate("Remove all")	end
	b_Remove_handles: STRING_GENERAL is					do Result := locale.translate("Remove handles")	end
	b_Remove_text: STRING_GENERAL is 					do Result := locale.translate("<- Remove")	end
	b_Retry: STRING_GENERAL is							do Result := locale.translate("Retry")	end
	b_Search: STRING_GENERAL is							do Result := locale.translate("Search")	end
	b_select_target: STRING_GENERAL is					do Result := locale.translate ("Select target") end
	b_set: STRING_GENERAL is							do Result := locale.translate("Set")	end
	b_New_search: STRING_GENERAL is 					do Result := locale.translate("New Search?")	end
	b_Save: STRING_GENERAL is							do Result := locale.translate("Save")	end
	b_Save_all: STRING_GENERAL is 						do Result := locale.translate("Save All")	end
	b_Total_time: STRING_GENERAL is						do Result := locale.translate("Total Time")	end
	b_Up_text: STRING_GENERAL is 						do Result := locale.translate("Up")	end
	b_Update: STRING_GENERAL is 						do Result := locale.translate("Update")	end
	b_Compile: STRING_GENERAL is						do Result := locale.translate("Compile")	end
	b_Launch: STRING_GENERAL is							do Result := locale.translate("Start")	end
	b_Continue: STRING_GENERAL is						do Result := locale.translate("Continue")	end
	b_Finalize: STRING_GENERAL is						do Result := locale.translate("Finalize")	end
	b_Freeze: STRING_GENERAL is							do Result := locale.translate("Freeze")	end
	b_Precompile: STRING_GENERAL is						do Result := locale.translate("Precompile")	end
	b_override_scan: STRING_GENERAL is					do Result := locale.translate("Recompile Overrides")	end
	b_discover_melt: STRING_GENERAL is					do Result := locale.translate("Find Added Classes & Recompile")	end
	b_Cut: STRING_GENERAL is							do Result := locale.translate("Cut")	end
	b_Copy: STRING_GENERAL is							do Result := locale.translate("Copy")	end
	b_Paste: STRING_GENERAL is							do Result := locale.translate("Paste")	end
	b_New_editor: STRING_GENERAL is						do Result := locale.translate("New Editor")	end
	b_New_context: STRING_GENERAL is					do Result := locale.translate("New Context")	end
	b_New_window: STRING_GENERAL is						do Result := locale.translate("New Window")	end
	b_Open: STRING_GENERAL is							do Result := locale.translate("Open")	end
	b_Save_as: STRING_GENERAL is						do Result := locale.translate("Save As...")	end
	b_Shell: STRING_GENERAL is							do Result := locale.translate("External Editor")	end
	b_Print: STRING_GENERAL is							do Result := locale.translate("Print")	end
	b_Undo: STRING_GENERAL is							do Result := locale.translate("Undo")	end
	b_Redo: STRING_GENERAL is							do Result := locale.translate("Redo")	end
	b_Create_new_cluster: STRING_GENERAL is				do Result := locale.translate("Add Cluster")	end
	b_Create_new_library: STRING_GENERAL is				do Result := locale.translate("Add Library")	end
	b_Create_new_assembly: STRING_GENERAL is			do Result := locale.translate("Add Assembly")	end
	b_Create_new_precompile: STRING_GENERAL is			do Result := locale.translate("Add Precompile")	end
	b_Create_new_class: STRING_GENERAL is				do Result := locale.translate("New Class")	end
	b_Create_new_feature: STRING_GENERAL is				do Result := locale.translate("New Feature")	end
	b_Send_stone_to_context: STRING_GENERAL is			do Result := locale.translate("Synchronize")	end
	b_Display_error_help: STRING_GENERAL is				do Result := locale.translate("Help Tool")	end
	b_Project_settings: STRING_GENERAL is				do Result := locale.translate("Project Settings")	end
	b_previous: STRING_GENERAL is 						do Result := locale.translate ("Previous") end
	b_System_info: STRING_GENERAL is					do Result := locale.translate("System Info")	end
	b_arrow_back: STRING_GENERAL is						do Result := locale.translate ("< Back") end
	b_arrow_next: STRING_GENERAL is						do Result := locale.translate ("Next >") end
	b_Bkpt_info: STRING_GENERAL is						do Result := locale.translate("Breakpoint Info")	end
	b_Bkpt_enable: STRING_GENERAL is					do Result := locale.translate("Enable Breakpoints")	end
	b_Bkpt_disable: STRING_GENERAL is					do Result := locale.translate("Disable Breakpoints")	end
	b_Bkpt_remove: STRING_GENERAL is					do Result := locale.translate("Remove Breakpoints")	end
	b_Bkpt_stop_in_hole: STRING_GENERAL is				do Result := locale.translate("Pause")	end
	b_Exec_kill: STRING_GENERAL is						do Result := locale.translate("Stop Application")	end
	b_Exec_into: STRING_GENERAL is						do Result := locale.translate("Step Into")	end
	b_Exec_no_stop: STRING_GENERAL is					do Result := locale.translate("Launch Without Stopping")	end
	b_Exec_out: STRING_GENERAL is						do Result := locale.translate("Step Out")	end
	b_Exec_step: STRING_GENERAL is						do Result := locale.translate("Step")	end
	b_Exec_stop: STRING_GENERAL is						do Result := locale.translate("Pause")	end
	b_enable_profiles: STRING_GENERAL is				do Result := locale.translate("Enable Profiles")	end
	b_run: STRING_GENERAL is							do Result := locale.translate("Run")	end
	b_run_and_close: STRING_GENERAL is					do Result := locale.translate("Run & Close")	end
	b_Run_finalized: STRING_GENERAL is					do Result := locale.translate("Run Finalized")	end
	b_Run_workbench: STRING_GENERAL is					do Result := locale.translate("Run Workbench")	end
	b_Toggle_stone_management: STRING_GENERAL is 		do Result := locale.translate("Link Context")	end
	b_Raise_all: STRING_GENERAL is						do Result := locale.translate("Raise Windows")	end
	b_Remove_class_cluster: STRING_GENERAL is			do Result := locale.translate("Remove Class/Cluster")	end
	b_Minimize_all: STRING_GENERAL is					do Result := locale.translate("Minimize All")	end
	b_Terminate_c_compilation: STRING_GENERAL is 		do Result := locale.translate("Terminate C Compilation")	end
	b_Expand_all: STRING_GENERAL is 					do Result := locale.translate("Expand All")	end
	b_Collapse_all: STRING_GENERAL is 					do Result := locale.translate("Collapse All")	end
	b_Dbg_exception_handler: STRING_GENERAL is			do Result := locale.translate("Exceptions")	end
	b_Dbg_assertion_checking_disable: STRING_GENERAL is	do Result := locale.translate("Disable assertion checking")	end
	b_Dbg_assertion_checking_restore: STRING_GENERAL is	do Result := locale.translate("Restore assertion checking")	end
	b_duplicate: STRING_GENERAL is						do Result := locale.translate ("Duplicate") end

	b_Yes: STRING_GENERAL is							do Result := locale.translate ("Yes") end
	b_No: STRING_GENERAL is								do Result := locale.translate("No")	end
	b_Ok: STRING_GENERAL is								do Result := locale.translate("OK")	end
	b_Cancel: STRING_GENERAL is							do Result := locale.translate("Cancel")	end
	b_Reset: STRING_GENERAL is							do Result := locale.translate("Reset") end
	b_overwrite: STRING_GENERAL is						do Result := locale.translate("Overwrite") end
	b_append: STRING_GENERAL is							do Result := locale.translate("Append") end
	b_ignore: STRING_GENERAL is							do Result := locale.translate("Ignore") end

feature -- Graphical degree output

	d_Classes_to_go: STRING is					do Result := locale.translate("Classes to Go:").out	end
	d_Clusters_to_go: STRING_GENERAL is					do Result := locale.translate("Clusters to Go:")	end
	d_Compilation_class: STRING is				do Result := locale.translate("Class:").out	end
	d_Compilation_cluster: STRING is			do Result := locale.translate("Cluster:").out	end
	d_Compilation_progress: STRING is			do Result := locale.translate("Compilation Progress for ").out	end
	d_Degree: STRING is							do Result := locale.translate("Degree:").out	end
	d_Documentation: STRING is					do Result := locale.translate("Documentation").out	end
	d_Features_processed: STRING is				do Result := locale.translate("Completed: ").out	end
	d_Features_to_go: STRING is					do Result := locale.translate("Remaining: ").out	end
	d_Generating: STRING is						do Result := locale.translate("Generating: ").out	end
	d_Resynchronizing_breakpoints: STRING is 	do Result := locale.translate("Resynchronizing Breakpoints").out	end
	d_Resynchronizing_tools: STRING is			do Result := locale.translate("Resynchronizing Tools").out	end
	d_Reverse_engineering: STRING is			do Result := locale.translate("Reverse Engineering Project").out	end
	d_Finished_removing_dead_code: STRING is	do Result := locale.translate("Dead Code Removal Completed").out	end

feature -- Help text

	h_No_help_available: STRING is				do Result := locale.translate("No help available for this element").out	end
	h_refactoring_compiled: STRING is			do Result := locale.translate("Renames only occurances of the class name in compiled classes.").out	end
	h_refactoring_all_classes: STRING is		do Result := locale.translate("Renames occurances of the class name in any class. (Slow)").out	end

feature -- File names

	default_stack_file_name: STRING is			"stack"

feature -- Accelerator, focus label and menu name

	m_About: STRING_GENERAL is
		once
			Result := locale.format_string (locale.translate("&About $1..."), [Workbench_name])
		end
	m_Advanced: STRING_GENERAL is				do Result := locale.translate("Ad&vanced")	end
	m_Add_to_favorites: STRING_GENERAL is		do Result := locale.translate("&Add to Favorites")	end
	m_add_first_breakpoints_in_class: STRING_GENERAL is 	do Result := locale.translate("Add first breakpoints in class" )	end
	m_add_first_breakpoints_in_feature: STRING_GENERAL is 	do Result := locale.translate("Add first breakpoints in feature" )	end
	f_add_new_expression: STRING_GENERAL is 	do Result := locale.translate ("Click here to add a new expression") end
	m_add_new_variable: STRING_GENERAL is 		do Result := locale.translate ("Add new variable") end
	f_add_a_new_variable: STRING_GENERAL is
		do
			Result := locale.translate ("[
					Add a new variable : double click or [enter]
					Use an existing variable: right click or [Ctrl+enter]
					]")
		end
	f_advanced_search: STRING_GENERAL is 		do Result := locale.translate ("Advanced search") end
	f_all_breakpoint_together: STRING_GENERAL is 		do Result := locale.translate ("All breakpoints together") end
	m_Address_toolbar: STRING_GENERAL is		do Result := locale.translate("&Address Bar")	end
	m_Apply: STRING_GENERAL is					do Result := locale.translate("&Apply")	end
	m_auto_expressions: STRING_GENERAL is		do Result := locale.translate("Auto expressions")	end
	l_all_classes: STRING_GENERAL is			do Result := locale.translate("All Classes")	end
	m_Breakpoints_tool: STRING_GENERAL is		do Result := locale.translate("Breakpoints")	end
	m_Breakpoint_index: STRING_GENERAL is		do Result := locale.translate("Breakpoint index:")	end
	m_Break_always: STRING_GENERAL is						do Result := locale.translate("Break always")	end
	m_Break_when_hit_count_equal: STRING_GENERAL is			do Result := locale.translate("Break when the hit count is equal to")	end
	m_Break_when_hit_count_multiple_of: STRING_GENERAL is	do Result := locale.translate("Break when the hit count is a multiple of")	end
	m_Break_when_hit_count_greater: STRING_GENERAL is		do Result := locale.translate("Break when the hit count is greater than or equal to")	end

	l_class_tree_assemblies: STRING_GENERAL is	do Result := locale.translate("Assemblies")	end
	l_class_tree_clusters: STRING_GENERAL is	do Result := locale.translate("Clusters")	end
	l_class_tree_libraries: STRING_GENERAL is	do Result := locale.translate("Libraries")	end
	l_class_tree_overrides: STRING_GENERAL is	do Result := locale.translate("Overrides")	end

	f_Clear_breakpoints: STRING_GENERAL is		do Result := locale.translate("Remove all breakpoints")	end
	m_Clear_breakpoints: STRING_GENERAL is		do Result := locale.translate("Re&move All Breakpoints")	end
	f_close: STRING_GENERAL is					do Result := locale.translate("Close")	end
	m_Comment: STRING_GENERAL is					do Result := locale.translate("&Comment%TCtrl+K")	end
	m_Compilation_C_Workbench: STRING_GENERAL is	do Result := locale.translate("Compile W&orkbench C Code")	end
	m_Compilation_C_Final: STRING_GENERAL is		do Result := locale.translate("Compile F&inalized C Code")	end
	m_Contents: STRING_GENERAL is				do Result := locale.translate("&Contents")	end
	m_Customize_general: STRING_GENERAL is		do Result := locale.translate("&Customize Standard Toolbar...")	end
	m_Customize_project: STRING_GENERAL is		do Result := locale.translate("Customize P&roject Toolbar...")	end
	m_Customize_refactoring: STRING_GENERAL is	do Result := locale.translate("Customize Re&factoring Toolbar...")	end
	m_Cut: STRING_GENERAL is						do Result := locale.translate("Cu&t%TCtrl+X")	end
	f_Cut: STRING_GENERAL is					do Result := locale.translate("Cut (Ctrl+X)")	end
	m_Call_stack_tool: STRING_GENERAL is			do Result := locale.translate("Call stack")	end
	m_Cluster_tool: STRING_GENERAL is			do Result := locale.translate("&Clusters")	end
	l_compiled_classes: STRING_GENERAL is		do Result := locale.translate("Compiled Classes")	end
	m_Complete_word: STRING_GENERAL is			do Result := locale.translate("Complete &Word")	end
	m_Complete_class_name: STRING_GENERAL is		do Result := locale.translate("Complete Class &Name")	end
	m_Context_tool: STRING_GENERAL is			do Result := locale.translate("Conte&xt")	end
	m_Copy: STRING_GENERAL is					do Result := locale.translate("&Copy%TCtrl+C")	end
	f_Copy: STRING_GENERAL is					do Result := locale.translate("Copy (Ctrl+C)")	end
	m_copy_of: STRING_GENERAL is					do Result := locale.translate("Copy of ")	end
	m_Close: STRING_GENERAL is					do Result := locale.translate("&Close Window%TAlt+F4")	end
	m_Close_short: STRING_GENERAL is				do Result := locale.translate("&Close")	end
	f_Create_new_cluster: STRING_GENERAL is		do Result := locale.translate("Add a cluster")	end
	f_Create_new_library: STRING_GENERAL is		do Result := locale.translate("Add a library")	end
	f_Create_new_assembly: STRING_GENERAL is	do Result := locale.translate("Add an assembly")	end
	f_Create_new_precompile: STRING_GENERAL is 	do Result := locale.translate("Add a precompile")	end
	f_Create_new_class: STRING_GENERAL is		do Result := locale.translate("Create a new class")	end
	f_Create_new_feature: STRING_GENERAL is		do Result := locale.translate("Create a new feature")	end
	f_create_new_watch: STRING_GENERAL is		do Result := locale.translate ("Create new watch") end

	m_Dbg_assertion_checking_disable: STRING_GENERAL is	do Result := locale.translate("Disable Assertion Checking")	end
	m_Dbg_assertion_checking_restore: STRING_GENERAL is	do Result := locale.translate("Restore Assertion Checking")	end
	m_Dbg_exception_handler: STRING_GENERAL is	do Result := locale.translate("Exception Handling")	end
	m_Debug_interrupt_new: STRING_GENERAL is		do Result := locale.translate("I&nterrupt Application")	end
	f_Debug_edit_object: STRING_GENERAL is		do Result := locale.translate("Edit Object content")	end
	m_Debug_edit_object: STRING_GENERAL is		do Result := locale.translate("Edit Object Content")	end
	f_Debug_dynamic_eval: STRING_GENERAL is		do Result := locale.translate("Dynamic feature evaluation")	end
	m_Debug_dynamic_eval: STRING_GENERAL is		do Result := locale.translate("Dynamic Feature Evaluation")	end
	m_Debug_kill: STRING_GENERAL is				do Result := locale.translate("&Stop Application")	end
	f_Debug_run: STRING_GENERAL is				do Result := locale.translate("Run")	end
	m_Debug_run: STRING_GENERAL is				do Result := locale.translate("&Run%TCtrl+R")	end
	m_Debug_run_new: STRING_GENERAL is			do Result := locale.translate("St&art")	end

	m_Force_debug_mode: STRING_GENERAL is		do Result := locale.translate("Force Debug Mode")	end
	m_Launch_With_Arguments: STRING_GENERAL is	do Result := locale.translate("Start With Arguments")	end
	f_diagram_delete: STRING_GENERAL is			do Result := locale.translate("Delete")	end
	l_data: STRING_GENERAL is					do Result := locale.translate("Data")	end
	l_details: STRING_GENERAL is				do Result := locale.translate("Details") end
	l_diagram_delete: STRING_GENERAL is			do Result := locale.translate("Delete graphical items, remove code from system")	end
	f_diagram_crop: STRING_GENERAL is			do Result := locale.translate("Crop diagram")	end
	m_diagram_crop: STRING_GENERAL is			do Result := locale.translate("&Crop Diagram")	end
	f_diagram_zoom_out: STRING_GENERAL is		do Result := locale.translate("Zoom out")	end
	f_diagram_put_right_angles: STRING_GENERAL is		do Result := locale.translate("Force right angles")	end
	f_diagram_remove_right_angles: STRING_GENERAL is	do Result := locale.translate("Remove right angles")	end
	m_diagram_link_tool: STRING_GENERAL is		do Result := locale.translate("&Put Right Angles")	end
	f_diagram_to_png: STRING_GENERAL is			do Result := locale.translate("Export diagram to PNG")	end
	m_diagram_to_png: STRING_GENERAL is			do Result := locale.translate("&Export Diagram to PNG")	end
	f_diagram_context_depth: STRING_GENERAL is  do Result := locale.translate("Select depth of relations")	end
	m_diagram_context_depth: STRING_GENERAL is  do Result := locale.translate("&Select Depth of Relations")	end
	f_diagram_delete_view: STRING_GENERAL is		do Result := locale.translate("Delete current view")	end
	f_diagram_reset_view: STRING_GENERAL is 		do Result := locale.translate("Reset current view")	end
	m_diagram_delete_view: STRING_GENERAL is		do Result := locale.translate("&Delete Current View")	end
	m_diagram_reset_view: STRING_GENERAL is		do Result := locale.translate("&Reset Current View")	end
	f_diagram_zoom_in: STRING_GENERAL is			do Result := locale.translate("Zoom in")	end
	f_diagram_fit_to_screen: STRING_GENERAL is	do Result := locale.translate("Fit to screen")	end
	f_diagram_undo: STRING_GENERAL is			do Result := locale.translate("Undo last action")	end
	f_diagram_hide_supplier: STRING_GENERAL is	do Result := locale.translate("Hide supplier links")	end
	f_diagram_show_supplier: STRING_GENERAL is	do Result := locale.translate("Show supplier links")	end

	l_diagram_supplier_visibility: STRING_GENERAL is do Result := locale.translate("Toggle visibility of supplier links")	end

	l_diagram_add_ancestors: STRING_GENERAL is do Result := locale.translate("Add class ancestors to diagram")	end
	l_diagram_add_descendents: STRING_GENERAL is do Result := locale.translate("Add class descendants to diagram")	end
	l_diagram_add_suppliers: STRING_GENERAL is do Result := locale.translate("Add class suppliers to diagram")	end
	l_diagram_add_clients: STRING_GENERAL is do Result := locale.translate("Add class clients to diagram")	end

	f_diagram_hide_labels: STRING_GENERAL is		do Result := locale.translate("Hide labels")	end
	f_diagram_show_labels: STRING_GENERAL is		do Result := locale.translate("Show labels")	end
	f_diagram_show_uml: STRING_GENERAL is		do Result := locale.translate("Show UML")	end
	f_diagram_show_bon: STRING_GENERAL is 		do Result := locale.translate("Show BON")	end
	f_diagram_hide_clusters: STRING_GENERAL is	do Result := locale.translate("Hide clusters")	end
	f_diagram_show_clusters: STRING_GENERAL is	do Result := locale.translate("Show clusters")	end
	f_diagram_show_legend: STRING_GENERAL is		do Result := locale.translate("Show cluster legend")	end
	f_diagram_hide_legend: STRING_GENERAL is		do Result := locale.translate("Hide cluster legend")	end
	f_diagram_remove_anchor: STRING_GENERAL is	do Result := locale.translate("Remove anchor")	end
	l_diagram_labels_visibility: STRING_GENERAL is	do Result := locale.translate("Toggle visibility of client link labels")	end
	l_diagram_uml_visibility: STRING_GENERAL is	do Result := locale.translate("Toggle between UML and BON view")	end
	l_diagram_clusters_visibility: STRING_GENERAL is	do Result := locale.translate("Toggle visibility of clusters")	end
	l_diagram_legend_visibility: STRING_GENERAL is	do Result := locale.translate("Toggle visibility of cluster legend")	end
	l_diagram_remove_anchor: STRING_GENERAL is	do Result := locale.translate("Remove anchor")	end
	l_diagram_force_directed: STRING_GENERAL is	do Result := locale.translate("Turn on/off physics")	end
	l_diagram_toggle_quality: STRING_GENERAL is	do Result := locale.translate("Toggle quality level")	end
	f_diagram_high_quality: STRING_GENERAL is 	do Result := locale.translate("Switch to high quality")	end
	f_diagram_low_quality: STRING_GENERAL is 	do Result := locale.translate("Switch to low quality")	end
	f_diagram_hide_inheritance: STRING_GENERAL is	do Result := locale.translate("Hide inheritance links")	end
	f_diagram_show_inheritance: STRING_GENERAL is	do Result := locale.translate("Show inheritance links")	end
	l_diagram_inheritance_visibility: STRING_GENERAL is do Result := locale.translate("Toggle visibility of inheritance links")	end
	f_diagram_redo: STRING_GENERAL is			do Result := locale.translate("Redo last action")	end
	f_diagram_fill_cluster: STRING_GENERAL is	do Result := locale.translate("Include all classes of cluster")	end
	f_diagram_history: STRING_GENERAL is		do Result := locale.translate("History tool")	end
	f_diagram_remove: STRING_GENERAL is			do Result := locale.translate("Hide figure")	end
	l_diagram_remove: STRING_GENERAL is			do Result := locale.translate("Delete graphical items")	end
	f_diagram_create_supplier_links: STRING_GENERAL is	do Result := locale.translate("Create new client-supplier links")	end
	f_diagram_create_aggregate_supplier_links: STRING_GENERAL is do Result := locale.translate("Create new aggregate client-supplier links")	end
	f_diagram_create_inheritance_links: STRING_GENERAL is do Result := locale.translate("Create new inheritance links")	end
	l_diagram_create_links: STRING_GENERAL is	do Result := locale.translate("Select type of new links")	end
	f_diagram_new_class: STRING_GENERAL is		do Result := locale.translate("Create a new class")	end
	f_diagram_change_header: STRING_GENERAL is	do Result := locale.translate("Change class name and generics")	end
	f_diagram_change_color: STRING_GENERAL is	do Result := locale.translate("Change color")	end
	f_diagram_force_directed_on: STRING_GENERAL is	do Result := locale.translate("Turn on physics")	end
	f_diagram_force_directed_off: STRING_GENERAL is	do Result := locale.translate("Turn off physics")	end
	f_diagram_force_settings: STRING_GENERAL is	do Result := locale.translate("Show physics settings dialog")	end
	f_Disable_stop_points: STRING_GENERAL is	do Result := locale.translate("Disable all breakpoints")	end
	f_display_breakpoints: STRING_GENERAL is	do Result := locale.translate("Display breakpoints separated by status")	end
	f_display_breakpoints_sep_by_status: STRING_GENERAL is	do Result := locale.translate("Display breakpoints separated by status")	end
	m_Disable_stop_points: STRING_GENERAL is	do Result := locale.translate("&Disable All Breakpoints")	end
	m_Debug_block: STRING_GENERAL is			do Result := locale.translate("E&mbed in %"Debug...%"%TCtrl+D")	end
	m_debugging_options: STRING_GENERAL is				do Result := locale.translate ("De&bugging Options") end
	m_Editor: STRING_GENERAL is					do Result := locale.translate("&Editor")	end
	m_Eiffel_introduction: STRING_GENERAL is	do Result := locale.translate("&Introduction to Eiffel")	end
	f_Enable_stop_points: STRING_GENERAL is		do Result := locale.translate("Enable all breakpoints")	end
	m_Enable_stop_points: STRING_GENERAL is		do Result := locale.translate("&Enable All Breakpoints")	end
	m_environment_variables: STRING_GENERAL is		do Result := locale.translate("Environment variables")	end
	m_Exec_last: STRING_GENERAL is				do Result := locale.translate("&Out of Routine")	end
	m_Exec_nostop: STRING_GENERAL is			do Result := locale.translate("&Ignore Breakpoints")	end
	m_Exec_step: STRING_GENERAL is				do Result := locale.translate("&Step-by-Step")	end
	m_Exec_into: STRING_GENERAL is				do Result := locale.translate("Step In&to")	end
	m_Exit_project: STRING_GENERAL is			do Result := locale.translate("E&xit")	end
	m_Explorer_bar: STRING_GENERAL is			do Result := locale.translate("&Tools")	end
	m_Explorer_bar_item: STRING is do Result := locale.translate ("Explorer bar item") end
	m_Export_to: STRING_GENERAL is				do Result := locale.translate("Save Cop&y As...")	end
	m_Export_XMI: STRING_GENERAL is 			do Result := locale.translate("E&xport XMI...")	end
	m_Expression_evaluation: STRING_GENERAL is	do Result := locale.translate("Expression Evaluation")	end
	m_External_editor: STRING_GENERAL is		do Result := locale.translate("External E&ditor")	end
	m_Favorites_tool: STRING_GENERAL is			do Result := locale.translate("F&avorites")	end
	m_Features_tool: STRING_GENERAL is			do Result := locale.translate("&Features")	end
	m_threads_tool: STRING_GENERAL is			do Result := locale.translate ("Threads") end
	f_Finalize: STRING_GENERAL is				do Result := locale.translate("Finalize...")	end
	m_Finalize_new: STRING_GENERAL is			do Result := locale.translate("Finali&ze...")	end
	m_Find: STRING_GENERAL is					do Result := locale.translate("&Search")	end
	m_Find_next: STRING_GENERAL is				do Result := locale.translate("Find &Next")	end
	m_Find_previous: STRING_GENERAL is			do Result := locale.translate("Find &Previous")	end
	m_Find_next_selection: STRING_GENERAL is	do Result := locale.translate("Find Next &Selection")	end
	m_Find_previous_selection: STRING_GENERAL is do Result := locale.translate("Find P&revious Selection")	end
	f_Freeze: STRING_GENERAL is					do Result := locale.translate("Freeze...")	end
	m_Freeze_new: STRING_GENERAL is				do Result := locale.translate("&Freeze...")	end
	m_General_toolbar: STRING_GENERAL is		do Result := locale.translate("&Standard Buttons")	end
	m_Generate_documentation: STRING_GENERAL is do Result := locale.translate("Generate &Documentation...")	end
	m_Go_to: STRING_GENERAL is					do Result := locale.translate("&Go to...")	end
	m_Guided_tour: STRING_GENERAL is			do Result := locale.translate("&Guided Tour")	end
	m_grid_name (a_name: STRING_GENERAL): STRING_GENERAL is
		do Result := locale.format_string (locale.translate ("Grid %"$1%""), [a_name]) end
	m_Help: STRING_GENERAL is					do Result := locale.translate("&Help")	end
	m_Hide_favorites: STRING_GENERAL is			do Result := locale.translate("&Hide Favorites")	end
	m_Hide_formatting_marks: STRING_GENERAL is	do Result := locale.translate("&Hide Formatting Marks")	end
	m_History_forth: STRING_GENERAL is			do Result := locale.translate("&Forward")	end
	m_History_back: STRING_GENERAL is			do Result := locale.translate("&Back")	end
	f_History_forth: STRING_GENERAL is			do Result := locale.translate("Go forth")	end
	f_History_back: STRING_GENERAL is			do Result := locale.translate("Go back")	end
	m_How_to_s: STRING_GENERAL is				do Result := locale.translate("&How to's")	end
	m_If_block: STRING_GENERAL is				do Result := locale.translate("&Embed in %"if...%"%TCtrl+I")	end
	m_Indent: STRING_GENERAL is					do Result := locale.translate("&Indent Selection%TTab")	end
	m_keep_grid_layout: STRING_GENERAL is					do Result := locale.translate("Keep grid layout")	end
	m_Line_numbers: STRING_GENERAL is			do Result := locale.translate("Toggle &Line Numbers")	end
	f_match_case_question: STRING_GENERAL is			do Result := locale.translate("Match case?")	end
	f_Melt: STRING_GENERAL is					do Result := locale.translate("Compile current project")	end
	m_Melt_new: STRING_GENERAL is				do Result := locale.translate("&Compile")	end
	m_New: STRING_GENERAL is					do Result := locale.translate("&New")	end
	l_new_name: STRING_GENERAL is				do Result := locale.translate("New Name:")	end
	f_New_window: STRING_GENERAL is				do Result := locale.translate("Create a new window")	end
	m_New_window: STRING_GENERAL is				do Result := locale.translate("New &Window")	end
	m_New_dynamic_lib: STRING_GENERAL is		do Result := locale.translate("&Dynamic Library Builder...")	end
	m_New_project: STRING_GENERAL is			do Result := locale.translate("&New Project...")	end
	f_move_item_up: STRING_GENERAL is				do Result := locale.translate ("Move item up") end
	f_move_item_down: STRING_GENERAL is				do Result := locale.translate ("Move item down") end
	m_Ok: STRING_GENERAL is						do Result := locale.translate("&OK")	end
	m_Open: STRING_GENERAL is					do Result := locale.translate("&Open...%TCtrl+O")	end
	m_Open_new: STRING_GENERAL is				do Result := locale.translate("Op&en...")	end
	m_Open_project: STRING_GENERAL is			do Result := locale.translate("&Open Project...")	end
	f_Open_watch_tool_menu: STRING_GENERAL is 	do Result := locale.translate ("Open Watch tool menu") end
	f_Open_object_tool_menu: STRING_GENERAL is	do Result := locale.translate ("Open Objects tool menu") end
	f_original_value_is (k, s: STRING_GENERAL): STRING_GENERAL is
		require
			k_not_void: k /= Void
			s_not_void: s /= Void
		do
			Result := locale.format_string (locale.translate ("Original value is %"$1=$2%""), [k, s])
		end

	m_Organize_favorites: STRING_GENERAL is		do Result := locale.translate("&Organize Favorites...")	end
	m_Output: STRING_GENERAL is					do Result := locale.translate("&Output")	end
	f_Paste: STRING_GENERAL is					do Result := locale.translate("Paste (Ctrl+V)")	end
	m_Paste: STRING_GENERAL is					do Result := locale.translate("&Paste%TCtrl+V")	end
	m_Precompile_new: STRING_GENERAL is			do Result := locale.translate("&Precompile")	end
	f_Print: STRING_GENERAL is					do Result := locale.translate("Print")	end
	m_Print: STRING_GENERAL is					do Result := locale.translate("&Print")	end
	f_preferences: STRING_GENERAL is			do Result := locale.translate("Preferences")	end
	m_Preferences: STRING_GENERAL is			do Result := locale.translate("&Preferences...")	end
	m_Properties_tool: STRING_GENERAL is		do Result := locale.translate("Pr&operties")	end
	m_Profile_tool: STRING_GENERAL is			do Result := locale.translate("Pro&filer...")	end
	m_Project_toolbar: STRING_GENERAL is		do Result := locale.translate("&Project Bar")	end
	m_Refactoring_toolbar: STRING_GENERAL is	do Result := locale.translate("Re&factoring Bar")	end
	f_refactoring_pull: STRING_GENERAL is		do Result := locale.translate("Pull up Feature")	end
	f_refactoring_rename: STRING_GENERAL is		do Result := locale.translate("Rename Feature/Class")	end
	f_refactoring_undo: STRING_GENERAL is		do Result := locale.translate("Undo Last Refactoring (only works as long as no file that was refactored has been changed by hand)")	end
	f_refactoring_redo: STRING_GENERAL is		do Result := locale.translate("Redo Last Refactoring (only works as long as no file that was refactored has been changed by hand)")	end
	b_refactoring_pull: STRING_GENERAL is		do Result := locale.translate("Pull Up")	end
	b_refactoring_rename: STRING_GENERAL is		do Result := locale.translate("Rename")	end
	b_refactoring_undo: STRING_GENERAL is		do Result := locale.translate("Undo Refactoring")	end
	b_refactoring_redo: STRING_GENERAL is		do Result := locale.translate("Redo Refactoring")	end
	l_rename_file: STRING_GENERAL is			do Result := locale.translate("Rename File")	end
	l_regexp: STRING_GENERAL is					do Result := locale.translate("Regexp")	end
	l_replace_comments: STRING_GENERAL is		do Result := locale.translate("Replace Name in Comments")	end
	l_replace_strings: STRING_GENERAL is		do Result := locale.translate("Replace Name in Strings")	end
	m_Recent_project: STRING_GENERAL is			do Result := locale.translate("&Recent Projects")	end
	m_Redo: STRING_GENERAL is					do Result := locale.translate("Re&do%TCtrl+Y")	end
	f_Redo: STRING_GENERAL is					do Result := locale.translate("Redo (Ctrl+Y)")	end
	m_Replace: STRING_GENERAL is				do Result := locale.translate("&Replace...")	end
	f_Retarget_diagram: STRING_GENERAL is		do Result := locale.translate("Target to cluster or class")	end
	f_Run_finalized: STRING_GENERAL is			do Result := locale.translate("Run finalized system")	end
	m_Run_finalized: STRING_GENERAL is			do Result := locale.translate("&Run Finalized System")	end
	f_Run_workbench: STRING_GENERAL is			do Result := locale.translate("Run workbench system")	end
	m_Run_workbench: STRING_GENERAL is			do Result := locale.translate("&Run Workbench System")	end
	f_Save: STRING_GENERAL is					do Result := locale.translate("Save")	end
	m_Save_new: STRING_GENERAL is				do Result := locale.translate("&Save")	end
	m_Save_As: STRING_GENERAL is				do Result := locale.translate("S&ave As...")	end
	f_Save_all: STRING_GENERAL is 				do Result := locale.translate("Save All")	end
	m_Save_All: STRING_GENERAL is 				do Result := locale.translate("Save &All")	end
	m_Search: STRING_GENERAL is					do Result := locale.translate("&Find...")	end
	m_Search_tool: STRING_GENERAL is			do Result := locale.translate("&Search")	end
	m_Select_all: STRING_GENERAL is				do Result := locale.translate("Select &All%TCtrl+A")	end
	m_Send_to: STRING_GENERAL is				do Result := locale.translate("Sen&d to")	end
	m_show_assigners: STRING_GENERAL is			do Result := locale.translate("A&ssigners")	end
	m_Show_class_cluster: STRING_GENERAL is		do Result := locale.translate("Find in Cluster Tree")	end
	m_show_creators: STRING_GENERAL is			do Result := locale.translate("C&reators")	end
	m_Show_favorites: STRING_GENERAL is			do Result := locale.translate("&Show Favorites")	end
	m_Show_formatting_marks: STRING_GENERAL is		do Result := locale.translate("&Show Formatting Marks")	end
	m_Showancestors: STRING_GENERAL is			do Result := locale.translate("&Ancestors")	end
	m_Showattributes: STRING_GENERAL is			do Result := locale.translate("A&ttributes")	end
	m_Showcallers: STRING_GENERAL is			do Result := locale.translate("&Callers")	end
	m_Showcallees: STRING_GENERAL is 		do Result := locale.translate("Call&ees")	end
	m_Show_creation: STRING_GENERAL is 		do Result := locale.translate("Creat&ions")	end
	m_Show_assignees: STRING_GENERAL is 		do Result := locale.translate("&Assignees")	end
	m_Showclick: STRING_GENERAL is				do Result := locale.translate("C&lickable")	end
	m_Showclients: STRING_GENERAL is			do Result := locale.translate("Cli&ents")	end
	m_showcreators: STRING_GENERAL is			do Result := locale.translate("&Creators")	end
	m_Showdeferreds: STRING_GENERAL is			do Result := locale.translate("&Deferred")	end
	m_Showdescendants: STRING_GENERAL is		do Result := locale.translate("De&scendants")	end
	m_Showexported: STRING_GENERAL is			do Result := locale.translate("Ex&ported")	end
	m_Showexternals: STRING_GENERAL is			do Result := locale.translate("E&xternals")	end
	m_Showflat: STRING_GENERAL is				do Result := locale.translate("&Flat")	end
	m_Showfs: STRING_GENERAL is					do Result := locale.translate("&Interface")	end
	m_Showfuture: STRING_GENERAL is				do Result := locale.translate("&Descendant Versions")	end
	m_Showhistory: STRING_GENERAL is			do Result := locale.translate("&Implementers")	end
	m_Showindexing: STRING_GENERAL is			do Result := locale.translate("&Indexing clauses")	end
	m_show_invariants: STRING_GENERAL is		do Result := locale.translate("In&variants")	end
	m_Showonces: STRING_GENERAL is				do Result := locale.translate("O&nce/Constants")	end
	m_Showpast: STRING_GENERAL is				do Result := locale.translate("&Ancestor Versions")	end
	m_Showroutines: STRING_GENERAL is			do Result := locale.translate("&Routines")	end
	m_Showshort: STRING_GENERAL is				do Result := locale.translate("C&ontract")	end
	m_Showhomonyms: STRING_GENERAL is			do Result := locale.translate("&Homonyms")	end
	m_Showsuppliers: STRING_GENERAL is			do Result := locale.translate("S&uppliers")	end
	m_Showtext_new: STRING_GENERAL is			do Result := locale.translate("Te&xt")	end
	m_System_new: STRING_GENERAL is				do Result := locale.translate("Project &Settings...")	end
	m_Toolbars: STRING_GENERAL is				do Result := locale.translate("Tool&bars")	end
	m_To_lower: STRING_GENERAL is				do Result := locale.translate("Set to &Lowercase%TCtrl+Shift+U")	end
	m_To_upper: STRING_GENERAL is				do Result := locale.translate("Set to U&ppercase%TCtrl+U")	end
	m_Uncomment: STRING_GENERAL is				do Result := locale.translate("U&ncomment%TCtrl+Shift+K")	end
	f_Uncomment: STRING_GENERAL is				do Result := locale.translate("Uncomment selected lines")	end
	m_Undo: STRING_GENERAL is					do Result := locale.translate("&Undo%TCtrl+Z")	end
	f_Undo: STRING_GENERAL is					do Result := locale.translate("Undo (Ctrl+Z)")	end
	m_Unindent: STRING_GENERAL is				do Result := locale.translate("&Unindent Selection%TShift+Tab")	end
	f_use_regular_expression_question: STRING_GENERAL is do Result := locale.translate("Use regular expression?")	end
	m_Windows_tool: STRING_GENERAL is			do Result := locale.translate("&Windows")	end
	m_Watch_tool: STRING_GENERAL is				do Result := locale.translate("Watch Tool")	end
	m_Wizard_precompile: STRING_GENERAL is 		do Result := locale.translate("Precompilation &Wizard...")	end
	m_use_current_environment_variables: STRING_GENERAL is 		do Result := locale.translate("Use current environment variables")	end
	m_use_current_environment_value: STRING_GENERAL is 		do Result := locale.translate("Use current environment value")	end
	f_Wizard_precompile: STRING_GENERAL is		do Result := locale.translate("Wizard to precompile libraries")	end
	f_go_to_first_occurrence: STRING_GENERAL is do Result := locale.translate("Double click to go to first occurrence")	end
	f_show: STRING_GENERAL is do Result := locale.translate ("Show ") end
	f_hide: STRING_GENERAL is do Result := locale.translate ("Hide ") end
	f_switch_to_tree_view: STRING_GENERAL is do Result := locale.translate ("Switch to Tree View") end
	f_switch_to_flat_view: STRING_GENERAL is do Result := locale.translate ("Switch to Flat View") end
	m_reset_layout: STRING_GENERAL is do Result := locale.translate ("Reset Tools layout") end
	m_set_default_layout: STRING_GENERAL is do Result := locale.translate ("Set Current Layout As Default") end
	m_save_layout_as: STRING_GENERAL is do Result := locale.translate ("Save Layout As...") end
	m_open_layout: STRING_GENERAL is do Result := locale.translate ("Open Layout") end
	l_choose_class_version: STRING_GENERAL is do Result := locale.translate ("Choose one version from the following:") end

feature -- Toggles

	f_hide_alias: STRING_GENERAL is			do Result := locale.translate("Hide Alias Name")	end
	f_hide_assigner: STRING_GENERAL is		do Result := locale.translate("Hide Assigner Command Name")	end
	f_hide_signature: STRING_GENERAL is		do Result := locale.translate("Hide Signature")	end
	f_show_alias: STRING_GENERAL is			do Result := locale.translate("Show Alias Name")	end
	f_show_assigner: STRING_GENERAL is		do Result := locale.translate("Show Assigner Command Name")	end
	f_show_signature: STRING_GENERAL is		do Result := locale.translate("Show Signature")	end
	l_toggle_alias: STRING_GENERAL is		do Result := locale.translate("Toggle visibility of feature alias name")	end
	l_toggle_assigner: STRING_GENERAL is	do Result := locale.translate("Toggle visibility of assigner command name")	end
	l_toggle_signature: STRING_GENERAL is	do Result := locale.translate("Toggle visibility of feature signature")	end

feature -- Menu mnenomics

	m_Add_exported_feature: STRING_GENERAL is	do Result := locale.translate("&Add...")	end
	m_Bkpt_info: STRING_GENERAL is				do Result := locale.translate("Brea&kpoint Information")	end
	m_Class_info: STRING_GENERAL is				do Result := locale.translate("Cla&ss Views")	end
	m_Check_exports: STRING_GENERAL is			do Result := locale.translate("Chec&k Export Clauses")	end
	m_Create_new_cluster: STRING_GENERAL is		do Result := locale.translate("Add C&luster...")	end
	m_Create_new_library: STRING_GENERAL is		do Result := locale.translate("Add L&ibrary...")	end
	m_Create_new_precompile: STRING_GENERAL is	do Result := locale.translate("Add &Precompile")	end
	m_Create_new_assembly: STRING_GENERAL is	do Result := locale.translate("Add &Assembly...")	end
	m_Create_new_class: STRING_GENERAL is		do Result := locale.translate("&New Class...")	end
	m_Create_new_feature: STRING_GENERAL is		do Result := locale.translate("New Fea&ture...")	end
	m_Debug: STRING_GENERAL is					do Result := locale.translate("&Debug")	end
	m_Debugging_tool: STRING_GENERAL is			do Result := locale.translate("&Debugging Tools")	end
	m_Disable_this_bkpt: STRING_GENERAL is		do Result := locale.translate("&Disable This Breakpoint")	end
	m_Display_error_help: STRING_GENERAL is		do Result := locale.translate("Compilation Error &Wizard...")	end
	m_Display_system_info: STRING_GENERAL is	do Result := locale.translate("S&ystem Info")	end
	m_Edit: STRING_GENERAL is					do Result := locale.translate("&Edit")	end
	m_Edit_condition: STRING_GENERAL is			do Result := locale.translate("E&dit Condition")	end
	m_Edit_exported_feature: STRING_GENERAL is	do Result := locale.translate("&Edit...")	end
	m_Edit_external_commands: STRING_GENERAL is	do Result := locale.translate("&External Commands...")	end
	m_Enable_this_bkpt: STRING_GENERAL is		do Result := locale.translate("&Enable This Breakpoint")	end
	m_Favorites: STRING_GENERAL is				do Result := locale.translate("Fav&orites")	end
	m_Feature_info: STRING_GENERAL is			do Result := locale.translate("Feat&ure Views")	end
	m_File: STRING_GENERAL is					do Result := locale.translate("&File")	end
	m_Formats: STRING_GENERAL is				do Result := locale.translate("F&ormat")	end
	m_Formatter_separators: ARRAY [STRING_GENERAL] is
		do
			Result := << locale.translate("Text Generators"), locale.translate("Class Relations"),
				     locale.translate("Restrictors"), locale.translate("Main Editor Views")>>
		end
	m_History: STRING_GENERAL is				do Result := locale.translate("&Go to")	end
	m_Hit_count: STRING_GENERAL is				do Result := locale.translate("Hit count")	end
	m_Maximize: STRING_GENERAL is				do Result := locale.translate("Ma&ximize")	end
	m_Minimize: STRING_GENERAL is				do Result := locale.translate("Mi&nimize")	end
	m_Minimize_all: STRING_GENERAL is			do Result := locale.translate("&Minimize All")	end
	f_New_tab: STRING_GENERAL is 				do Result := locale.translate("New Tab")	end
	m_New_tab: STRING_GENERAL is				do Result := locale.translate("New Ta&b")	end
	m_New_editor: STRING_GENERAL is				do Result := locale.translate("New Ed&itor Window")	end
	m_New_context_tool: STRING_GENERAL is		do Result := locale.translate("New Con&text Window")	end
	m_Object: STRING_GENERAL is					do Result := locale.translate("&Object")	end
	m_Object_tools: STRING_GENERAL is			do Result := locale.translate("&Object Tools")	end
	m_Open_eac_browser: STRING_GENERAL is		do Result := locale.translate("EAC Browser")	end
	m_Pretty_print: STRING_GENERAL is			do Result := locale.translate("Expand an Object")	end
	m_Project: STRING_GENERAL is				do Result := locale.translate("&Project")	end
	m_Override_scan: STRING_GENERAL is			do Result := locale.translate("Recompile &Overrides")	end
	m_Discover_melt: STRING_GENERAL is			do Result := locale.translate("Find &Added Classes && Recompile")	end
	m_Raise: STRING_GENERAL is					do Result := locale.translate("&Raise")	end
	m_Raise_all: STRING_GENERAL is				do Result := locale.translate("&Raise All")	end
	m_Raise_all_unsaved: STRING_GENERAL is		do Result := locale.translate("Raise &Unsaved Windows")	end
	m_Remove_class_cluster: STRING_GENERAL is	do Result := locale.translate("&Remove Current Item")	end
	m_Remove_exported_feature: STRING_GENERAL is	do Result := locale.translate("&Remove")	end
	m_Remove_condition: STRING_GENERAL is		do Result := locale.translate("Remove Condition")	end
	m_Remove_this_bkpt: STRING_GENERAL is		do Result := locale.translate("&Remove This Breakpoint")	end
	m_Run_to_this_point: STRING_GENERAL is		do Result := locale.translate("&Run to This Point")	end
	m_Send_stone_to_context: STRING_GENERAL is	do Result := locale.translate("S&ynchronize Context Tool")	end
	m_Set_conditional_breakpoint: STRING_GENERAL is do Result := locale.translate("Set &Conditional Breakpoint")	end
	m_Set_critical_stack_depth: STRING_GENERAL is do Result := locale.translate("Overflow &Prevention...")	end
	m_Set_slice_size: STRING_GENERAL is			do Result := locale.translate("&Alter size New")	end
	m_Special: STRING_GENERAL is				do Result := locale.translate("&Special")	end
	m_Separate_stone: STRING_GENERAL is			do Result := locale.translate("Unlin&k Context Tool")	end
	m_Tools: STRING_GENERAL is					do Result := locale.translate("&Tools")	end
	m_Unify_stone: STRING_GENERAL is			do Result := locale.translate("Lin&k Context Tool")	end
	m_View: STRING_GENERAL is					do Result := locale.translate("&View")	end

	m_When_hits: STRING_GENERAL is				do Result := locale.translate("When hits ...")	end
	m_Window: STRING_GENERAL is					do Result := locale.translate("&Window")	end
	m_Refactoring: STRING_GENERAL is			do Result := locale.translate("&Refactoring")	end

feature -- Label texts

	l_Ace_file_for_frame: STRING_GENERAL is		do Result := locale.translate("Configuration file")	end
	l_action_colon: STRING_GENERAL is			do Result := locale.translate("Action:")	end
	l_Active_query: STRING_GENERAL is			do Result := locale.translate("Active query")	end
	l_Address_colon: STRING_GENERAL is				do Result := locale.translate("Address:")	end
	l_Address: STRING_GENERAL is				do Result := locale.translate("Address")	end
	l_add_a_valuable: STRING_GENERAL is				do Result := locale.translate("Add a variable (double click or Enter); Use an existing variable (right click or Ctrl+Enter)")	end
	l_add_project_config_file: STRING_GENERAL is	do Result := locale.translate("Add Project...")	end
	l_additional_details: STRING_GENERAL is		do Result := locale.translate("Additional details")	end
	l_All: STRING_GENERAL is					do Result := locale.translate("recursive")	end
	l_all_classes_in_same_cluster: STRING_GENERAL is	do Result := locale.translate("All classes in same cluster")	end
	l_Alias_name: STRING_GENERAL is				do Result := locale.translate("Alias:")	end
	l_Ancestors: STRING_GENERAL is				do Result := locale.translate("ancestors")	end
	l_apply_changes_to_view_named: STRING_GENERAL is	do Result := locale.translate("Apply changes to view named: ")	end
	l_Arguments: STRING_GENERAL is				do Result := locale.translate("Arguments")	end
	l_assigners: STRING_GENERAL is				do Result := locale.translate("assigners")	end
	l_Attribute: STRING_GENERAL is				do Result := locale.translate("Attribute")	end
	l_Attributes: STRING_GENERAL is				do Result := locale.translate("attributes")	end
	l_auto: STRING_GENERAL is					do Result := locale.translate ("auto") end
	l_Available_buttons_text: STRING_GENERAL is do Result := locale.translate("Available buttons")	end
	l_Basic_application: STRING_GENERAL is		do Result := locale.translate("Basic application (no graphics library included)")	end
	l_Basic_text: STRING_GENERAL is				do Result := locale.translate("basic text view")	end
	l_building_flat_view: STRING_GENERAL is		do Result := locale.translate ("Building flat view ...") end
	l_building_tree_view: STRING_GENERAL is		do Result := locale.translate ("Building tree view ...") end
	l_capture: STRING_GENERAL is 				do Result := locale.translate ("Capture") end
	l_Callers: STRING_GENERAL is				do Result := locale.translate("callers")	end
	l_Calling_convention: STRING_GENERAL is		do Result := locale.translate("Calling convention:")	end
	l_center_attraction: STRING_GENERAL is		do Result := locale.translate("Center attraction:")	end
	l_center_attraction_value (a_value: STRING_GENERAL): STRING_GENERAL is	do Result := locale.format_string (locale.translate("Center attraction ($1%%)"), [a_value])	end
	l_chart: STRING_GENERAL is		do Result := locale.translate("Chart") end
	l_relations: STRING_GENERAL is		do Result := locale.translate("Relations")	end
	l_text: STRING_GENERAL is		do Result := locale.translate("Text")	end
	l_contract: STRING_GENERAL is		do Result := locale.translate("Contract")	end
	l_flat_contracts:  STRING_GENERAL is		do Result := locale.translate("Flat contracts")	end
	l_Continue_execution: STRING_GENERAL is			do Result := locale.translate("Continue execution")	end
	l_Choose_folder: STRING_GENERAL is			do Result := locale.translate("Select the destination folder ")	end
	l_one_target_among: STRING_GENERAL is			do Result := locale.translate("Choose one target among: ")	end
	l_class: STRING_GENERAL is					do Result := locale.translate ("Class") end
	l_class_colon: STRING_GENERAL is					do Result := locale.translate("Class:")	end
	l_class_is_not_writable (a_class: STRING_GENERAL): STRING_GENERAL is
		require
			a_class_not_void: a_class /= Void
		do
			Result := locale.format_string (locale.translate("The class $1 is not writable."), [a_class])
		end
	l_class_is_not_editable: STRING_GENERAL is	do Result := locale.translate ("Class is not editable.%N") end
	l_class_is_not_in_anymore (a_class_name, a_group_id: STRING): STRING is
		do
			Result := "Class " + a_class_name + " is not in " + a_group_id + " anymore."
		end
	l_class_name (a_class: STRING_GENERAL): STRING_GENERAL is
		require a_class_not_void: a_class /= Void
		do Result := locale.format_string (locale.translate("Class name: $1"), [a_class])	end
	l_class_name_not_valid: STRING_GENERAL is					do Result := locale.translate("The class name is not valid.")	end
	l_clean: STRING_GENERAL is					do Result := locale.translate("Clean")	end
	l_clean_user_file: STRING_GENERAL is		do Result := locale.translate("Reset user settings")	end
	l_Clients: STRING_GENERAL is				do Result := locale.translate("clients")	end
	l_Clients_stiffness: STRING_GENERAL is				do Result := locale.translate("Client stiffness:")	end
	l_Clients_stiffness_value (a_value: STRING_GENERAL): STRING_GENERAL is	do Result := locale.format_string ("Client stiffness ($1%%)", [a_value])	end
	l_Clickable: STRING_GENERAL is				do Result := locale.translate("clickable view")	end
	l_cluster: STRING_GENERAL is				do Result := locale.translate ("Cluster") end
	l_cluster_colon: STRING_GENERAL is			do Result := locale.translate("Cluster:")	end
	l_cluster_is_not_in_the_system_anymore (a_cluster: STRING): STRING is
		do
			Result := "Cluster " + a_cluster + " is not in the system anymore."
		end
	l_Cluster_name: STRING_GENERAL is			do Result := locale.translate("Cluster name ")	end
	l_Cluster_options: STRING_GENERAL is		do Result := locale.translate("Cluster options ")	end
	l_Command_error_output: STRING_GENERAL is	do Result := locale.translate("Command error output:%N")	end
	l_Command_line: STRING_GENERAL is			do Result := locale.translate("Command line:")	end
	l_Command_normal_output: STRING_GENERAL is	do Result := locale.translate("Command output:%N")	end
	l_Compiled_class: STRING_GENERAL is			do Result := locale.translate("Only compiled classes")	end
	l_compile: STRING_GENERAL is				do Result := locale.translate("Compile")	end
	l_Compile_first: STRING_GENERAL is			do Result := locale.translate("Compile to have information")	end
	l_Compile_project: STRING_GENERAL is		do Result := locale.translate("Compile project")	end
	l_Condition: STRING_GENERAL is				do Result := locale.translate("Condition")	end
	l_Confirm_kill: STRING_GENERAL is			do Result := locale.translate("Stop the application?")	end
	l_Confirm_kill_and_restart: STRING_GENERAL is			do Result := locale.translate("Stop and restart the application?")	end

	l_constructing_diagram_for (a_name: STRING_GENERAL): STRING_GENERAL is			do Result := locale.format_string (locale.translate("Constructing Diagram for $1"), [a_name])	end
	l_Context: STRING_GENERAL is				do Result := locale.translate("Context")	end
	l_context_dot: STRING_GENERAL is			do Result := locale.translate("Context ...") end
	l_Creation: STRING_GENERAL is				do Result := locale.translate("Creation procedure:")	end
	l_creators: STRING_GENERAL is				do Result := locale.translate("creators")	end
	l_Current_context: STRING_GENERAL is		do Result := locale.translate("Current feature")	end
	l_Current_editor: STRING_GENERAL is			do Result := locale.translate("Current editor")	end
	l_Current_hit_count: STRING_GENERAL is		do Result := locale.translate("Current hit count:")	end
	l_Current_hit_count_short: STRING_GENERAL is		do Result := locale.translate("hits: ")	end
	l_Current_object: STRING_GENERAL is			do Result := locale.translate("Current object")	end
	l_Custom: STRING_GENERAL is 				do Result := locale.translate("Custom")	end

	l_c_compilation_manager_launch_failed (a_sub: BOOLEAN): STRING_GENERAL is
		local
			l_exe: STRING
		do
			if a_sub then
				l_exe := ".exe"
			else
				l_exe := ""
			end
			Result := locale.format_string (locale.translate (
						"C-compilation manager launch failed.%NCheck if finish_freezing$1%
						% exists and works correctly."
					), [l_exe])
		end

	l_c_compilation_produced_errors (a_dir: STRING_GENERAL): STRING_GENERAL is
		do
			Result := locale.format_string (locale.translate (
						"C-compilation produced errors.%N%
						%Run your Makefile utility program from the directory `%
						%$1`%Nto see what went wrong.%N%NClick OK to terminate.%
						%%NClick Cancel to open a command line console.%N"
					), [a_dir])
		end

	l_c_compilation_and_external_command_running: STRING_GENERAL is
		do Result := locale.translate("A C Compilation and an external command are currently running.%N%
								%They need to be terminated before EiffelStudio can exist.%N%N%
								%Cancel C compilation, terminate external command and exit?%N")	end
	l_c_compilation_running: STRING_GENERAL is
		do Result := locale.translate("A C Compilation is currently running.%N%
								%It needs to be terminated before EiffelStudio can exist.%N%N%
								%Cancel C compilation and exit?%N")	end
	l_external_command_running: STRING_GENERAL is
		do Result := locale.translate("An external command is currently running.%N%
								%It need to be terminated before EiffelStudio can exist.%N%N%
								%Terminate external command and exit?%N")	end

	l_debugger_exception_message: STRING_GENERAL is do Result := locale.translate("Debugger :: Exception message")	end
	l_default: STRING_GENERAL is				do Result := locale.translate ("default") end
	l_Deferred: STRING_GENERAL is				do Result := locale.translate("deferred")	end
	l_Deferreds: STRING_GENERAL is				do Result := locale.translate("deferred features")	end
	l_Deleting_dialog_default: STRING_GENERAL is do Result := locale.translate("Creating new project, please wait...")	end
	l_Descendants: STRING_GENERAL is			do Result := locale.translate("descendants")	end
	l_descending_class_already_has_feature (a_class: STRING_GENERAL): STRING_GENERAL is
		require
			a_class_not_void: a_class /= Void
		do
			Result := locale.format_string (locale.translate("The descending class $1 already has another feature with the new name."), [a_class])
		end

	l_description: STRING_GENERAL is 			do Result := locale.translate ("Description") end
	l_Diagram_delete_view_cmd: STRING_GENERAL is	do Result := locale.translate("Do you really want to delete current view?")	end
	l_Diagram_reset_view_cmd: STRING_GENERAL is		do Result := locale.translate("Do you really want to reset current view?")	end
	l_diagram_statistic (a_nclass, a_ncslink, a_nilink, a_ncluster,a_physics, a_draw, a_draws: STRING_GENERAL): STRING_GENERAL is
		do
			Result := locale.format_string (
						locale.translate (
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

	l_Discard_convert_project_dialog: STRING_GENERAL is	do Result := locale.translate("Do not ask again, and always convert old projects")	end
	l_Discard_build_precompile_dialog: STRING_GENERAL is do Result := locale.translate("Do not ask again, and always build precompile")	end
	l_Discard_finalize_assertions: STRING_GENERAL is do Result := locale.translate("Do not ask again, and always discard assertions when finalizing")	end
	l_Discard_finalize_precompile_dialog: STRING_GENERAL is do Result := locale.translate("Don't ask me again and always finalize.")	end
	l_Discard_freeze_dialog: STRING_GENERAL is	do Result := locale.translate("Do not ask again, and always compile C code")	end
	l_Discard_save_before_compile_dialog: STRING_GENERAL is	do Result := locale.translate("Do not ask again, and always save files before compiling")	end
	l_Discard_starting_dialog: STRING_GENERAL is do Result := locale.translate("Don't show this dialog at startup")	end
	l_Discard_replace_all_warning_dialog: STRING_GENERAL is do Result := locale.translate("Don't ask me again and always replace all")	end
	l_Discard_terminate_freezing: STRING_GENERAL is do Result := locale.translate("Do not ask again, and always terminate freezing when needed.")	end
	l_Discard_terminate_external_command: STRING_GENERAL is do Result := locale.translate("Do not ask again, and always terminate running external command.")	end
	l_Discard_terminate_finalizing: STRING_GENERAL is do Result := locale.translate("Do not ask again, and always terminate finalizing when needed.")	end
	l_discard_cancel_c_compilation_and_external_command: STRING_GENERAL is do Result := locale.translate("Do not ask again, and always cancel C compilation, terminate external command when exiting.")	end
	l_discard_cancel_c_compilation: STRING_GENERAL is	do Result := locale.translate("Do not ask again, and always cancel C Compilation when exiting.")	end
	l_discard_terminate_external_command_when_exit: STRING_GENERAL is	do Result := locale.translate("Do not ask again, and always terminate external command when exiting.")	end
	l_Display_call_stack_warning: STRING_GENERAL is	do Result := locale.translate("Display a warning when the call stack depth reaches:")	end
	l_Displayed_buttons_text: STRING_GENERAL is do Result := locale.translate("Displayed buttons")	end
	l_display_window: STRING_GENERAL is			do Result := "Display window" end
	l_Dont_ask_me_again: STRING_GENERAL is		do Result := locale.translate("Do not ask me again")	end
	l_Do_not_detect_stack_overflows: STRING_GENERAL is do Result := locale.translate("Do not detect stack overflows")	end
	l_Do_not_show_again: STRING_GENERAL is		do Result := locale.translate("Do not show again")	end
	l_Dropped_references: STRING_GENERAL is		do Result := locale.translate("Dropped references")	end
	l_Dummy: STRING_GENERAL is					do Result := locale.translate("Should not be read")	end
	l_Not_empty: STRING_GENERAL is				do Result := locale.translate("Generate default feature clauses")	end
	l_no_break_point: STRING_GENERAL is				do Result := locale.translate("No breakpoints")	end
	l_edit_project: STRING_GENERAL is			do Result := locale.translate("Edit Project")	end
	l_Elements: STRING_GENERAL is				do Result := locale.translate("elements.")	end
	l_enabled: STRING_GENERAL is				do Result := locale.translate("Enabled")	end
	l_Enter_folder_name: STRING_GENERAL is		do Result := locale.translate("Enter the name of the new folder: ")	end
	l_environment: STRING_GENERAL is					do Result := locale.translate("Environment")	end
	l_error: STRING_GENERAL is					do Result := locale.translate("Error")	end
	l_error_message:  STRING_GENERAL is					do Result := locale.translate("Error message :")	end
	l_error_on_expression (a_expression: STRING_GENERAL): STRING_GENERAL is
		require
			a_expression_not_void: a_expression /= Void
		do
			Result := locale.format_string (locale.translate("Error on expression : %"$1%""), [a_expression])
		end

	l_Executing_command: STRING_GENERAL is		do Result := locale.translate("Command is currently executing.%NPress OK to ignore the output.")	end
	l_Execution_interrupted: STRING_GENERAL is	do Result := locale.translate("Execution interrupted")	end
	l_exception_double_click_text: STRING_GENERAL is do Result := locale.translate ("Double click to see Exception or Ctrl-C to copy to clipboard") end
	l_exception_raised: STRING_GENERAL is do Result := locale.translate ("Exception raised") end
	l_exception_message_from_debugger: STRING_GENERAL is do Result := locale.translate ("Exception message from debugger") end
	l_Exit_application: STRING_GENERAL is
		once
			Result := locale.format_string(locale.translate("Are you sure you want to quit $1?"), [Workbench_name])
		end
	l_Exit_warning: STRING_GENERAL is			do Result := locale.translate("Some files have not been saved.%NDo you want to save them before exiting?")	end
	l_Expanded: STRING_GENERAL is				do Result := locale.translate("expanded")	end
	l_Explicit_exception_pending: STRING_GENERAL is do Result := locale.translate("Explicit exception pending")	end
	l_exploring_ancestor_of (a_class: STRING_GENERAL): STRING_GENERAL is				do Result := locale.format_string (locale.translate("Exploring ancestors of $1"), [a_class])	end
	l_exploring_descendants_of (a_class: STRING_GENERAL): STRING_GENERAL is				do Result := locale.format_string (locale.translate("Exploring descendants of $1"), [a_class])	end
	l_exploring_clinets_of (a_class: STRING_GENERAL): STRING_GENERAL is					do Result := locale.format_string (locale.translate("Exploring clients of $1"), [a_class])	end
	l_exploring_suppliers_of (a_class: STRING_GENERAL): STRING_GENERAL is				do Result := locale.format_string (locale.translate("Exploring suppliers of $1"), [a_class])	end
	l_Exported: STRING_GENERAL is				do Result := locale.translate("exported features")	end
	l_Expression: STRING_GENERAL is				do Result := locale.translate("Expression")	end
	l_false: STRING_GENERAL is					do Result := locale.translate ("False") end
	l_External: STRING_GENERAL is				do Result := locale.translate("external features")	end
	l_Feature: STRING_GENERAL is				do Result := locale.translate("Feature")	end
	l_Feature_colon: STRING_GENERAL is				do Result := locale.translate("Feature:")	end
	l_feature_list: STRING_GENERAL is				do Result := locale.translate("Feature list")	end
	l_Feature_properties: STRING_GENERAL is		do Result := locale.translate("Feature properties")	end
	l_force_inheritance: STRING_GENERAL is do Result := locale.translate ("Force inheritance on child elements.")	end
	l_file_location: STRING_GENERAL is 			do Result := locale.translate ("File location") end
	l_File_name: STRING_GENERAL is				do Result := locale.translate("File name:")	end
	l_file_changed_by_other_tool: STRING_GENERAL is do Result := locale.translate ("File has been changed by another tool/editor%NDo you want to load the changes?") end
	l_finalize: STRING_GENERAL is				do Result := locale.translate("Finalize")	end
	l_Finalized_mode: STRING_GENERAL is 		do Result := locale.translate("Finalized mode")	end
	l_finish_to_generate: STRING_GENERAL is 	do Result := locale.translate("Click `Finish' to generate the documentation.")	end
	l_first_chance: STRING_GENERAL is 			do Result := locale.translate ("First chance") end
	l_Flat: STRING_GENERAL is					do Result := locale.translate("flat view")	end
	l_Flat_view: STRING_GENERAL is				do Result := locale.translate ("Flat View") end
	l_Flatshort: STRING_GENERAL is				do Result := locale.translate("interface view")	end
	l_found: STRING_GENERAL is 					do Result := locale.translate ("Found") end
	l_freeze: STRING_GENERAL is					do Result := locale.translate("Freeze")	end
	l_fresh_compilation: STRING_GENERAL is		do Result := locale.translate("Recompile project")	end
	l_general: STRING_GENERAL is				do Result := locale.translate("General")	end
	l_Generate_profile_from_rtir: STRING_GENERAL is do Result := locale.translate("Generate profile from Run-time information record")	end
	l_Generate_creation: STRING_GENERAL is		do Result := locale.translate("Generate creation procedure")	end
	l_grid_column_layout: STRING_GENERAL is		do Result := locale.translate ("Grid column layout") end
			-- Preferece name prefix. For "debugger.grid_column_layout_XX".
	l_Has_changed: STRING_GENERAL is			do Result := locale.translate("Has Changed")	end
	l_Homonyms: STRING_GENERAL is				do Result := locale.translate("homonyms")	end
	l_Homonym_confirmation: STRING_GENERAL is	do Result := locale.translate("Extracting the homonyms%Nmay take a long time.")	end
	l_Identification: STRING_GENERAL is			do Result := locale.translate("Identification")	end
	l_inheritance_cycle_was_created: STRING_GENERAL is			do Result := locale.translate("An inheritance cycle was created.%NDo you still want to add this link?")	end
	l_inheritance_stiffness: STRING_GENERAL is			do Result := locale.translate("Inheritance stiffness:")	end
	l_inheritance_stiffness_100: STRING_GENERAL is			do Result := locale.translate("Inheritance stiffness (100%%)")	end
	l_inheritance_stiffness_value (a_value: STRING_GENERAL): STRING_GENERAL is	do Result := locale.format_string ("Inheritance stiffness ($1%%)", [a_value])	end
	l_Implicit_exception_pending: STRING_GENERAL is do Result := locale.translate("Implicit exception pending")	end
	l_Implementers: STRING_GENERAL is			do Result := locale.translate("implementers")	end
	l_Inactive_subqueries: STRING_GENERAL is	do Result := locale.translate("Inactive subqueries")	end
	l_include_colon: STRING_GENERAL is	do Result := locale.translate("Include:")	end
	l_include: STRING_GENERAL is 				do Result := locale.translate("Include")	end
	l_Index: STRING_GENERAL is					do Result := locale.translate("Index:")	end
	l_indexing_clause_error: STRING_GENERAL is			do Result := locale.translate("Indexing clause has syntax error")	end
	l_invariants: STRING_GENERAL is				do Result := locale.translate("invariants")	end
	l_Is_true: STRING_GENERAL is				do Result := locale.translate("Is True")	end
	l_Language_type: STRING_GENERAL is			do Result := locale.translate("Language type")	end
	l_Library: STRING_GENERAL is				do Result := locale.translate("library")	end
	l_line: STRING_GENERAL is 					do Result := locale.translate ("Line") end
	l_Literal_value: STRING_GENERAL is			do Result := locale.translate("Literal Value")	end
	l_Loaded_project: STRING_GENERAL is			do Result := locale.translate("Loaded project: ")	end
	l_Loading_diagram: STRING is				"Loading diagram:"
	l_Location_colon: STRING_GENERAL is 				do Result := locale.translate("Location: ")	end
	l_Locals: STRING_GENERAL is					do Result := locale.translate("Locals")	end
	l_Min_index: STRING_GENERAL is				do Result := locale.translate("Minimum index displayed")	end
	l_Match_case: STRING_GENERAL is				do Result := locale.translate("Match case")	end

	l_matches_of_total_preferences (a_count: STRING_GENERAL; a_total_count: STRING_GENERAL): STRING_GENERAL is
		require
			a_count_not_void: a_count /= Void
			a_total_count_not_void: a_total_count /= Void
		do
			Result := locale.format_string (locale.translate ("$1 matches of $2 total preferences"), [a_count, a_total_count])
		end

	l_count_preferences (a_count: STRING_GENERAL): STRING_GENERAL is
		require
			a_count_not_void: a_count /= Void
		do
			Result := locale.format_string (locale.translate ("$1 preferences"), [a_count])
		end

	l_Max_index: STRING_GENERAL is				do Result := locale.translate("Maximum index displayed")	end
	l_Max_displayed_string_size: STRING_GENERAL is do Result := locale.translate("Maximum displayed string size")	end
	l_More_items: STRING_GENERAL is				do Result := locale.translate("Display limit reached")	end
	l_Name: STRING_GENERAL is					do Result := locale.translate("Name")	end
	l_Name_colon: STRING_GENERAL is				do Result := locale.translate("Name:")	end
	l_New_breakpoint: STRING_GENERAL is			do Result := locale.translate("New breakpoint(s) to commit")	end
	l_note: STRING_GENERAL is					do Result := locale.translate ("Note") end
	l_no_description_text: STRING_GENERAL is 	do Result := locale.translate ("No description available for this preference.") end
	l_no_default_value: STRING_GENERAL is		do Result := locale.translate ("No default value") end
	l_No_feature: STRING_GENERAL is				do Result := locale.translate("Select a fully compiled feature to have information about it.")	end
	l_No_feature_group_clause: STRING_GENERAL is do Result := locale.translate("[Unnamed feature clause]")	end
	l_No_text_text: STRING_GENERAL is 			do Result := locale.translate("No text labels")	end
	l_no_feature_bra: STRING_GENERAL is 		do Result := locale.translate ("(no_feature)") end
	l_no_class_bra: STRING_GENERAL is 		do Result := locale.translate ("(no_class)") end
	l_no_cluster_bra: STRING_GENERAL is 		do Result := locale.translate ("(no_cluster)") end
	l_no_views_are_available: STRING_GENERAL is 		do Result := locale.translate ("No views are available for this cluster") end
	l_Not_in_system_no_info: STRING_GENERAL is	do Result := locale.translate("Select a class which is fully compiled to have information about it.")	end
	l_Not_yet_called: STRING_GENERAL is			do Result := locale.translate("Not yet called")	end
	l_in_n_classes (n: INTEGER): STRING_GENERAL is
		do
			Result := locale.format_string (locale.translate_plural ("in $1 class", "in $1 classes", n), [n])
		end
	l_n_matches (n: INTEGER): STRING_GENERAL is
		do
			Result := locale.format_string (locale.translate_plural ("$1 match", "$1 matches", n), [n])
		end
	l_Object_attributes: STRING_GENERAL is		do Result := locale.translate("Attributes")	end
	l_object_tool_left: STRING_GENERAL is		do Result := locale.translate("Objects tool: left")	end
	l_object_tool_right: STRING_GENERAL is		do Result := locale.translate("Objects tool: right")	end
	l_On_object: STRING_GENERAL is				do Result := locale.translate("On object")	end
	l_As_object: STRING_GENERAL is				do Result := locale.translate("As object")	end
	l_Onces: STRING_GENERAL is					do Result := locale.translate("once routines and constants")	end
	l_Once_functions: STRING_GENERAL is			do Result := locale.translate("Once routines")	end
	l_only_classes_in_same_cluster: STRING_GENERAL is			do Result := locale.translate("Only classes in same cluster")	end
	l_open: STRING_GENERAL is					do Result := locale.translate("Open")	end
	l_Open_a_project: STRING_GENERAL is			do Result := locale.translate("Open a project")	end
	l_Open_project: STRING_GENERAL is 			do Result := locale.translate("Open project")	end
	l_Options: STRING_GENERAL is 				do Result := locale.translate("Options")	end
	l_Options_colon: STRING_GENERAL is 				do Result := locale.translate("Options: ")	end
	l_Output_switches: STRING_GENERAL is		do Result := locale.translate("Output switches")	end
	l_Parent_cluster: STRING_GENERAL is			do Result := locale.translate("Parent cluster")	end
	l_parents: STRING_GENERAL is				do Result := locale.translate("Parents:")	end
	l_Path: STRING_GENERAL is					do Result := locale.translate("Path")	end
	l_Possible_overflow: STRING_GENERAL is		do Result := locale.translate("Possible stack overflow")	end
	l_precompile: STRING_GENERAL is				do Result := locale.translate("Precompile")	end
	l_preferences_delayed_resources: STRING_GENERAL is do Result := locale.translate ("The changes you have made to the following resources%Nwill be taken into account after you restart.%N%N") end
	l_Print_message: STRING_GENERAL is			do Result := locale.translate("Print a message:")	end
	l_Print_message_help: STRING_GENERAL is
		do
			Result := locale.translate ("[
					You can include the value of an expression in the message by
					placing it in curly braces, suce as "The value of x i {x}.".
					To insert a curly brace, use "\{". To insert a backslash, use "\\".
					
					The following special keywords will be replaced with their current values:
						$HITCOUNT - breakpoint's hit count
						$ADDRESS - current object address
						$CALLSTACK - current call stack
						$CLASS - current class name
						$FEATURE - current feature name
						$THREADID - current thread id
					]")
		end
	l_procedure: STRING_GENERAL is			do Result := locale.translate("Procedure")	end
	l_Profiler_used: STRING_GENERAL is			do Result := locale.translate("Profiler used to produce the above record: ")	end
	l_profile_no: STRING_GENERAL is			do Result := locale.translate("profile #")	end
	l_Project_location: STRING_GENERAL is		do Result := locale.translate("The project location is the place where compilation%Nfiles will be generated by the compiler")	end
	l_Put_text_right_text: STRING_GENERAL is 	do Result := locale.translate("Show selective text on the right of buttons")	end
	l_Show_all_text: STRING_GENERAL is			do Result := locale.translate("Show text labels")	end
	l_Switching_to_debug_mode: STRING_GENERAL is do Result := locale.translate("Switching to debug mode")	end
	l_Switching_to_normal_mode: STRING_GENERAL is do Result := locale.translate("Switching to normal mode")	end

	l_Query: STRING_GENERAL is					do Result := locale.translate("Query")	end
	l_refresh_tools: STRING_GENERAL is			do Result := locale.translate("Refresh tools")	end
	l_remove_project: STRING_GENERAL is			do Result := locale.translate("Remove Project")	end
	l_Remove_object: STRING_GENERAL is			do Result := locale.translate("Remove")	end
	l_Remove_object_desc: STRING_GENERAL is		do Result := locale.translate("Remove an object from the tree")	end
	l_removing_unneeded_items: STRING_GENERAL is do Result := locale.translate ("Removing unneeded items") end
	l_Replace_with: STRING_GENERAL is			do Result := locale.translate("Replace with: ")	end
	l_Replace_with_ellipsis: STRING_GENERAL is	do Result := locale.translate("Replace with...")	end
	l_Replace_all: STRING_GENERAL is			do Result := locale.translate("Replace all")	end
	l_request_restart: STRING_GENERAL is		do Result := locale.translate (" (REQUIRES RESTART)") end
	l_restore_defaults: STRING_GENERAL is 		do Result := locale.translate ("Restore Defaults") end
	l_restore_default: STRING_GENERAL is 		do Result := locale.translate ("Restore Default") end
	l_restore_preference_string: STRING_GENERAL is do Result := locale.translate ("This will reset ALL preferences to their default values%N and all previous settings will be overwritten.  Are you sure?") end
	l_Result: STRING_GENERAL is					do Result := locale.translate("Result")	end
	l_repulsion: STRING_GENERAL is					do Result := locale.translate("Repulsion:")	end
	l_repulsion_value (a_value: STRING_GENERAL): STRING_GENERAL is	do Result := locale.format_string (locale.translate("Repulsion ($1%%)"), [a_value])	end
	l_rollback_question: STRING_GENERAL is		do Result := locale.translate("Rollback?")	end
	l_Root_class: STRING_GENERAL is				do Result := locale.translate("Root class name: ")	end
	l_Root_class_name: STRING_GENERAL is		do Result := locale.translate("Root class: ")	end
	l_Root_cluster_name: STRING_GENERAL is		do Result := locale.translate("Root cluster: ")	end
	l_Root_feature_name: STRING_GENERAL is		do Result := locale.translate("Root feature: ")	end
	l_Routine_ancestors: STRING_GENERAL is		do Result := locale.translate("ancestor versions")	end
	l_Routine_descendants: STRING_GENERAL is	do Result := locale.translate("descendant versions")	end
	l_Routine_flat: STRING_GENERAL is			do Result := locale.translate("flat view")	end
	l_Routines: STRING_GENERAL is				do Result := locale.translate("routines")	end
	l_Runtime_information_record: STRING_GENERAL is do Result := locale.translate("Run-time information record")	end
	l_Same_class_name: STRING_GENERAL is		do Result := locale.translate("---")	end
	l_Scope: STRING_GENERAL is 					do Result := locale.translate("Scope")	end
	l_Search_backward: STRING_GENERAL is		do Result := locale.translate("Search backwards")	end
	l_Search_for: STRING_GENERAL is				do Result := locale.translate("Search for: ")	end
	l_Search_options_show: STRING_GENERAL is	do Result := locale.translate("Scope >>")	end
	l_Search_options_hide: STRING_GENERAL is	do Result := locale.translate("Scope <<")	end
	l_Search_report_show: STRING_GENERAL is		do Result := locale.translate("Report >>")	end
	l_Search_report_hide: STRING_GENERAL is 	do Result := locale.translate("Report <<")	end
	l_Set_as_default: STRING_GENERAL is			do Result := locale.translate("Set as default")	end
	l_Set_slice_limits: STRING is				"Slice limits"
	l_Set_slice_limits_desc: STRING_GENERAL is	do Result := locale.translate("Set which values are shown in special objects")	end
	l_Short: STRING_GENERAL is					do Result := locale.translate("contract view")	end
	l_Short_name: STRING_GENERAL is				do Result := locale.translate("Short Name")	end
	l_Show_all_call_stack: STRING_GENERAL is	do Result := locale.translate("Show all stack elements")	end
	l_Show_only_n_elements: STRING_GENERAL is	do Result := locale.translate("Show only:")	end
	l_Showallcallers: STRING_GENERAL is			do Result := locale.translate("Show all callers")	end
	l_Showcallers: STRING_GENERAL is			do Result := locale.translate("Show static callers")	end
	l_Showstops: STRING_GENERAL is				do Result := locale.translate("Show stop points")	end
	l_Slice_taken_into_account1: STRING_GENERAL is do Result := locale.translate("Warning: Modifications will be taken into account")	end
	l_Slice_taken_into_account2: STRING_GENERAL is do Result := locale.translate("for the next objects you will add in the object tree.")	end
	l_space_disabled: STRING_GENERAL is 		do Result := locale.translate(" disabled")	end
	l_space_enabled: STRING_GENERAL is 			do Result := locale.translate(" enabled")	end
	l_space_error: STRING_GENERAL is 			do Result := locale.translate(" error")	end
	l_Specify_arguments: STRING_GENERAL is		do Result := locale.translate("Specify arguments")	end
	l_Stack_information: STRING_GENERAL is		do Result := locale.translate("Stack information")	end
	l_status: STRING_GENERAL is					do Result := locale.translate ("Status") end
	l_Stepped: STRING_GENERAL is				do Result := locale.translate("Step completed")	end
	l_stiffness_value (a_value: STRING_GENERAL): STRING_GENERAL is	do Result := locale.format_string (locale.translate("Stiffness ($1%%)"), [a_value])	end
	l_Stop_point_reached: STRING_GENERAL is		do Result := locale.translate("Breakpoint reached")	end
	l_Sub_cluster: STRING_GENERAL is			do Result := locale.translate("Subcluster")	end
	l_Sub_clusters: STRING_GENERAL is			do Result := locale.translate("Recursive")	end
	l_super_cluster: STRING_GENERAL is			do Result := locale.translate("Super-clusters")	end
	l_subclusters: STRING_GENERAL is			do Result := locale.translate("Sub-clusters")	end
	l_Subquery: STRING_GENERAL is				do Result := locale.translate("Define new subquery")	end
	l_Suppliers: STRING_GENERAL is				do Result := locale.translate("suppliers")	end
	l_Switch_num_format: STRING_GENERAL is 		do Result := locale.translate("Switch numerical formating")	end
	l_Switch_num_format_desc: STRING_GENERAL is do Result := locale.translate("Display numerical value as Hexadecimal or Decimal formating")	end
	l_synchronizing_classes: STRING_GENERAL is do Result := locale.translate ("Synchronizing classes") end
	l_synchronizing_class_relations: STRING_GENERAL is do Result := locale.translate ("Synchronizing class relations") end
	l_synchronizing_clusters: STRING_GENERAL is do Result := locale.translate ("Synchronizing clusters") end
	l_synchronizing_clusters_relations: STRING_GENERAL is do Result := locale.translate ("Synchronizing cluster relations") end
	l_synchronizing_diagram_tool: STRING_GENERAL is do Result := locale.translate ("Synchronizing diagram tool: ") end
	l_synchronizing_links: STRING_GENERAL is do Result := locale.translate ("Synchronizing links") end
	l_Syntax_error: STRING_GENERAL is			do Result := locale.translate("Class text has syntax error")	end
	l_System_name: STRING_GENERAL is			do Result := locale.translate("System name: ")	end
	l_System_properties: STRING_GENERAL is		do Result := locale.translate("System properties")	end
	l_System_running: STRING_GENERAL is			do Result := locale.translate("System running")	end
	l_System_launched: STRING_GENERAL is		do Result := locale.translate("System launched")	end
	l_System_not_running: STRING_GENERAL is		do Result := locale.translate("System not running")	end
	l_Tab_output: STRING_GENERAL is 			do Result := locale.translate("Output")	end
	l_Tab_class_info: STRING_GENERAL is 		do Result := locale.translate("Class")	end
	l_Tab_feature_info: STRING_GENERAL is 		do Result := locale.translate("Feature Relation")	end
	l_Tab_diagram: STRING_GENERAL is 			do Result := locale.translate("Diagram")	end
	l_target: STRING_GENERAL is					do Result := locale.translate("Target")	end
	l_target_does_not_exist (a_target: STRING_GENERAL): STRING_GENERAL is
		require
			a_target_not_void: a_target /= Void
		do
			Result := locale.format_string (locale.translate ("Target `$1' does not exist or is not compilable.%NChoose one target among:"), [a_target])
		end
	l_Text_loaded: STRING_GENERAL is			do Result := locale.translate("Text finished loading")	end
	l_Text_saved: STRING_GENERAL is				do Result := locale.translate("Text was saved")	end
	l_the_feature_name_is_not_valid: STRING_GENERAL is 	do Result := locale.translate("The feature name is not valid.")	end
	l_there_is_already_a_feature_in (a_class: STRING_GENERAL): STRING_GENERAL is
		require
			a_class_not_void: a_class /= Void
		do
			Result := locale.format_string (locale.translate ("There is already a feature with this name in class $1. This would lead to a conflict."), [a_class])
		end

	l_there_is_already_a_class_with_the_same_name: STRING_GENERAL is do Result := locale.translate("There is already a class with the same name.")	end
	l_Three_dots: STRING_GENERAL is				do Result := locale.translate("...")	end
	l_tree_or_flat_view: STRING_GENERAL is		do Result := locale.translate ("Tree/Flat View") end
	l_Tree_view: STRING_GENERAL is				do Result := locale.translate ("Tree View") end
	l_true: STRING_GENERAL is					do Result := locale.translate ("True") end
	l_try_saving_file_and_searching: STRING_GENERAL is 	do Result := locale.translate ("Item expires. Try saving file and searching again.") end
	l_try_searching: STRING_GENERAL is 	do Result := locale.translate ("Item expires. Try searching again.") end
	l_Text_loading: STRING_GENERAL is		do Result := locale.translate("Current text is being loaded. It is therefore%Nnot editable nor pickable.")	end
	l_Toolbar_select_text_position: STRING_GENERAL is do Result := locale.translate("Text option: ")	end
	l_Toolbar_select_has_gray_icons: STRING_GENERAL is do Result := locale.translate("Icon option: ")	end
	l_Top_level: STRING_GENERAL is				do Result := locale.translate("Top-level")	end
	l_Type: STRING_GENERAL is					do Result := locale.translate("Type")	end
	l_undo_not_possible: STRING_GENERAL is			do Result := locale.translate("Undo not possible.")	end
	l_Unknown_status: STRING_GENERAL is			do Result := locale.translate("Unknown application status")	end
	l_Unknown_class_name: STRING_GENERAL is		do Result := locale.translate("Unknown class name")	end
	l_unhandled: STRING_GENERAL is 				do Result := locale.translate ("UnHandled") end
	l_unselected: STRING_GENERAL is 				do Result := locale.translate ("Unselected") end
	l_up_to_depth_of: STRING_GENERAL is 				do Result := locale.translate ("Up to depth of") end
	l_Use_existing_profile: STRING_GENERAL is	do Result := locale.translate("Use existing profile: ")	end
	l_Use_regular_expression: STRING_GENERAL is do Result := locale.translate("Use regular expression")	end
	l_Use_wildcards: STRING_GENERAL is			do Result := locale.translate("Use wildcards")	end
	l_Use_wizard: STRING_GENERAL is 			do Result := locale.translate("Create project")	end
	l_user_set: STRING_GENERAL is				do Result := locale.translate ("user set") end
	l_use_inherited: STRING_GENERAL is do Result := locale.translate ("Use inherited value.")	end
	l_Value: STRING_GENERAL is					do Result := locale.translate("Value")	end
	l_When_breakpoint_is_hit: STRING_GENERAL is	do Result := locale.translate("When the breakpoint is hit:")	end
	l_Whole_project: STRING_GENERAL is			do Result := locale.translate("Whole project")	end
	l_Whole_word: STRING_GENERAL is				do Result := locale.translate("Whole word")	end
	l_Windows_only: STRING_GENERAL is			do Result := locale.translate("(Windows only)")	end
	l_Workbench_mode: STRING_GENERAL is 		do Result := locale.translate("Workbench mode")	end
	l_working_directory: STRING_GENERAL is 		do Result := locale.translate("Working directory")	end
	l_Working_formatter (a_command_name, a_object_name: STRING_GENERAL; a_for_class: BOOLEAN): STRING_GENERAL is
		require
			a_command_name_not_void: a_command_name /= Void
			a_object_name_not_voi: a_object_name /= Void
		do
			if a_for_class then
				Result := locale.format_string (locale.translate("Extracting $1 of class $2..."), [a_command_name, a_object_name])
			else
				Result := locale.format_string (locale.translate("Extracting $1 of feature `$2'..."), [a_command_name, a_object_name])
			end
		end

	l_Header_class (a_command_name, a_class_name: STRING_GENERAL): STRING_GENERAL is
		require
			a_command_name_not_void: a_command_name /= Void
			a_class_name_not_void: a_class_name /= Void
		do
			Result := locale.format_string (locale.translate ("$1 of class $2"), [a_command_name, a_class_name])
		end

	l_Header_feature (a_command_name, a_feat_name, a_class_name: STRING_GENERAL): STRING_GENERAL is
		require
			a_command_name_not_void: a_command_name /= Void
			a_feat_name_not_void: a_feat_name /= Void
			a_class_name_not_void: a_class_name /= Void
		do
			Result := locale.format_string (locale.translate ("$1 of feature `$2' of class $3"), [a_command_name, a_feat_name, a_class_name])
		end

	l_Header_dependency (a_command_name, a_object_name: STRING_GENERAL): STRING_GENERAL is
		require
			a_command_name_not_void: a_command_name /= Void
			a_object_name: a_object_name /= Void
		do
			Result := locale.format_string (locale.translate ("$1 of $2"), [a_command_name, a_object_name])
		end

	l_history_discarded_string: STRING_GENERAL is do Result := locale.translate ("--- History discarded ---") end

	l_item_is_attached_to (a_title, a_name: STRING_GENERAL): STRING_GENERAL is
		require
			a_title_not_void: a_title /= Void
			a_name_not_void: a_name /= Void
		do
			Result := locale.format_string (locale.translate ("Item [$1] is attached to %"$2%""), [a_title, a_name])
		end

	l_move_to (a_title, a_name: STRING_GENERAL): STRING_GENERAL is
		require
			a_title_not_void: a_title /= Void
			a_name_not_void: a_name /= Void
		do
			Result := locale.format_string (locale.translate ("Move [$1] to %"$2%""), [a_title, a_name])
		end

	l_from_class (a_class: STRING_GENERAL): STRING_GENERAL is
		require
			a_class_not_void: a_class /= Void
		do
			Result := locale.format_string (locale.translate (" (from $1)"), [a_class])
		end

	l_module_is (a_module: STRING_GENERAL): STRING_GENERAL is
		require
			a_module_not_void: a_module /= Void
		do
			Result := locale.format_string (locale.translate ("%N   + Module = $1"), [a_module])
		end

	l_break_index_is (a_index: STRING_GENERAL): STRING_GENERAL is
		require
			a_index_not_void: a_index /= Void
		do
			Result := locale.format_string (locale.translate ("%N   + break index = $1"), [a_index])
		end

	l_address_is (a_address: STRING_GENERAL): STRING_GENERAL is
		require
			a_address_not_void: a_address /= Void
		do
			Result := locale.format_string (locale.translate ("%N   + address     = <$1>"), [a_address])
		end

	l_context_is (a_context: STRING_GENERAL): STRING_GENERAL is
		require
			a_context_not_void: a_context /= Void
		do
			Result := locale.format_string (locale.translate ("%NCONTEXT: $1%N"), [a_context])
		end

	l_not_eiffel_class_file (a_stone_signature, a_file_name: STRING_GENERAL): STRING_GENERAL is
		require
			a_stone_signature_not_void: a_stone_signature /= Void
			a_file_name_not_void: a_file_name /= Void
		do
			Result := locale.format_string (locale.translate ("$1(not an Eiffel class file)   located in $2"), [a_stone_signature, a_file_name])
		end

	l_classi_header (a_sig, a_group_name, a_file_name: STRING_GENERAL): STRING_GENERAL is
		require
			a_sig_not_void: a_sig /= Void
			a_group_name_not_void: a_group_name /= Void
			a_file_name_not_void: a_file_name /= Void
		do
			Result := locale.format_string (locale.translate ("$1  in cluster $2  (not in system)  located in $3"), [a_sig, a_group_name, a_file_name])
		end

	l_classc_header (a_sig, a_group_name, a_file_name: STRING_GENERAL): STRING_GENERAL is
		require
			a_sig_not_void: a_sig /= Void
			a_group_name_not_void: a_group_name /= Void
			a_file_name_not_void: a_file_name /= Void
		do
			Result := locale.format_string (locale.translate ("$1  in cluster $2  located in $3"), [a_sig, a_group_name, a_file_name])
		end

	l_classc_header_precompiled (a_sig, a_group_name: STRING_GENERAL): STRING_GENERAL is
		require
			a_sig_not_void: a_sig /= Void
			a_group_name_not_void: a_group_name /= Void
		do
			Result := locale.format_string (locale.translate ("$1  in cluster $2  (precompiled)"), [a_sig, a_group_name])
		end

	l_located_in (a_s: STRING_GENERAL): STRING_GENERAL is
		require
			a_s_not_void: a_s /= Void
		do
			Result := locale.format_string (locale.translate (" (located in $1)"), [a_s])
		end

	l_replace_report (a_item_num, a_class_num: INTEGER): STRING_GENERAL is
		do
			Result := locale.format_string (locale.translate_plural ("   $1 replaced in $2 class", "   $1 replaced in $2 classes", a_class_num), [a_item_num, a_class_num])
		end

	l_from (a_str1, a_str2: STRING_GENERAL): STRING_GENERAL is
		require
			a_str1_not_void: a_str1 /= Void
			a_str2_not_void: a_str2 /= Void
		do
			Result := locale.format_string (locale.translate ("$1 from $2"), [a_str1, a_str2])
		end

	l_object_name: STRING_GENERAL is do Result := locale.translate ("OBJECT NAME: ") end
	l_compilation_equal_melted: STRING_GENERAL is do Result := locale.translate ("%N   + compilation = melted") end
	l_compilation_was_not_successful: STRING_GENERAL is do Result := locale.translate ("Compilation was not successful.") end
	l_expression_capital: STRING_GENERAL is do Result := locale.translate ("EXPRESSION: ") end
	l_disabled: STRING_GENERAL is do Result := locale.translate ("Disabled") end
	l_updating (a_class: STRING_GENERAL): STRING_GENERAL is
		require
			a_class_not_void: a_class /= Void
		do
			Result := locale.format_string (locale.translate ("Updating $1"), [a_class])
		end

	l_update_the_view: STRING_GENERAL is do Result := locale.translate ("Updating the view ...") end
	l_unevaluated: STRING_GENERAL is do Result := locale.translate ("Unevaluated") end
	l_error_occurred: STRING_GENERAL is do Result := locale.translate ("ERROR OCCURRED: %N") end
	l_error_occurred_click: STRING_GENERAL is do Result := locale.translate ("Error occurred (double click to see details)") end
	l_error_with_line (a_name: STRING_GENERAL; a_line: STRING_GENERAL): STRING_GENERAL is
		do
			Result := locale.format_string (locale.translate ("Error with $1 line $2"), [a_name, a_line])
		end

	l_exception_object: STRING_GENERAL is do Result := locale.translate ("Exception object") end
	l_exclude_colon: STRING_GENERAL is	do Result := locale.translate("Exclude:")	end
	l_type_capital: STRING_GENERAL is do Result := locale.translate ("TYPE: ") end
	l_value_capital: STRING_GENERAL is do Result := locale.translate ("VALUE: ") end
	l_precompiled: STRING_GENERAL is do Result := locale.translate ("  (precompiled)") end
	l_Tab_external_output: STRING_GENERAL is    do Result := locale.translate("External Output")	end
	l_Tab_C_output: STRING_GENERAL is    		do Result := locale.translate("C Output")	end
	l_Tab_warning_output: STRING_GENERAL is    	do Result := locale.translate("Warnings")	end
	l_Tab_error_output: STRING_GENERAL is    	do Result := locale.translate("Errors")	end
	l_show_feature_from_any: STRING_GENERAL is  do Result := locale.translate("Features from ANY")	end
	l_show_tooltip: STRING_GENERAL is do Result := locale.translate("Tooltip")	end
	h_show_feature_from_any: STRING_GENERAL is  do Result := locale.translate("Show unchanged features from class ANY?")	end
	h_show_tooltip: STRING_GENERAL is do Result := locale.translate("Show tooltips?")	end
	h_show_item_location: STRING_GENERAL is do Result := locale.translate("Show class location?")	end
	l_class_browser_classes: STRING_GENERAL is do Result := locale.translate("Class")	end
	l_class_browser_Path: STRING_GENERAL is do Result := locale.translate("Path")	end
	l_class_browser_features: STRING_GENERAL is do Result := locale.translate("Feature")	end
	l_version_from: STRING_GENERAL is do Result := locale.translate("Declared in class")	end
	l_version_in (a_class: STRING_GENERAL): STRING_GENERAL is do Result := locale.format_string (locale.translate("Version from class $1"), [a_class])	end
	l_branch (a_bra: INTEGER): STRING_GENERAL is do Result := locale.format_string (locale.translate("Branch #$1"), [a_bra.out]) end
	l_version_from_message: STRING is " (version from)"
	l_expand_layer: STRING_GENERAL is do Result := locale.translate("Expand selected level(s)")	end
	l_collapse_layer: STRING_GENERAL is do Result := locale.translate("Collapse selected level(s)")	end
	l_collapse_all_layers: STRING_GENERAL is do Result := locale.translate("Collapse all selected level(s)")	end
	l_searching_selected_file: STRING_GENERAL is do Result := locale.translate("Searching selected file...")	end
	l_selected_file_not_found: STRING_GENERAL is do Result := locale.translate("Selected text is not a valid file name or the file cannot be found")	end
	l_select_cluster_to_display: STRING_GENERAL is do Result := locale.translate("Select a cluster to display available views")	end
	l_select_cluster_to_generate: STRING_GENERAL is do Result := locale.translate("Select clusters to generate documentation for")	end
	l_select_diagrams_to_generate: STRING_GENERAL is do Result := locale.translate("Select the diagrams to generate")	end
	l_select_directory_to_generate: STRING_GENERAL is do Result := locale.translate("Select directory to generate the documentation in")	end
	l_select_feature_type: STRING_GENERAL is do Result := locale.translate("Select feature type")	end
	l_select_format_for_output: STRING_GENERAL is do Result := locale.translate("Select format for output")	end
	l_select_format_to_use: STRING_GENERAL is do Result := locale.translate("Select the formats to use")	end
	l_select_indexing_to_generate: STRING_GENERAL is do Result := locale.translate("Select indexing items to include in HTML meta tags")	end
	l_select_the_view: STRING_GENERAL is do Result := locale.translate("Select the view you want to use")	end
	l_select_another_view: STRING_GENERAL is do Result := locale.translate("Select another view if you want to save current placement.")	end
	l_stiffness: STRING_GENERAL is do Result := locale.translate("Stiffness:")	end
	l_wrap: STRING_GENERAL is do Result := locale.translate("wrap")	end
	l_manage_external_commands: STRING_GENERAL is do Result := locale.translate("Add, remove or edit external commands")	end
	l_module: STRING_GENERAL is do Result := locale.translate ("Module") end
	l_callees: STRING_GENERAL is do Result := locale.translate("callees")	end
	l_assignees: STRING_GENERAL is do Result := locale.translate("assignees")	end
	l_created: STRING_GENERAL is do Result := locale.translate("creations")	end
	l_filter: STRING_GENERAL is do Result := locale.translate("Filter: ")	end
	l_function: STRING_GENERAL is do Result := locale.translate("Function")	end
	l_view: STRING_GENERAL is do Result := locale.translate ("View ") end
	l_zoom: STRING_GENERAL is do Result := locale.translate ("Zoom ") end
	l_viewpoints: STRING_GENERAL is do Result := locale.translate("Viewpoints: ")	end
	l_Tab_metrics: STRING_GENERAL is do Result := locale.translate("Metric")	end
	l_callers_from_client_class: STRING_GENERAL is do Result := locale.translate("Callers from client class") end
	l_callees_from_supplier_class: STRING_GENERAL is do Result := locale.translate("Callees from supplier class") end
	l_from_x: STRING is "From "
	h_categorize_folder: STRING_GENERAL is do Result := locale.translate("Categorize classes in folder?") end
	h_show_syntactical_classes: STRING_GENERAL is do Result := locale.translate("Show only synctactically referenced classes?") end
	h_show_normal_referenced_classes: STRING_GENERAL is do Result := locale.translate("Show normal referenced classes?") end
	h_show_ancestor_classes: STRING_GENERAL is do Result := locale.translate("Show ancestor classes?") end
	h_show_descendant_classes: STRING_GENERAL is do Result := locale.translate("Show descendant classes?") end
	l_only_syntactically_related: STRING is "Only syntactically related"
	l_ancestor_related: STRING is "Ancestor related"
	l_descendant_related: STRING is "Descendant related"
	l_invalid_item: STRING is "Invalid item"
	l_application_target: STRING is "Application target"
	l_delayed_item: STRING is "Delayed item"
	l_ellipsis: STRING is "..."
	l_ancestor_of: STRING is "Ancestor of "
	l_descendant_of: STRING is "Descendant of "
	l_syntactical_supplier_of: STRING is "Syntactical supplier of "
	l_syntactical_client_of: STRING is "Syntactical client of "

	l_Tab_dependency_info: STRING_GENERAL is do Result := locale.translate("Dependency")	end
	l_client_class: STRING_GENERAL is do Result := locale.translate("Client class")	end
	l_supplier_class: STRING_GENERAL is do Result := locale.translate("Supplier class")	end
	l_client_group: STRING_GENERAL is do Result := locale.translate("Client group")	end
	l_supplier_group: STRING_GENERAL is do Result := locale.translate("Supplier group")	end
	h_show_dependency_on_self: STRING_GENERAL is do Result := locale.translate("Show dependency on self?")	end
	l_of: STRING_GENERAL is do Result := locale.translate(" of ")	end
	l_offset_is (a_offset: STRING_GENERAL): STRING_GENERAL is
		require
			a_offset_not_void: a_offset /= Void
		do
			Result := locale.format_string (locale.translate ("offset $1"), [a_offset])
		end

	l_hit_count_is (a_hit_count: INTEGER): STRING_GENERAL is
		do
			Result := locale.format_string (locale.translate_plural ("$1 hit", "$1 hits", a_hit_count), [a_hit_count])
		end

	l_info_cannot_be_retrieved: STRING_GENERAL is do Result := locale.translate("Information cannot be retrieved.")	end
	l_feature_in_client_class: STRING_GENERAL is do Result := locale.translate("Feature in client class")	end
	l_feature_in_supplier_class: STRING_GENERAL is do Result := locale.translate("Feature in supplier class")	end
	l_select_element_to_show_info: STRING_GENERAL is do Result := locale.translate("Select a target/group/folder/class to show information about it.")	end
	l_location: STRING_GENERAL is do Result := locale.translate("Location")	end

	l_file_exits (s: STRING_GENERAL): STRING_GENERAL is
		require
			s_not_void: s /= Void
		do
			Result := locale.format_string (locale.translate ("File $1 already exists,%N Do you want to ?"), [s])
		end

	l_target_domain_item: STRING_GENERAL is do Result := locale.translate ("target item") end
	l_group_domain_item: STRING_GENERAL is do Result := locale.translate ("group item") end
	l_folder_domain_item: STRING_GENERAL is do Result := locale.translate ("folder item") end
	l_class_domain_item: STRING_GENERAL is do Result := locale.translate ("class item") end
	l_feature_domain_item: STRING_GENERAL is do Result := locale.translate ("feature item") end
	l_delayed_domain_item: STRING_GENERAL is do Result := locale.translate ("delayed item") end

	h_search_for_class_recursively: STRING_GENERAL is do Result := locale.translate ("Search folder for classes recursively?") end
	l_save_layout_name: STRING_GENERAL is do Result := locale.translate ("Enter or select a name to save the current layout as.") end
	l_layout_name: STRING_GENERAL is do Result := locale.translate ("Name:") end
	l_existing_layout_names: STRING_GENERAL is do Result := locale.translate ("Existing Layouts:") end
	l_overwrite_layout (a_name: STRING_GENERAL): STRING_GENERAL is do Result := locale.format_string (locale.translate ("A layout with the name '$1' already exists. Do you want to overwrite?"), [a_name]) end
	l_open_layout_error: STRING_GENERAL is do Result := locale.translate ("Open layout error. Opening default layout instead.") end
	h_click_to_open: STRING_GENERAL is do Result := locale.translate ("Click to open") end

feature -- Label text, no translation (for the editor)

	le_version_from_message: STRING is " (version from)"
	le_Not_yet_called: STRING is			"Not yet called"
	le_branch (a_bra: INTEGER): STRING is do Result := "Branch #" + a_bra.out end
	le_Location_colon: STRING is 				"Location: "
	le_Stop_point_reached: STRING is		"Breakpoint reached"
	le_Execution_interrupted: STRING is	"Execution interrupted"
	le_Explicit_exception_pending: STRING is "Explicit exception pending"
	le_Implicit_exception_pending: STRING is "Implicit exception pending"
	le_New_breakpoint: STRING is			"New breakpoint(s) to commit"
	le_Stepped: STRING is				"Step completed"
	le_Unknown_status: STRING is			"Unknown application status"

feature -- Stone names

	s_Class_stone: STRING_GENERAL is			do Result := locale.translate("Class ")	end
	s_Cluster_stone: STRING_GENERAL is			do Result := locale.translate("Cluster ")	end
	s_Feature_stone: STRING_GENERAL is			do Result := locale.translate("Feature ")	end
	s_Assembly_stone: STRING_GENERAL is			do Result := locale.translate("Assembly ")	end
	s_folder_stone: STRING_GENERAL is			do Result := locale.translate("Folder ")	end
	s_library_stone: STRING_GENERAL is			do Result := locale.translate("Library ")	end
	s_target_stone: STRING_GENERAL is 			do Result := locale.translate("Target ")	end


feature -- Title part

	t_About: STRING_GENERAL is
		once
			Result := locale.format_string (locale.translate ("About $1"), [workbench_name])
		end
	t_Add_search_scope: STRING_GENERAL is				do Result := locale.translate("Add Search Scope")	end
	t_Alias: STRING_GENERAL is							do Result := locale.translate("Alias")	end
	t_Calling_convention: STRING_GENERAL is				do Result := locale.translate("Calling Convention")	end
	t_Choose_class: STRING_GENERAL is					do Result := locale.translate("Choose a Class")	end
	t_Choose_directory: STRING_GENERAL is 				do Result := locale.translate("Choose Your Directory")	end
	t_Choose_folder_name: STRING_GENERAL is				do Result := locale.translate("Choose a Folder Name")	end
	t_choose_name_for_new_configuration_file: STRING_GENERAL is do Result := locale.translate ("Choose name for new configuration file") end
	t_Choose_project_and_directory: STRING_GENERAL is 	do Result := locale.translate("Choose Your Project Name and Directory")	end
	t_Class: STRING_GENERAL is							do Result := locale.translate("Class")	end
	t_Clients_of: STRING_GENERAL is						do Result := locale.translate("Clients of Class ")	end
	t_Creation_routine: STRING_GENERAL is				do Result := locale.translate("Creation Procedure")	end
	t_configuration_loading_error: STRING_GENERAL is	do Result := locale.translate("Configuration Loading Error")	end
	t_configuration_loading_message: STRING_GENERAL is	do Result := locale.translate("Configuration Loading Message")	end
	t_confirmation: STRING_GENERAL is					do Result := locale.translate ("Confirmation") end
	t_Customize_toolbar_text: STRING_GENERAL is 		do Result := locale.translate("Customize Toolbar")	end
	t_Default_print_job_name: STRING_GENERAL is
		once
			Result := locale.format_string (locale.translate("From $1"), [Workbench_name])
		end
	t_Deleting_files: STRING_GENERAL is					do Result := locale.translate("Deleting Files")	end
	t_Dummy: STRING_GENERAL is							do Result := locale.translate("Dummy")	end
	t_Dynamic_lib_window: STRING_GENERAL is 			do Result := locale.translate("Dynamic Library Builder")	end
	t_Dynamic_type: STRING_GENERAL is					do Result := locale.translate("In Class")	end
	t_Enter_condition: STRING_GENERAL is				do Result := locale.translate("Enter Condition")	end
	t_error: STRING_GENERAL is 							do Result := locale.translate ("Error") end
	t_Exported_feature: STRING_GENERAL is				do Result := locale.translate("Feature")	end
	t_Expression_evaluation: STRING_GENERAL is			do Result := locale.translate("Evaluation")	end
	t_Extended_explanation: STRING_GENERAL is			do Result := locale.translate("Compilation Error Wizard")	end
	t_external_command: STRING_GENERAL is				do Result := locale.translate("External Command")	end
	t_external_commands: STRING_GENERAL is				do Result := locale.translate("External Commands")	end
	t_External_edition: STRING_GENERAL is				do Result := locale.translate("External Edition")	end
	t_Feature: STRING_GENERAL is						do Result := locale.translate("In Feature")	end
	t_Feature_properties: STRING_GENERAL is				do Result := locale.translate("Feature Properties")	end
	t_File_selection: STRING_GENERAL is					do Result := locale.translate("File Selection")	end
	t_Find: STRING_GENERAL is							do Result := locale.translate("Find: ")	end
	t_finish_freezing_status: STRING_GENERAL is			do Result := locale.translate("Finish Freezing Status")	end
	t_Index: STRING_GENERAL is							do Result := locale.translate("Index")	end
	t_New_class: STRING_GENERAL is						do Result := locale.translate("New Class")	end
	t_New_cluster: STRING_GENERAL is					do Result := locale.translate("Add Cluster")	end
	t_New_expression: STRING_GENERAL is					do Result := locale.translate("New Expression")	end
	t_New_project: STRING_GENERAL is					do Result := locale.translate("New Project")	end
	t_Open_backup: STRING_GENERAL is					do Result := locale.translate("Backup Found")	end
	t_Organize_favorites: STRING_GENERAL is				do Result := locale.translate("Organize Favorites")	end
	t_Profile_query_window: STRING_GENERAL is			do Result := locale.translate("Profile Query Window")	end
	t_Profiler_wizard: STRING_GENERAL is				do Result := locale.translate("Profiler Wizard")	end
	t_Project: STRING is
		once
			Result := Workbench_name
		end
	t_project_documentation: STRING_GENERAL is				do Result := locale.translate("Project documentation")	end
	t_Preference_window: STRING_GENERAL is				do Result := locale.translate("Preferences")	end
	t_save_backup: STRING_GENERAL is					do Result := locale.translate ("Save Backup") end
	t_Select_class: STRING_GENERAL is					do Result := locale.translate("Select Class")	end
	t_Select_cluster: STRING_GENERAL is					do Result := locale.translate("Select Cluster")	end
	t_Select_feature: STRING_GENERAL is					do Result := locale.translate("Select Feature")	end
	t_Select_a_file: STRING_GENERAL is					do Result := locale.translate("Select a File")	end
	t_Select_a_directory: STRING_GENERAL is				do Result := locale.translate("Select a Directory")	end
	t_Set_stack_depth: STRING_GENERAL is				do Result := locale.translate("Maximum Call Stack Depth")	end
	t_Set_critical_stack_depth: STRING_GENERAL is		do Result := locale.translate("Overflow Prevention")	end
	t_Static_type: STRING_GENERAL is					do Result := locale.translate("From Class")	end
	t_Starting_dialog: STRING is
		once
			Result := Workbench_name
		end
	t_precompile_progress: STRING_GENERAL is 			do Result := locale.translate ("Precompilation Progress") end
	t_Slice_limits: STRING_GENERAL is					do Result := locale.translate("Choose New Slice Limits for Special Objects")	end
	t_System: STRING_GENERAL is							do Result := locale.translate("Project Settings")	end
	t_target_selection: STRING_GENERAL is 				do Result := locale.translate ("Target Selection") end
	t_Empty_development_window: STRING_GENERAL is 		do Result := locale.translate("Empty Development Tool")	end
	t_Autocomplete_window: STRING_GENERAL is			do Result := locale.translate("Auto-Complete")	end
	t_Diagram_class_header: STRING_GENERAL is			do Result := locale.translate("Class Header")	end
	t_Diagram_set_center_class: STRING_GENERAL is		do Result := locale.translate("Set Center Class")	end
	t_Diagram_context_depth: STRING_GENERAL is			do Result := locale.translate("Select Depths")	end
	t_Diagram_link_tool: STRING_GENERAL is				do Result := locale.translate("Link Tool")	end
	t_Diagram_delete_client_link: STRING_GENERAL is 	do Result := locale.translate("Choose Feature(s) to Delete")	end
	t_Diagram_history_tool: STRING_GENERAL is			do Result := locale.translate("History Tool")	end

	t_Diagram_move_class_cmd (a_name: STRING_GENERAL): STRING_GENERAL is
		require
			exists: a_name /= Void
		do
			Result := locale.format_string(locale.translate("Move Class '$1'"), [a_name])
		end

	t_Diagram_move_cluster_cmd (a_name: STRING_GENERAL): STRING_GENERAL is
		require
			exists: a_name /= Void
		do
			Result := locale.format_string(locale.translate("Move Cluster '$1'"),[a_name])
		end

	t_Diagram_move_midpoint_cmd: STRING_GENERAL is		do Result := locale.translate("Move Midpoint")	end

	t_Diagram_add_cs_link_cmd (client_name, supplier_name: STRING_GENERAL): STRING_GENERAL is
		require
			exists: client_name /= Void	and supplier_name /= Void
		do
			Result := locale.format_string(locale.translate("Add Client-Supplier Relation Between '$1' and '$2'"), [client_name, supplier_name])
		end

	t_Diagram_add_inh_link_cmd (ancestor_name, descendant_name: STRING_GENERAL): STRING_GENERAL is
		require
			exists: ancestor_name /= Void and descendant_name /= Void
		do
			Result := locale.format_string(locale.translate("Add Inheritance Relation Between '$1' and '$2'"), [ancestor_name, descendant_name])
		end

	t_Diagram_include_class_cmd (a_name: STRING_GENERAL): STRING_GENERAL is
		require
			exists: a_name /= Void
		do
			Result := locale.format_string(locale.translate("Include Class '$1'"), [a_name])
		end

	t_Diagram_include_cluster_cmd (a_name: STRING_GENERAL): STRING_GENERAL is
		require
			exists: a_name /= Void
		do
			Result := locale.format_string(locale.translate("Include Cluster '$1'"), [a_name])
		end

	t_Diagram_include_library_cmd (a_name: STRING_GENERAL): STRING_GENERAL is
		require
			exists: a_name /= Void
		do
			Result := locale.format_string(locale.translate("Include Library '$1'"),[a_name])
		end

	t_Diagram_insert_midpoint_cmd: STRING_GENERAL is	do Result := locale.translate("Insert Midpoint")	end
	t_Diagram_change_color_cmd: STRING_GENERAL is		do Result := locale.translate("Change Class Color")	end

	t_Diagram_rename_class_locally_cmd (old_name, new_name: STRING_GENERAL): STRING_GENERAL is
		require
			exists: old_name /= Void and new_name /= Void
		do
			Result := locale.format_string(locale.translate("Rename Class '$1' Locally to '$2'"), [old_name,new_name])
		end

	t_Diagram_rename_class_globally_cmd (old_name, new_name: STRING_GENERAL): STRING_GENERAL is
		require
			exists: old_name /= Void and new_name /= Void
		do
			Result := locale.format_string(locale.translate("Rename Class '$1' Globally to '$2'"), [old_name, new_name])
		end

	t_Diagram_delete_client_link_cmd (a_name: STRING_GENERAL): STRING_GENERAL is
		require
			exists: a_name /= Void
		do
			Result := locale.format_string(locale.translate("Delete Client Link '$1'") , [a_name])
		end

	t_Diagram_delete_inheritance_link_cmd (an_ancestor, a_descendant: STRING_GENERAL): STRING_GENERAL is
		require
			exists: an_ancestor /= Void and a_descendant /= Void
		do
			Result := locale.format_string(locale.translate("Delete Inheritance Link Between '$1' and '$2'"), [an_ancestor,a_descendant])
		end

	t_Diagram_erase_cluster_cmd (a_name: STRING_GENERAL): STRING_GENERAL is
		require
			exists: a_name /= Void
		do
			Result := locale.format_string(locale.translate("Erase Cluster '$1'"), [a_name])
		end

	t_Diagram_delete_midpoint_cmd: STRING_GENERAL is	do Result := locale.translate("Erase Midpoint")	end

	t_Diagram_erase_class_cmd (a_name: STRING_GENERAL): STRING_GENERAL is
		require
			exists: a_name /= Void
		do
			Result := locale.format_string(locale.translate("Erase Class '$1'"), [a_name])
		end

	t_Diagram_erase_classes_cmd: STRING_GENERAL is		do Result := locale.translate("Erase Classes")	end
	t_Diagram_put_right_angles_cmd: STRING_GENERAL is	do Result := locale.translate("Put Right Angles")	end
	t_Diagram_remove_right_angles_cmd: STRING_GENERAL is	do Result := locale.translate("Remove Right Angles")	end
	t_Diagram_put_one_handle_left_cmd: STRING_GENERAL is	do Result := locale.translate("Put Handle Left")	end
	t_Diagram_put_one_handle_right_cmd: STRING_GENERAL is	do Result := locale.translate("Put Handle Right")	end
	t_Diagram_put_two_handles_left_cmd: STRING_GENERAL is	do Result := locale.translate("Put Two Handles Left")	end
	t_Diagram_put_two_handles_right_cmd: STRING_GENERAL is	do Result := locale.translate("Put Two Handles Right")	end
	t_Diagram_remove_handles_cmd: STRING_GENERAL is		do Result := locale.translate("Remove Handles")	end
	t_Diagram_zoom_in_cmd: STRING_GENERAL is			do Result := locale.translate("Zoom In")	end
	t_Diagram_zoom_out_cmd: STRING_GENERAL is			do Result := locale.translate("Zoom Out")	end
	t_Diagram_zoom_cmd: STRING_GENERAL is				do Result := locale.translate("Zoom")	end

	t_Diagram_cluster_expand (a_name: STRING_GENERAL): STRING_GENERAL is
		require
			exists: a_name /= Void
		do
			Result := locale.format_string(locale.translate("Expand cluster '$1'"), [ a_name])
		end

	t_Diagram_cluster_collapse (a_name: STRING_GENERAL): STRING_GENERAL is
		require
			exists: a_name /= Void
		do
			Result := locale.format_string(locale.translate("Collapse Cluster '$1'"), [a_name])
		end

	t_Diagram_disable_high_quality: STRING_GENERAL is	do Result := locale.translate("Disable High Quality")	end
	t_Diagram_enable_high_quality: STRING_GENERAL is	do Result := locale.translate("Enable High Quality")	end

	t_first_match_reached: STRING_GENERAL is	do Result := locale.translate("Initial match reached.")	end
	t_finish_freezing_launch_error: STRING_GENERAL is 	do Result := locale.translate("finish_freezing Launch Error")	end
	t_bottom_reached: STRING_GENERAL is 	do Result := locale.translate("Bottom reached.")	end
	t_refactoring_feature_rename: STRING_GENERAL is	do Result := locale.translate("Refactoring: Feature Rename (Compiled Classes)")	end
	t_refactoring_class_select: STRING_GENERAL is do Result := locale.translate("Select Class")	end
	t_refactoring_class_rename: STRING_GENERAL is do Result := locale.translate("Refactoring: Class Rename")	end
	t_select_working_directory: STRING_GENERAL is do Result := locale.translate("Select working directory")	end

	t_Breakpoints_tool: STRING_GENERAL is				do Result := locale.translate ("Breakpoints")	end
	t_Call_stack_tool: STRING_GENERAL is				do Result := locale.translate ("Call Stack")	end
	t_Cluster_tool: STRING_GENERAL is					do Result := locale.translate ("Clusters")	end
	t_Context_tool: STRING_GENERAL is					do Result := locale.translate ("Context")	end
	t_Favorites_tool: STRING_GENERAL is					do Result := locale.translate ("Favorites")	end
	t_metric_tool: STRING_GENERAL is 					do Result := locale.translate ("Metrics")	end
	t_Object_tool: STRING_GENERAL is					do Result := locale.translate ("Objects")	end
	t_threads_tool: STRING_GENERAL is					do Result := locale.translate ("Threads")	end
	t_Properties_tool: STRING_GENERAL is				do Result := locale.translate ("Properties")	end
	t_question: STRING_GENERAL is 						do Result := locale.translate ("Question") end
	t_Search_tool: STRING_GENERAL is					do Result := locale.translate ("Search")	end
	t_Search_Report_tool: STRING_GENERAL is				do Result := locale.translate ("Search Report")	end
	t_Windows_tool: STRING_GENERAL is					do Result := locale.translate ("Windows")	end
	t_Watch_tool: STRING_GENERAL is						do Result := locale.translate ("Watch")	end
	t_watch_tool_error_message: STRING_GENERAL is		do Result := locale.translate ("Watch tool :: error message")	end
	t_warning: STRING_GENERAL is 						do Result := locale.translate ("Warning") end
	t_Features_tool: STRING_GENERAL is					do Result := locale.translate ("Features")	end
	t_Editor: STRING_GENERAL is							do Result := locale.translate("Editor")	end
	t_Debugging_options: STRING_GENERAL is					do Result := locale.translate("Debugging Options")	end
	t_Debugging_tool: STRING_GENERAL is					do Result := locale.translate("Debugging")	end

	t_Standard_toolbar: STRING_GENERAL is				do Result := locale.translate ("Standard Buttons") end
	t_Address_toolbar: STRING_GENERAL is				do Result := locale.translate ("Address Bar") end
	t_physics_setting: STRING_GENERAL is				do Result := locale.translate ("Physics settings") end
	t_Project_toolbar: STRING_GENERAL is				do Result := locale.translate ("Project Bar") end
	t_Refactory_toolbar: STRING_GENERAL is				do Result := locale.translate ("Refactoring Bar") end

	t_dialog_title (a_name: STRING_GENERAL): STRING_GENERAL is
		do
			Result := locale.format_string (locale.translate ("Edit $1"), [a_name])
		end

	t_Save_layout_as: STRING_GENERAL is 				do Result := locale.translate ("Save Layout As...") end
	t_Open_layout: STRING_GENERAL is					do Result := locale.translate ("Open Layout") end
	t_Overwite_layout: STRING_GENERAL is				do Result := locale.translate ("Overwrite Layout") end
	t_open_c_file: STRING_GENERAL is					do Result := locale.translate ("Open C file") end

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
	to_Features_tool: STRING is					"Features"
	to_Editor: STRING is						"Editor"
	to_Debugging_tool: STRING is				"Debugging"


	to_Output_tool: STRING is					"Output"
	to_Diagram_tool: STRING is					"Diagram"
	to_Class_tool: STRING is					"Class"
	to_Feature_relation_tool: STRING is			"Feature Relation"
	to_Dependency_tool: STRING is				"Dependency"
	to_Metric_tool: STRING is					"Metrics"
	to_External_Ouput_tool: STRING is			"External Output"
	to_C_Output_tool: STRING is					"C Output"
	to_Error_tool: STRING is					"Error"
	to_Warning_tool: STRING is					"Warning"

	to_name: STRING is 							"Name"
	to_expression: STRING is 					"Expression"
	to_value: STRING is							"Value"
	to_type: STRING is							"Type"
	to_address: STRING is						"Address"
	to_context: STRING is						"Context"
	to_context_dot: STRING is					"Context ..."

feature -- Description texts

	e_Add_exported_feature: STRING_GENERAL is	do Result := locale.translate("Add a new feature to this dynamic library definition")	end
	e_Bkpt_info: STRING_GENERAL is				do Result := locale.translate("Show/Hide information about breakpoints")	end
	e_Check_exports: STRING_GENERAL is			do Result := locale.translate("Check the validity of the library definition")	end
	e_Compilation_failed: STRING_GENERAL is		do Result := locale.translate("Eiffel Compilation Failed")	end
	e_Compilation_succeeded: STRING_GENERAL is	do Result := locale.translate("Eiffel Compilation Succeeded")	end
	e_freezing_failed: STRING_GENERAL is 		do Result := locale.translate("Background Workbench C Compilation Failed")	end
	e_finalizing_failed: STRING_GENERAL is		do Result := locale.translate("Background Finalized C compilation Failed")	end
	e_Force_debug_mode: STRING_GENERAL is		do Result := locale.translate("Force the environment to stay in debugger mode")	end
	e_freezing_launch_failed: STRING_GENERAL is 		do Result := locale.translate("Background Workbench C Compilation Launch Failed")	end
	e_finalizing_launch_failed: STRING_GENERAL is		do Result := locale.translate("Background Finalized C Compilation Launch Failed")	end
	e_freezing_launched: STRING_GENERAL is 		do Result := locale.translate("Background Workbench C Compilation Launched")	end
	e_finalizing_launched: STRING_GENERAL is 	do Result := locale.translate("Background Finalized C Compilation Launched")	end
	e_freezing_succeeded: STRING_GENERAL is 	do Result := locale.translate("Background Workbench C Compilation Succeeded")	end
	e_finalizing_succeeded: STRING_GENERAL is	do Result := locale.translate("Background Finalized C Compilation Succeeded")	end
	e_freezing_terminated: STRING_GENERAL is 	do Result := locale.translate("Background Workbench C Compilation Terminated")	end
	e_finalizing_terminated: STRING_GENERAL is 	do Result := locale.translate("Background Finalized C Compilation Terminated")	end
	e_C_compilation_failed: STRING_GENERAL is 	do Result := locale.translate("Background C Compilation Failed")	end
	e_C_compilation_launch_failed: STRING_GENERAL is do Result := locale.translate("Background C Compilation Launch Failed")	end
	e_C_compilation_terminated: STRING_GENERAL is do Result := locale.translate("Background C Compilation Terminated")	end
	e_C_compilication_launched: STRING_GENERAL is do Result := locale.translate("Background C Compilation Launched")	end
	e_C_compilation_succeeded: STRING_GENERAL is do Result := locale.translate("Background C Compilation Succeeded")	end
	e_C_compilation_running: STRING_GENERAL is  do Result := locale.translate("Background C Compilation in Progress")	end
	e_Compiling: STRING_GENERAL is				do Result := locale.translate("System is being compiled")	end
	e_Copy_call_stack_to_clipboard: STRING_GENERAL is do Result := locale.translate("Copy call stack to clipboard")	end
	e_Cursor_position: STRING_GENERAL is		do Result := locale.translate("Cursor position (line:column)")	end
	e_Diagram_hole: STRING_GENERAL is			do Result := locale.translate("Please drop a class or a cluster on this button %N%
										%to view its diagram.%N%
										%Use right click for both pick and drop actions.")	end
	e_Diagram_class_header: STRING_GENERAL is 	do Result := locale.translate("Please drop a class on this button.%NUse right click for both%N%
										%pick and drop actions.")	end
	e_Diagram_remove_anchor: STRING_GENERAL is	do Result := locale.translate("Please drop a class or a cluster with an%Nanchor on this button.%NUse right click for both%N%
										%pick and drop actions.")	end
	e_Diagram_create_class: STRING_GENERAL is	do Result := locale.translate("Please drop this button on the diagram.%N%
										%Use right click for both%Npick and drop actions.")	end
	e_Diagram_delete_figure: STRING_GENERAL is	do Result := locale.translate("Please drop a class, a cluster or a midpoint%N%
										%on this button. Use right click for both%Npick and drop actions.")	end
	e_Diagram_add_class_figure_relations: STRING_GENERAL is do Result := locale.translate("A class figure(s) must either be selected%N%
										%or dropped on this button via right clicking.")	end
	e_Diagram_delete_item: STRING_GENERAL is	do Result := locale.translate("Please drop a class, a cluster or a link%N%
										%on this button. Use right click for both%Npick and drop actions.")	end
	e_Display_error_help: STRING_GENERAL is		do Result := locale.translate("Give help on compilation errors")	end
	e_Display_system_info: STRING_GENERAL is	do Result := locale.translate("Display information concerning current system")	end
	e_Drop_an_error_stone: STRING is	do Result := locale.translate(ee_Drop_an_error_stone)	end
	e_Edit_exported_feature: STRING_GENERAL is	do Result := locale.translate("Edit the properties of the selected feature")	end
	e_Edit_expression: STRING_GENERAL is		do Result := locale.translate("Edit an expression")	end
	e_Edited: STRING_GENERAL is					do Result := locale.translate("Some classes were edited since last compilation")	end
	e_Exec_debug: STRING_GENERAL is				do Result := locale.translate("Start application and stop at breakpoints")	end
	e_Exec_kill: STRING_GENERAL is				do Result := locale.translate("Stop application")	end
	e_Exec_into: STRING_GENERAL is				do Result := locale.translate("Step into a routine")	end
	e_Exec_no_stop: STRING_GENERAL is			do Result := locale.translate("Start application without stopping at breakpoints")	end
	e_Exec_out: STRING_GENERAL is				do Result := locale.translate("Step out of a routine")	end
	e_Exec_step: STRING_GENERAL is				do Result := locale.translate("Execute the application one line at a time")	end
	e_Exec_stop: STRING_GENERAL is				do Result := locale.translate("Pause application at current point")	end
	e_History_back: STRING_GENERAL is			do Result := locale.translate("Back")	end
	e_History_forth: STRING_GENERAL is			do Result := locale.translate("Forward")	end
	e_Minimize_all: STRING_GENERAL is			do Result := locale.translate("Minimize all windows")	end
	e_New_context_tool: STRING_GENERAL is		do Result := locale.translate("Open a new context window")	end
	e_New_dynamic_lib_definition: STRING_GENERAL is	do Result := locale.translate("Create a new dynamic library definition")	end
	e_New_editor: STRING_GENERAL is				do Result := locale.translate("Open a new editor window")	end
	e_New_expression: STRING_GENERAL is			do Result := locale.translate("Create a new expression")	end
	e_Not_running: STRING_GENERAL is			do Result := locale.translate("Application is not running")	end
	e_Open_dynamic_lib_definition: STRING_GENERAL is do Result := locale.translate("Open a dynamic library definition")	end
	e_Open_file: STRING_GENERAL is				do Result := locale.translate("Open a file")	end
	e_Open_eac_browser: STRING_GENERAL is		do Result := locale.translate("Open the Eiffel Assembly Cache browser tool")	end
	e_Paste: STRING_GENERAL is					do Result := locale.translate("Paste")	end
	e_Paused: STRING_GENERAL is					do Result := locale.translate("Application is paused")	end
	e_Pretty_print: STRING_GENERAL is			do Result := locale.translate("Display an expanded view of objects")	end
	e_Print: STRING_GENERAL is					do Result := locale.translate("Print the currently edited text")	end
	e_Project_name: STRING_GENERAL is			do Result := locale.translate("Name of the current project")	end
	e_Project_settings: STRING_GENERAL is		do Result := locale.translate("Change project settings, right click to open external editor")	end
	e_override_scan: STRING_GENERAL is			do Result := locale.translate("Recompile override clusters")	end
	e_discover_melt: STRING_GENERAL is			do Result := locale.translate("Discover unreferenced externally added classes and recompile.")	end
	e_Raise_all: STRING_GENERAL is				do Result := locale.translate("Raise all windows")	end
	e_Raise_all_unsaved: STRING_GENERAL is		do Result := locale.translate("Raise all unsaved windows")	end
	e_Redo: STRING_GENERAL is					do Result := locale.translate("Redo")	end
	e_Remove_class_cluster: STRING_GENERAL is	do Result := locale.translate("Remove a class or a cluster from the system")	end
	e_Remove_exported_feature: STRING_GENERAL is	do Result := locale.translate("Remove the selected feature from this dynamic library definition")	end
	e_Remove_expressions: STRING_GENERAL is		do Result := locale.translate("Remove selected expressions")	end
	e_Remove_object: STRING_GENERAL is			do Result := locale.translate("Remove currently selected object")	end
	e_Running: STRING_GENERAL is				do Result := locale.translate("Application is running")	end
	e_Running_no_stop_points: STRING_GENERAL is	do Result := locale.translate("Application is running (ignoring breakpoints)")	end
	e_Save_call_stack: STRING_GENERAL is		do Result := locale.translate("Save call stack to a text file")	end
	e_Save_dynamic_lib_definition: STRING_GENERAL is do Result := locale.translate("Save this dynamic library definition")	end
	e_Show_class_cluster: STRING_GENERAL is		do Result := locale.translate("Locate currently edited class or cluster")	end
	e_Send_stone_to_context: STRING_GENERAL is	do Result := locale.translate("Synchronize context")	end
	e_description: STRING is do Result := "Separator" end
	e_Separate_stone: STRING_GENERAL is			do Result := locale.translate("Unlink the context tool from the other components")	end
	e_Set_stack_depth: STRING_GENERAL is		do Result := locale.translate("Set maximum call stack depth")	end
	e_Shell: STRING_GENERAL is					do Result := locale.translate("Send to external editor")	end
	e_Switch_num_format_to_hex: STRING_GENERAL is do Result := locale.translate("Switch to hexadecimal format")	end
	e_Switch_num_format_to_dec: STRING_GENERAL is do Result := locale.translate("Switch to decimal format")	end
	e_Switch_num_formating: STRING is "Hexadecimal/Decimal formating"
	e_Toggle_state_of_expressions: STRING_GENERAL is		do Result := locale.translate("Enable/Disable expressions")	end
	e_Toggle_stone_management: STRING_GENERAL is do Result := locale.translate("Link or not the context tool to other components")	end
	e_Undo: STRING_GENERAL is					do Result := locale.translate("Undo")	end
	e_Up_to_date: STRING_GENERAL is				do Result := locale.translate("Executable is up-to-date")	end
	e_Unify_stone: STRING_GENERAL is			do Result := locale.translate("Link the context tool to the other components")	end
	e_Terminate_c_compilation: STRING_GENERAL is do Result := locale.translate("Terminate current C compilation in progress")	end

	e_Dbg_exception_handler: STRING_GENERAL is do Result := locale.translate("Exception handling")	end
	e_Dbg_assertion_checking: STRING_GENERAL is do Result := locale.translate("Disable or restore Assertion checking handling during debugging")	end

	e_open_selection_in_editor: STRING_GENERAL is do Result := locale.translate("Open selected file name in specified external editor")	end
	e_save_c_compilation_output: STRING_GENERAL is do Result := locale.translate("Save C Compilation output to file")	end
	e_go_to_w_code_dir: STRING_GENERAL is do Result := locale.translate("Go to W_code directory of this system, or right click to open W_code in specified file browser")	end
	e_go_to_f_code_dir: STRING_GENERAL is do Result := locale.translate("Go to F_code directory of this system, or right click to open F_code in specified file browser")	end
	e_open_c_file: STRING_GENERAL is do Result := locale.translate ("Drop a class/feature here to open its corresponding C file/function in external editor.") end
	e_go_to_project_dir: STRING_GENERAL is do Result := locale.translate ("Go to project directory of this system, or right click to open that directory in specified file browser") end
	e_f_code: STRING_GENERAL is do Result := locale.translate("F_code")	end
	e_w_code: STRING_GENERAL is do Result := locale.translate("W_code")	end
	e_open_project: STRING_GENERAL is do Result := locale.translate ("Project") end
	e_no_text_is_selected: STRING_GENERAL is do Result := locale.translate("No file name is selected.")	end
	e_selected_text_is_not_file: STRING_GENERAL is do Result := locale.translate("Selected text is not a correct file name.")	end
	e_external_editor_not_defined: STRING_GENERAL is do Result := locale.translate("External editor not defined")	end
	e_external_command_is_running: STRING_GENERAL is do Result := locale.translate("An external command is running now. %NPlease wait until it exits.")	end
	e_external_command_list_full: STRING_GENERAL is do Result := locale.translate("Your external command list is full.%NUse Tools->External Command... to delete one.")	end
	e_working_directory_invalid: STRING_GENERAL is do Result := locale.translate("Cannot change to directory ")	end
	e_external_command_not_launched: STRING_GENERAL is do Result := locale.translate("External command not launched.")	end
	e_refactoring_undo_sure: STRING_GENERAL is do Result := locale.translate("Are you sure you want to undo the refactoring?%N If classes have been modified since the refactoring this can lead to corrupt classes and lost information!")	end
	e_refactoring_redo_sure: STRING_GENERAL is do Result := locale.translate("Are you sure you want to redo the refactoring?%N If classes have been modified since the undo of the refactoring this can lead to corrupt classes and lost information!")	end

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
feature -- Error

	err_error: STRING_GENERAL is do Result := locale.translate ("Error ") end

feature -- Wizard texts

	wt_Profiler_welcome: STRING_GENERAL is do Result := locale.translate("Welcome to the Profiler Wizard")	end
	wb_Profiler_welcome: STRING_GENERAL is
				do Result := locale.translate("Using this wizard you can analyze the result of a profiling.%N%
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

	wt_Compilation_mode: STRING_GENERAL is do Result := locale.translate("Compilation mode")	end
	ws_Compilation_mode: STRING_GENERAL is do Result := locale.translate("Select the Compilation mode.")	end

	wt_Execution_Profile: STRING_GENERAL is do Result := locale.translate("Execution Profile")	end
	ws_Execution_Profile: STRING_GENERAL is do Result := locale.translate("Reuse or Generate an Execution Profile.")	end
	wb_Execution_Profile: STRING_GENERAL is
			do Result := locale.translate("You can generate the Execution Profile from a Run-time Information Record%N%
			%created by a profiler, or you can reuse an existing Execution Profile if you%N%
			%have already generated one for this system.")	end

	wt_Execution_Profile_Generation: STRING_GENERAL is do Result := locale.translate("Execution Profile Generation")	end
	ws_Execution_Profile_Generation: STRING_GENERAL is do Result := locale.translate("Select a Run-time information record to generate the Execution profile")	end
	wb_Execution_Profile_Generation: STRING_GENERAL is
				do Result := locale.translate("Once an execution of an instrumented system has generated the proper file,%N%
				%you must process it through a profile converter to produce the Execution%N%
				%Profile. The need for the converter comes from the various formats that%N%
				%profilers use to record run-time information during an execution.%N%
				%%N%
				%Provide the Run-time information record produced by the profiler and%N%
				%select the profiler used to create this record.%
				%%N%
				%The Execution Profile will be generated under the file %"profinfo.pfi%".")	end

	wt_Switches_and_query: STRING_GENERAL is do Result := locale.translate("Switches and Query")	end
	ws_Switches_and_query: STRING_GENERAL is do Result := locale.translate("Select the information you need and formulate your query.")	end

	wt_Generation_error: STRING_GENERAL is do Result := locale.translate("Generation Error")	end
	wb_Click_back_and_correct_error: STRING_GENERAL is do Result := locale.translate("Click Back if you can correct the problem or Click Abort.")	end

	wt_Runtime_information_record_error: STRING_GENERAL is do Result := locale.translate("Runtime Information Record Error")	end
	wb_Runtime_information_record_error (generation_path: STRING_GENERAL): STRING_GENERAL is
		do
			Result := locale.format_string (locale.translate(
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

	wt_Execution_profile_error: STRING_GENERAL is do Result := locale.translate("Execution Profile Error")	end
	wb_Execution_profile_error: STRING_GENERAL is
				do Result := locale.translate("The file you have supplied as existring Execution Provide does%N%
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
			Result := locale.translate (a_string)
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


