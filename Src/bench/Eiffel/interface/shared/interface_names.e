indexing
	description:
		"Constants for command names, etc."
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

feature -- Button texts

	b_Abort: STRING is							"Abort"
	b_Add: STRING is 							"Add"
	b_Add_text: STRING is 						"Add ->"
	b_And: STRING is							"And"
	b_Apply: STRING is							"Apply"
	b_Browse: STRING is							"Browse..."
	b_Cancel: STRING is							"Cancel"
	b_C_functions: STRING is					"C Functions"
	b_Close: STRING is							"Close"
	b_Continue_anyway: STRING is				"Continue Anyway"
	b_Create: STRING is							"Create"
	b_Create_folder: STRING is					"Create Folder..."
	b_Delete_command: STRING is					"Delete"
	b_Descendant_time: STRING is				"Descendant Time"
	b_Discard_assertions: STRING is				"Discard Assertions"
	b_Display_Exception_Trace: STRING is		"Display Exception Trace"
	b_Down_text: STRING is 						"Down"
	b_Edit_ace: STRING is						"Edit"
	b_Edit_command: STRING is					"Edit..."
	b_Eiffel_features: STRING is				"Eiffel Features"
	b_Feature_name: STRING is					"Feature Name"
	b_Finish: STRING is							"Finish"
	b_Function_time: STRING is					"Function Time"
	b_Keep_assertions: STRING is				"Keep Assertions"
	b_Load_ace: STRING is						"Load From..."
	b_Move_to_folder: STRING is					"Move to Folder..."
	b_New_ace: STRING is						"Reset"
	b_New_command: STRING is					"Add..."
	b_New_favorite_class: STRING is				"New Favorite Class..."
	b_Next: STRING is							"Next"
	b_Number_of_calls: STRING is				"Number of Calls"
	b_Ok: STRING is								"OK"
	b_Open_original: STRING is					"Open Original File"
	b_Open_backup: STRING is					"Open Backup File"
	b_Or: STRING is								"Or"
	b_Percentage: STRING is						"Percentage"
	b_Replace: STRING is						"Replace"
	b_Replace_all: STRING is					"Replace all"
	b_Recursive_functions: STRING is			"Recursive Functions"
	b_Reload: STRING is							"Reload"
	b_Remove: STRING is							"Remove"
	b_Remove_all: STRING is						"Remove all"
	b_Remove_text: STRING is 					"<- Remove"
	b_Retry: STRING is							"Retry"
	b_Search: STRING is							"Search"
	b_New_search: STRING is 					"New Search?"
	b_Save: STRING is							"Save"
	b_Total_time: STRING is						"Total Time"
	b_Up_text: STRING is 						"Up"
	b_Update: STRING is 						"Update"
	b_Compile: STRING is						"Compile"
	b_Launch: STRING is							"Debug"
	b_Continue: STRING is						"Continue"
	b_Finalize: STRING is						"Finalize"
	b_Freeze: STRING is							"Freeze"
	b_Precompile: STRING is						"Precompile"
	b_Quickmelt: STRING is						"Quick Compile"
	b_Cut: STRING is							"Cut"
	b_Copy: STRING is							"Copy"
	b_Paste: STRING is							"Paste"
	b_New_editor: STRING is						"New Editor"
	b_New_context: STRING is					"New Context"
	b_New_window: STRING is						"New Window"
	b_Open: STRING is							"Open"
	b_Save_as: STRING is						"Save As"
	b_Shell: STRING is							"External Editor"
	b_Print: STRING is							"Print"
	b_Undo: STRING is							"Undo"
	b_Redo: STRING is							"Redo"
	b_Create_new_cluster: STRING is				"New Cluster"
	b_Create_new_class: STRING is				"New Class"
	b_Create_new_feature: STRING is				"New Feature"
	b_Send_stone_to_context: STRING is			"Synchronize"
	b_Display_error_help: STRING is				"Help Tool"
	b_Project_settings: STRING is				"Project Settings"
	b_System_info: STRING is					"System Info"
	b_Bkpt_info: STRING is						"Breakpoint Info"
	b_Bkpt_enable: STRING is					"Enable Breakpoints"
	b_Bkpt_disable: STRING is					"Disable Breakpoints"
	b_Bkpt_remove: STRING is					"Remove Breakpoints"
	b_Bkpt_stop_in_hole: STRING is				"Pause"
	b_Exec_kill: STRING is						"Kill Debugged Application"
	b_Exec_into: STRING is						"Step Into"
	b_Exec_no_stop: STRING is					"Launch Without Stopping"
	b_Exec_out: STRING is						"Step Out"
	b_Exec_step: STRING is						"Step"
	b_Exec_stop: STRING is						"Pause"
	b_Run_finalized: STRING is					"Run Finalized"
	b_Toggle_stone_management: STRING is 		"Link Context"
	b_Raise_all: STRING is						"Raise Windows"
	b_Remove_class_cluster: STRING is			"Remove Class/CLuster"
	b_Minimize_all: STRING is					"Minimize All"
	b_Terminate_c_compilation: STRING is 		"Terminate C compilation"
	b_Expand_all: STRING is 					"Expand All"
	b_Collapse_all: STRING is 					"Collapse All"

feature -- Graphical degree output

	d_Classes_to_go: STRING is					"Classes to Go:"
	d_Clusters_to_go: STRING is					"Clusters to Go:"
	d_Compilation_class: STRING is				"Class:"
	d_Compilation_cluster: STRING is			"Cluster:"
	d_Compilation_progress: STRING is			"Compilation Progress for "
	d_Degree: STRING is							"Degree:"
	d_Documentation: STRING is					"Documentation"
	d_Features_processed: STRING is				"Completed: "
	d_Features_to_go: STRING is					"Remaining: "
	d_Generating: STRING is						"Generating: "
	d_Resynchronizing_breakpoints: STRING is 	"Resynchronizing Breakpoints"
	d_Resynchronizing_tools: STRING is			"Resynchronizing Tools"
	d_Reverse_engineering: STRING is			"Reverse Engineering Project"
	d_Finished_removing_dead_code: STRING is	"Dead Code Removal Completed"

feature -- Help text

	h_No_help_available: STRING is				"No help available for this element"

feature -- File names

	default_stack_file_name: STRING is			"stack"

feature -- Accelerator, focus label and menu name

	m_About: STRING is
		once
			Result := "&About " + Workbench_name + "..."
		end
	m_Advanced: STRING is				"Ad&vanced"
	m_Add_to_favorites: STRING is		"&Add to Favorites"
	m_Address_toolbar: STRING is		"&Address Bar"
	m_Apply: STRING is					"&Apply"
	m_Breakpoints_tool: STRING is		"Breakpoints"
	f_Clear_breakpoints: STRING is		"Remove all breakpoints"
	m_Clear_breakpoints: STRING is		"Re&move All Breakpoints"
	m_Comment: STRING is				"&Comment%TCtrl+K"
	m_Compilation_C_Workbench: STRING is	"Compile W&orkbench C Code"
	m_Compilation_C_Final: STRING is	"Compile F&inalized C Code"
	m_Contents: STRING is				"&Contents"
	m_Customize_general: STRING is		"&Customize Standard Toolbar..."
	m_Customize_project: STRING is		"Customize P&roject Toolbar..."
	m_Cut: STRING is					"Cu&t%TCtrl+X"
	f_Cut: STRING is					"Cut (Ctrl+X)"
	m_Call_stack_tool: STRING is		"Call stack"
	m_Cluster_tool: STRING is			"&Clusters"
	m_Complete_word: STRING is			"Complete &Word"
	m_Complete_class_name: STRING is	"Complete Class &Name"
	m_Context_tool: STRING is			"Conte&xt"
	m_Copy: STRING is					"&Copy%TCtrl+C"
	f_Copy: STRING is					"Copy (Ctrl+C)"
	m_Close: STRING is					"&Close Window%TAlt+F4"
	m_Close_short: STRING is			"&Close"
	f_Create_new_cluster: STRING is		"Create a new cluster"
	f_Create_new_class: STRING is		"Create a new class"
	f_Create_new_feature: STRING is		"Create a new feature"
	m_Debug_interrupt_new: STRING is	"I&nterrupt Application"
	f_Debug_edit_object: STRING is		"Edit Object content"
	m_Debug_edit_object: STRING is		"Edit Object Content"
	f_Debug_dynamic_eval: STRING is		"Dynamic feature evaluation"
	m_Debug_dynamic_eval: STRING is		"Dynamic Feature Evaluation"
	m_Debug_kill: STRING is				"&Kill application"
	f_Debug_run: STRING is				"Run"
	m_Debug_run: STRING is				"&Run%TCtrl+R"
	m_Debug_run_new: STRING is			"Debu&g"
	f_diagram_delete: STRING is			"Delete"
	l_diagram_delete: STRING is			"Delete graphical items, remove code from system"
	f_diagram_crop: STRING is			"Crop diagram"
	m_diagram_crop: STRING is			"&Crop Diagram"
	f_diagram_zoom_out: STRING is		"Zoom out"
	f_diagram_put_right_angles: STRING is		"Force right angles"
	f_diagram_remove_right_angles: STRING is	"Remove right angles"
	m_diagram_link_tool: STRING is		"&Put Right Angles"
	f_diagram_to_png: STRING is			"Export diagram to PNG"
	m_diagram_to_png: STRING is			"&Export Diagram to PNG"
	f_diagram_context_depth: STRING is  "Select depth of relations"
	m_diagram_context_depth: STRING is  "&Select Depth of Relations"
	f_diagram_delete_view: STRING is	"Delete current view"
	f_diagram_reset_view: STRING is 	"Reset current view"
	m_diagram_delete_view: STRING is	"&Delete Current View"
	m_diagram_reset_view: STRING is		"&Reset Current View"
	f_diagram_zoom_in: STRING is		"Zoom in"
	f_diagram_fit_to_screen: STRING is	"Fit to screen"
	f_diagram_undo: STRING is			"Undo last action"
	f_diagram_hide_supplier: STRING is	"Hide supplier links"
	f_diagram_show_supplier: STRING is	"Show supplier links"
	l_diagram_supplier_visibility: STRING is "Toggle visibility of supplier links"
	f_diagram_hide_labels: STRING is	"Hide labels"
	f_diagram_show_labels: STRING is	"Show labels"
	f_diagram_show_uml: STRING is		"Show UML"
	f_diagram_show_bon: STRING is 		"Show BON"
	f_diagram_hide_clusters: STRING is	"Hide clusters"
	f_diagram_show_clusters: STRING is	"Show clusters"
	f_diagram_show_legend: STRING is	"Show cluster legend"
	f_diagram_hide_legend: STRING is	"Hide cluster legend"
	f_diagram_remove_anchor: STRING is	"Remove anchor"
	l_diagram_labels_visibility: STRING is	"Toggle visibility of client link labels"
	l_diagram_uml_visibility: STRING is	"Toggle between UML and BON view"
	l_diagram_clusters_visibility: STRING is	"Toggle visibility of clusters"
	l_diagram_legend_visibility: STRING is	"Toggle visibility of cluster legend"
	l_diagram_remove_anchor: STRING is	"Remove anchor"
	l_diagram_force_directed: STRING is	"Turn on/off physics"
	l_diagram_toggle_quality: STRING is	"Toggle quality level"
	f_diagram_high_quality: STRING is 	"Switch to high quality"
	f_diagram_low_quality: STRING is 	"Switch to low quality"
	f_diagram_hide_inheritance: STRING is	"Hide inheritance links"
	f_diagram_show_inheritance: STRING is	"Show inheritance links"
	l_diagram_inheritance_visibility: STRING is "Toggle visibility of inheritance links"
	f_diagram_redo: STRING is			"Redo last action"
	f_diagram_fill_cluster: STRING is	"Include all classes of cluster"
	f_diagram_history: STRING is		"History tool"
	f_diagram_remove: STRING is			"Remove figure"
	l_diagram_remove: STRING is			"Delete graphical items"
	f_diagram_create_supplier_links: STRING is	"Create new client-supplier links"
	f_diagram_create_aggregate_supplier_links: STRING is "Create new aggregate client-supplier links"
	f_diagram_create_inheritance_links: STRING is "Create new inheritance links"
	l_diagram_create_links: STRING is	"Select type of new links"
	f_diagram_new_class: STRING is		"Create a new class"
	f_diagram_change_header: STRING is	"Change class name and generics"
	f_diagram_change_color: STRING is	"Change color"
	f_diagram_force_directed_on: STRING is	"Turn on physics"
	f_diagram_force_directed_off: STRING is	"Turn off physics"
	f_diagram_force_settings: STRING is	"Show physics settings dialog"
	f_Disable_stop_points: STRING is	"Disable all breakpoints"
	m_Disable_stop_points: STRING is	"&Disable All Breakpoints"
	m_Debug_block: STRING is			"E&mbed in %"Debug...%"%TCtrl+D"
	m_Editor: STRING is					"&Editor"
	m_Eiffel_introduction: STRING is	"&Introduction to Eiffel"
	f_Enable_stop_points: STRING is		"Enable all breakpoints"
	m_Enable_stop_points: STRING is		"&Enable All breakpoints"
	m_Exec_last: STRING is				"&Out of Routine"
	m_Exec_nostop: STRING is			"&Ignore Breakpoints"
	m_Exec_step: STRING is				"&Step-by-Step"
	m_Exec_into: STRING is				"Step In&to"
	m_Exit_project: STRING is			"E&xit"
	m_Explorer_bar: STRING is			"&Tools"
	m_Export_to: STRING is				"Save Cop&y As..."
	m_Export_XMI: STRING is 			"E&xport XMI..."
	m_Expression_evaluation: STRING is	"Expression Evaluation"
	m_External_editor: STRING is		"&External Editor"
	m_Favorites_tool: STRING is			"F&avorites"
	m_Features_tool: STRING is			"&Features"
	f_Finalize: STRING is				"Finalize..."
	m_Finalize_new: STRING is			"Finali&ze..."
	m_Find: STRING is					"&Search"
	m_Find_next: STRING is				"Find &Next"
	m_Find_previous: STRING is			"Find &Previous"
	m_Find_selection: STRING is			"Find &Selection"
	f_Freeze: STRING is					"Freeze..."
	m_Freeze_new: STRING is				"&Freeze..."
	m_General_toolbar: STRING is		"&Standard Buttons"
	m_Generate_documentation: STRING is "Generate &Documentation..."
	m_Go_to: STRING is					"&Go to..."
	m_Guided_tour: STRING is			"&Guided Tour"
	m_Help: STRING is					"&Help"
	m_Hide_favorites: STRING is			"&Hide Favorites"
	m_Hide_formatting_marks: STRING is	"&Hide Formatting Marks"
	m_History_forth: STRING is			"&Forward"
	m_History_back: STRING is			"&Back"
	f_History_forth: STRING is			"Go forth"
	f_History_back: STRING is			"Go back"
	m_How_to_s: STRING is				"&How to's"
	m_If_block: STRING is				"&Embed in %"if...%"%TCtrl+I"
	m_Indent: STRING is					"&Indent selection%TTab"
	m_Line_numbers: STRING is			"Toggle &Line numbers"
	f_Melt: STRING is					"Compile current project"
	m_Melt_new: STRING is				"&Compile"
	m_New: STRING is					"&New"
	f_New_window: STRING is				"Create a new window"
	m_New_window: STRING is				"New &Window"
	m_New_dynamic_lib: STRING is		"&Dynamic Library Builder..."
	m_New_project: STRING is			"&New Project..."
	m_Ok: STRING is						"&OK"
	m_Open: STRING is					"&Open...%TCtrl+O"
	m_Open_new: STRING is				"Op&en..."
	m_Open_project: STRING is			"&Open Project..."
	m_Organize_favorites: STRING is		"&Organize Favorites..."
	m_Output: STRING is					"&Output"
	f_Paste: STRING is					"Paste (Ctrl+V)"
	m_Paste: STRING is					"&Paste%TCtrl+V"
	m_Precompile_new: STRING is			"&Precompile"
	f_Print: STRING is					"Print"
	m_Print: STRING is					"&Print"
	f_preferences: STRING is			"Preferences"
	m_Preferences: STRING is			"&Preferences..."
	m_Profile_tool: STRING is			"Pro&filer..."
	m_Project_toolbar: STRING is		"&Project Bar"
	m_Recent_project: STRING is			"&Recent Projects"
	m_Redo: STRING is					"Re&do%TCtrl+Y"
	f_Redo: STRING is					"Redo (Ctrl+Y)"
	m_Replace: STRING is				"&Replace..."
	f_Retarget_diagram: STRING is		"Target to cluster or class"
	f_Run_finalized: STRING is			"Run finalized system"
	m_Run_finalized: STRING is			"&Run Finalized System"
	f_Save: STRING is					"Save"
	m_Save_new: STRING is				"&Save"
	m_Save_As: STRING is				"S&ave As..."
	m_Search: STRING is					"&Find..."
	m_Search_tool: STRING is			"&Search"
	m_Select_all: STRING is				"Select &All%TCtrl+A"
	m_Send_to: STRING is				"Sen&d to"
	m_show_assigners: STRING is			"A&ssigners"
	m_Show_class_cluster: STRING is		"Find in Cluster Tree"
	m_show_creators: STRING is			"C&reators"
	m_Show_favorites: STRING is			"&Show Favorites"
	m_Show_formatting_marks: STRING is		"&Show Formatting Marks"
	m_Showancestors: STRING is			"&Ancestors"
	m_Showattributes: STRING is			"A&ttributes"
	m_Showcallers: STRING is			"&Callers"
	m_Showclick: STRING is				"C&lickable"
	m_Showclients: STRING is			"Cli&ents"
	m_showcreators: STRING is			"&Creators"
	m_Showdeferreds: STRING is			"&Deferred"
	m_Showdescendants: STRING is		"De&scendants"
	m_Showexported: STRING is			"Ex&ported"
	m_Showexternals: STRING is			"E&xternals"
	m_Showflat: STRING is				"&Flat"
	m_Showfs: STRING is					"&Interface"
	m_Showfuture: STRING is				"&Descendant Versions"
	m_Showhistory: STRING is			"&Implementers"
	m_Showindexing: STRING is			"&Indexing clauses"
	m_show_invariants: STRING is		"In&variants"
	m_Showonces: STRING is				"O&nce/Constants"
	m_Showpast: STRING is				"&Ancestor Versions"
	m_Showroutines: STRING is			"&Routines"
	m_Showshort: STRING is				"C&ontract"
	m_Showhomonyms: STRING is			"&Homonyms"
	m_Showsuppliers: STRING is			"S&uppliers"
	m_Showtext_new: STRING is			"Te&xt"
	m_System_new: STRING is				"Project &Settings..."
	m_Toolbars: STRING is				"Tool&bars"
	m_To_lower: STRING is				"Set to &Lowercase%TCtrl+Shift+U"
	m_To_upper: STRING is				"Set to U&ppercase%TCtrl+U"
	m_Uncomment: STRING is				"U&ncomment%TCtrl+Shift+K"
	f_Uncomment: STRING is				"Uncomment selected lines"
	m_Undo: STRING is					"&Undo%TCtrl+Z"
	f_Undo: STRING is					"Undo (Ctrl+Z)"
	m_Unindent: STRING is				"&Unindent Selection%TShift+Tab"
	m_Windows_tool: STRING is			"&Windows"
	m_Watch_tool: STRING is				"Watch Tool"
	m_Wizard_precompile: STRING is 		"Precompilation &Wizard..."
	f_Wizard_precompile: STRING is		"Wizard to precompile libraries"

feature -- Toggles

	f_hide_alias: STRING is			"Hide Alias Name"
	f_hide_assigner: STRING is		"Hide Assigner Command Name"
	f_hide_signature: STRING is		"Hide Signature"
	f_show_alias: STRING is			"Show Alias Name"
	f_show_assigner: STRING is		"Show Assigner Command Name"
	f_show_signature: STRING is		"Show Signature"
	l_toggle_alias: STRING is		"Toggle visibility of feature alias name"
	l_toggle_assigner: STRING is	"Toggle visibility of assigner command name"
	l_toggle_signature: STRING is	"Toggle visibility of feature signature"

feature -- Menu mnenomics

	m_Add_exported_feature: STRING is	"&Add..."
	m_Bkpt_info: STRING is				"Brea&kpoint Information"
	m_Class_info: STRING is				"Cla&ss Views"
	m_Check_exports: STRING is			"Chec&k Export Clauses"
	m_Create_new_cluster: STRING is		"New C&luster..."
	m_Create_new_class: STRING is		"&New Class..."
	m_Create_new_feature: STRING is		"New Fea&ture..."
	m_Debug: STRING is					"&Debug"
	m_Debugging_tool: STRING is			"&Debugging Tools"
	m_Disable_this_bkpt: STRING is		"&Disable This Breakpoint"
	m_Display_error_help: STRING is		"Compilation Error &Wizard..."
	m_Display_system_info: STRING is	"S&ystem Info"
	m_Edit: STRING is					"&Edit"
	m_Edit_condition: STRING is			"E&dit Condition"
	m_Edit_exported_feature: STRING is	"&Edit..."
	m_Edit_external_commands: STRING is	"&External Commands..."
	m_Enable_this_bkpt: STRING is		"&Enable This Breakpoint"
	m_Favorites: STRING is				"Fav&orites"
	m_Feature_info: STRING is			"Feat&ure Views"
	m_File: STRING is					"&File"
	m_Formats: STRING is				"F&ormat"
	m_Formatter_separators: ARRAY [STRING] is
		once
			Result := <<"Text Generators", "Class Relations", "Restrictors", "Main Editor Views">>
		end
	m_History: STRING is				"&Go to"
	m_Maximize: STRING is				"Ma&ximize"
	m_Minimize: STRING is				"Mi&nimize"
	m_Minimize_all: STRING is			"&Minimize All"
	m_New_editor: STRING is				"New Ed&itor Window"
	m_New_context_tool: STRING is		"New Con&text Window"
	m_Object: STRING is					"&Object"
	m_Object_tools: STRING is			"&Object Tools"
	m_Open_eac_browser: STRING is		"EAC Browser"
	m_Pretty_print: STRING is			"Expand an Object"
	m_Project: STRING is				"&Project"
	m_Quick_compile: STRING is			"&Quick Compile"
	m_Raise: STRING is					"&Raise"
	m_Raise_all: STRING is				"&Raise All"
	m_Raise_all_unsaved: STRING is		"Raise &Unsaved Windows"
	m_Remove_class_cluster: STRING is	"&Remove Current Item"
	m_Remove_exported_feature: STRING is	"&Remove"
	m_Remove_condition: STRING is		"Remove Condition"
	m_Remove_this_bkpt: STRING is		"&Remove This Breakpoint"
	m_Run_to_this_point: STRING is		"&Run to This Point"
	m_Send_stone_to_context: STRING is	"S&ynchronize Context Tool"
	m_Set_conditional_breakpoint: STRING is "Set &Conditional Breakpoint"
	m_Set_critical_stack_depth: STRING is "Overflow &Prevention..."
	m_Set_slice_size: STRING is			"&Alter size"
	m_Special: STRING is				"&Special"
	m_Separate_stone: STRING is			"Unlin&k Context Tool"
	m_Tools: STRING is					"&Tools"
	m_Unify_stone: STRING is			"Lin&k Context Tool"
	m_View: STRING is					"&View"
	m_Window: STRING is					"&Window"

feature -- Label texts

	l_Ace_file_for_frame: STRING is		"Ace file"
	l_Active_query: STRING is			"Active query"
	l_Address: STRING is				"Address:"
	l_All: STRING is					"recursive"
	l_Alias_name: STRING is				"Alias:"
	l_Ancestors: STRING is				"ancestors"
	l_Arguments: STRING is				"Arguments"
	l_assigners: STRING is				"assigners"
	l_Attributes: STRING is				"attributes"
	l_Available_buttons_text: STRING is "Available buttons"
	l_Basic_application: STRING is		"Basic application (no graphics library included)"
	l_Basic_text: STRING is				"basic text view"
	l_Callers: STRING is				"callers"
	l_Calling_convention: STRING is		"Calling convention:"
	l_Choose_folder: STRING is			"Select the destination folder "
	l_Class: STRING is					"Class:"
	l_Class_name: STRING is				"Class name:"
	l_Clients: STRING is				"clients"
	l_Clickable: STRING is				"clickable view"
	l_Cluster: STRING is				"Cluster:"
	l_Cluster_name: STRING is			"Cluster name "
	l_Cluster_options: STRING is		"Cluster options "
	l_Command_error_output: STRING is	"Command error output:%N"
	l_Command_line: STRING is			"Command line:"
	l_Command_normal_output: STRING is	"Command output:%N"
	l_Compiled_class: STRING is			"Only compiled classes"
	l_Compile_first: STRING is			"Compile to have information"
	l_Compile_generated_project: STRING is "Compile the generated project"
	l_Condition: STRING is				"Condition"
	l_Confirm_kill: STRING is			"Kill the debugged application?"
	l_Context: STRING is				"Context"
	l_Creation: STRING is				"Creation procedure:"
	l_creators: STRING is				"creators"
	l_Current_context: STRING is		"Current feature"
	l_Current_editor: STRING is			"Current editor"
	l_Current_object: STRING is			"Current object"
	l_Custom: STRING is 				"Custom"
	l_Deferred: STRING is				"deferred"
	l_Deferreds: STRING is				"deferred features"
	l_Deleting_dialog_default: STRING is "Creating new project, please wait..."
	l_Descendants: STRING is			"descendants"
	l_Diagram_delete_view_cmd: STRING is	"Do you really want to delete current view?"
	l_Diagram_reset_view_cmd: STRING is		"Do you really want to reset current view?"
	l_Discard_convert_project_dialog: STRING is	"Do not ask again, and always convert old projects"
	l_Discard_finalize_assertions: STRING is "Do not ask again, and always discard assertions when finalizing"
	l_Discard_finalize_precompile_dialog: STRING is "Dont ask me again and always finalize."
	l_Discard_freeze_dialog: STRING is	"Do not ask again, and always compile C code"
	l_Discard_save_before_compile_dialog: STRING is	"Do not ask again, and always save files before compiling"
	l_Discard_starting_dialog: STRING is "Don't show this dialog at startup"
	l_Discard_replace_all_warning_dialog: STRING is "Dont ask me again and always replace all"
	l_Discard_terminate_freezing: STRING is "Do not ask again, and always terminate freezing when needed."
	l_Discard_terminate_external_command: STRING is "Do not ask again, and always terminate running external command."
	l_Discard_terminate_finalizing: STRING is "Do not ask again, and always terminate finalizing when needed."
	l_Display_call_stack_warning: STRING is	"Display a warning when the call stack depth reaches:"
	l_Displayed_buttons_text: STRING is "Displayed buttons"
	l_Dont_ask_me_again: STRING is		"Do not ask me again"
	l_Do_not_detect_stack_overflows: STRING is "Do not detect stack overflows"
	l_Do_not_show_again: STRING is		"Do not show again"
	l_Dummy: STRING is					"Should not be read"
	l_Not_empty: STRING is				"Generate default feature clauses"
	l_Elements: STRING is				"elements."
	l_Enter_folder_name: STRING is		"Enter the name of the new folder: "
	l_Executing_command: STRING is		"Command is currently executing.%NPress OK to ignore the output."
	l_Execution_interrupted: STRING is	"Execution interrupted"
	l_Exit_application: STRING is
		once
			Result := "Are you sure you want to quit "+Workbench_name+"?"
		end
	l_Exit_warning: STRING is			"Some files have not been saved.%NDo you want to save them before exiting?"
	l_Expanded: STRING is				"expanded"
	l_Explicit_exception_pending: STRING is "Explicit exception pending"
	l_Exported: STRING is				"exported features"
	l_Expression: STRING is				"Expression"
	l_External: STRING is				"external features"
	l_Feature: STRING is				"Feature:"
	l_Feature_properties: STRING is		"Feature properties"
	l_File_name: STRING is				"File name:"
	l_Finalized_mode: STRING is 		"Finalized mode"
	l_Flat: STRING is					"flat view"
	l_Flatshort: STRING is				"interface view"
	l_general: STRING is				"General"
	l_Generate_profile_from_rtir: STRING is "Generate profile from Run-time information record"
	l_Generate_creation: STRING is		"Generate creation procedure"
	l_Homonyms: STRING is				"homonyms"
	l_Homonym_confirmation: STRING is	"Extracting the homonyms%Nmay take a long time."
	l_Identification: STRING is			"Identification"
	l_Implicit_exception_pending: STRING is "Implicit exception pending"
	l_Implementers: STRING is			"implementers"
	l_Inactive_subqueries: STRING is	"Inactive subqueries"
	l_Index: STRING is					"Index:"
	l_invariants: STRING is				"invariants"
	l_Language_type: STRING is			"Language type"
	l_Library: STRING is				"library"
	l_Literal_value: STRING is			"Literal Value"
	l_Loaded_project: STRING is			"Loaded project: "
	l_Located_in: STRING is				" located in "
	l_Location: STRING is 				"Location"
	l_Locals: STRING is					"Locals"
	l_Min_index: STRING is				"Minimum index displayed"
	l_Match_case: STRING is				"Match case"
	l_Max_index: STRING is				"Maximum index displayed"
	l_Max_displayed_string_size: STRING is "Maximum displayed string size"
	l_More_items: STRING is				"Display limit reached"
	l_Name: STRING is					"Name:"
	l_New_breakpoint: STRING is			"New breakpoint(s) to commit"
	l_No_feature: STRING is				"Select a fully compiled feature to have information about it."
	l_No_feature_group_clause: STRING is "[Unnamed feature clause]"
	l_No_text_text: STRING is 			"No text labels"
	l_Not_in_system_no_info: STRING is	"Select a class which is fully compiled to have information about it."
	l_Not_yet_called: STRING is			"Not yet called"
	l_Object_attributes: STRING is		"Attributes"
	l_On_object: STRING is				"On object"
	l_As_object: STRING is				"As object"
	l_Of_class: STRING is				" of class "
	l_Of_feature: STRING is				" of feature "
	l_Onces: STRING is					"once routines and constants"
	l_Once_functions: STRING is			"Once routines"
	l_Open_project: STRING is			"Open a project"
	l_Open_an_existing_project: STRING is "Open compiled project"
	l_Options: STRING is 				"Options"
	l_Output_switches: STRING is		"Output switches"
	l_Parent_cluster: STRING is			"Parent cluster"
	l_parents: STRING is				"Parents:"
	l_Path: STRING is					"Path"
	l_Possible_overflow: STRING is		"Possible stack overflow"
	l_Profiler_used: STRING is			"Profiler used to produce the above record: "
	l_Project_location: STRING is		"The project location is the place where compilation%Nfiles will be generated by the compiler"
	l_Put_text_right_text: STRING is 	"Show selective text on the right of buttons"
	l_Show_all_text: STRING is			"Show text labels"
	l_Query: STRING is					"Query"
	l_Remove_object: STRING is			"Remove"
	l_Remove_object_desc:STRING is		"Remove an object from the tree"
	l_Replace_with: STRING is			"Replace with:"
	l_Replace_with_ellipsis: STRING is	"Replace with..."
	l_Replace_all: STRING is			"Replace all"
	l_Result: STRING is					"Result"
	l_Root_class: STRING is				"Root class name: "
	l_Root_class_name: STRING is		"Root class: "
	l_Root_cluster_name: STRING is		"Root cluster: "
	l_Root_feature_name: STRING is		"Root feature: "
	l_Routine_ancestors: STRING is		"ancestor versions"
	l_Routine_descendants: STRING is	"descendant versions"
	l_Routine_flat: STRING is			"flat view"
	l_Routines: STRING is				"routines"
	l_Runtime_information_record: STRING is "Run-time information record"
	l_Same_class_name: STRING is		"---"
	l_Scope: STRING is 					"Scope"
	l_Search_backward: STRING is		"Search backwards"
	l_Search_for: STRING is				"Search for:"
	l_Search_options_show: STRING is	"Scope >>"
	l_Search_options_hide: STRING is	"Scope <<"
	l_Search_report_show: STRING is		"Report >>"
	l_Search_report_hide: STRING is 	"Report <<"
	l_Set_as_default: STRING is			"Set as default"
	l_Set_slice_limits: STRING is		"Slice limits"
	l_Set_slice_limits_desc: STRING is	"Set which values are shown in special objects"
	l_Short: STRING is					"contract view"
	l_Short_name: STRING is				"Short Name"
	l_Show_all_call_stack: STRING is	"Show all stack elements"
	l_Show_only_n_elements: STRING is	"Show only:"
	l_Showallcallers: STRING is			"Show all callers"
	l_Showcallers: STRING is			"Show static callers"
	l_Showstops: STRING is				"Show stop points"
	l_Slice_taken_into_account1: STRING is "Warning: Modifications will be taken into account"
	l_Slice_taken_into_account2: STRING is "for the next objects you will add in the object tree."
	l_Specify_arguments: STRING is		"Specify arguments"
	l_Stepped: STRING is				"Step completed"
	l_Stop_point_reached: STRING is		"Breakpoint reached"
	l_Sub_cluster: STRING is			"Subcluster"
	l_Sub_clusters: STRING is			"Subclusters"
	l_Subquery: STRING is				"Define new subquery"
	l_Suppliers: STRING is				"suppliers"
	l_Switch_num_format: STRING is 		"Switch numerical formating"
	l_Switch_num_format_desc: STRING is "Display numerical value as Hexadecimal or Decimal formating"
	l_Syntax_error: STRING is			"Class text has syntax error"
	l_System_name: STRING is			"System name: "
	l_System_properties: STRING is		"System properties"
	l_System_running: STRING is			"System running"
	l_System_launched: STRING is		"System launched"
	l_System_not_running: STRING is		"System not running"
	l_Tab_output: STRING is 			"Output"
	l_Tab_class_info: STRING is 		"Class"
	l_Tab_feature_info: STRING is 		"Feature"
	l_Tab_diagram: STRING is 			"Diagram"
	l_Tab_metrics: STRING is 			"Metrics"
	l_Text_loaded: STRING is			"Text finished loading"
	l_Text_saved: STRING is				"Text was saved"
	l_Three_dots: STRING is				"..."
	l_Text_loading: STRING is		"Current text is being loaded. It is therefore%Nnot editable nor pickable."
	l_Toolbar_with_gray_icons: STRING is "Display color icon when mouse cursor is over the button"
	l_Toolbar_without_gray_icons: STRING is "Always display color icon"
	l_Toolbar_select_text_position: STRING is "Text option: "
	l_Toolbar_select_has_gray_icons: STRING is "Icon option: "
	l_Top_level: STRING is				"Top-level"
	l_Type: STRING is					"Type"
	l_Unknown_status: STRING is			"Unknown application status"
	l_Unknown_class_name: STRING is		"Unknown class name"
	l_Use_existing_ace: STRING is		"Open existing Ace (control file)"
	l_Use_existing_profile: STRING is	"Use existing profile: "
	l_Use_regular_expression: STRING is "Use regular expression"
	l_Use_wildcards: STRING is			"Use wildcards"
	l_Use_wizard: STRING is 			"Create a new project"
	l_Value: STRING is					"Value"
	l_Whole_project: STRING is			"Whole project"
	l_Whole_word: STRING is				"Whole word"
	l_Windows_only: STRING is			"(Windows only)"
	l_Workbench_mode: STRING is 		"Workbench mode"
	l_Working_formatter: STRING is		"Extracting "
	l_Tab_external_output: STRING is    "External Output"
	l_Tab_C_output: STRING is    		"C Output"
	l_Tab_warning_output: STRING is    	"Warnings"
	l_Tab_error_output: STRING is    	"Errors"
feature -- Stone names

	s_Class_stone: STRING is			"Class "
	s_Cluster_stone: STRING is			"Cluster "
	s_Feature_stone: STRING is			"Feature "

feature -- Title part

	t_About: STRING is
		once
			Result := "About " + Workbench_name
		end
	t_Add_search_scope: STRING is				"Add Search Scope"
	t_Alias: STRING is							"Alias"
	t_Breakpoints_tool: STRING is				"Breakpoints"
	t_Call_stack_tool: STRING is				"Call Stack"
	t_Calling_convention: STRING is				"Calling Convention"
	t_Choose_ace_file: STRING is 				"Choose an Ace File"
	t_Choose_ace_and_directory: STRING is		"Choose Your Ace File and Directory"
	t_Choose_class: STRING is					"Choose a Class"
	t_Choose_directory: STRING is 				"Choose Your Directory"
	t_Choose_folder_name: STRING is				"Choose a Folder Name"
	t_Choose_project_and_directory: STRING is 	"Choose Your Project Name and Directory"
	t_Class: STRING is							"Class"
	t_Clients_of: STRING is						"Clients of Class "
	t_Cluster_tool: STRING is					"Clusters"
	t_Context_tool: STRING is					"Context"
	t_Creation_routine: STRING is				"Creation Procedure"
	t_Customize_toolbar_text: STRING is 		"Customize Toolbar"
	t_Debugging_tool: STRING is					"Debugging"
	t_Default_print_job_name: STRING is
		once
			Result := "From " + Workbench_name
		end
	t_Deleting_files: STRING is					"Deleting Files"
	t_Dummy: STRING is							"Dummy"
	t_Dynamic_lib_window: STRING is 			"Dynamic Library Builder"
	t_Dynamic_type: STRING is					"In Class"
	t_Editor: STRING is							"Editor"
	t_Enter_condition: STRING is				"Enter Condition"
	t_Exported_feature: STRING is				"Feature"
	t_Expression_evaluation: STRING is			"Evaluation"
	t_Extended_explanation: STRING is			"Compilation Error Wizard"
	t_external_command: STRING is				"External Command"
	t_external_commands: STRING is				"External Commands"
	t_External_edition: STRING is				"External Edition"
	t_Favorites_tool: STRING is					"Favorites"
	t_Feature: STRING is						"In Feature"
	t_Feature_properties: STRING is				"Feature Properties"
	t_File_selection: STRING is					"File Selection"
	t_Find: STRING is							"Find"
	t_Index: STRING is							"Index"
	t_New_class: STRING is						"New Class"
	t_New_cluster: STRING is					"New Cluster"
	t_New_expression: STRING is					"New Expression"
	t_New_project: STRING is					"New Project"
	t_Object_tool: STRING is					"Objects"
	t_Open_backup: STRING is					"Backup Found"
	t_Organize_favorites: STRING is				"Organize Favorites"
	t_Profile_query_window: STRING is			"Profile Query Window"
	t_Profiler_wizard: STRING is				"Profiler Wizard"
	t_Project: STRING is
		once
			Result := Workbench_name
		end
	t_Preference_window: STRING is				"Preferences"
	t_Select_class: STRING is					"Select Class"
	t_Select_cluster: STRING is					"Select Cluster"
	t_Select_feature: STRING is					"Select Feature"
	t_Search_tool: STRING is					"Search"
	t_Select_a_file: STRING is					"Select a File"
	t_Select_a_directory: STRING is				"Select a Directory"
	t_Set_stack_depth: STRING is				"Maximum Call Stack Depth"
	t_Set_critical_stack_depth: STRING is		"Overflow Prevention"
	t_Static_type: STRING is					"From Class"
	t_Starting_dialog: STRING is
		once
			Result := Workbench_name
		end
	t_Slice_limits: STRING is					"Choose New Slice Limits for Special Objects"
	t_System: STRING is							"Project Settings"
	t_Windows_tool: STRING is					"Windows"
	t_Watch_tool: STRING is						"Watch"
	t_Features_tool: STRING is					"Features"
	t_Empty_development_window: STRING is 		"Empty Development Tool"
	t_Autocomplete_window: STRING is			"Auto-Complete"
	t_Diagram_class_header: STRING is			"Class Header"
	t_Diagram_set_center_class: STRING is		"Set Center Class"
	t_Diagram_context_depth: STRING is			"Select Depths"
	t_Diagram_link_tool: STRING is				"Link Tool"
	t_Diagram_delete_client_link: STRING is 	"Choose Feature(s) to Delete"
	t_Diagram_history_tool: STRING is			"History Tool"

	t_Diagram_move_class_cmd (a_name: STRING): STRING is
		require
			exists: a_name /= Void
		do
			Result := "Move Class '" + a_name + "'"
		end

	t_Diagram_move_cluster_cmd (a_name: STRING): STRING is
		require
			exists: a_name /= Void
		do
			Result := "Move Cluster '" + a_name + "'"
		end

	t_Diagram_move_midpoint_cmd: STRING is		"Move Midpoint"

	t_Diagram_add_cs_link_cmd (client_name, supplier_name: STRING): STRING is
		require
			exists: client_name /= Void	and supplier_name /= Void
		do
			Result := "Add Client-Supplier Relation Between '" + client_name + "' and '" + supplier_name  + "'"
		end

	t_Diagram_add_inh_link_cmd (ancestor_name, descendant_name: STRING): STRING is
		require
			exists: ancestor_name /= Void and descendant_name /= Void
		do
			Result := "Add Inheritance Relation Between '" + ancestor_name + "' and '" + descendant_name + "'"
		end

	t_Diagram_include_class_cmd (a_name: STRING): STRING is
		require
			exists: a_name /= Void
		do
			Result := "Include Class '" + a_name + "'"
		end

	t_Diagram_include_cluster_cmd (a_name: STRING): STRING is
		require
			exists: a_name /= Void
		do
			Result := "Include Cluster '" + a_name + "'"
		end

	t_Diagram_insert_midpoint_cmd: STRING is	"Insert Midpoint"
	t_Diagram_change_color_cmd: STRING is		"Change Class Color"

	t_Diagram_rename_class_locally_cmd (old_name, new_name: STRING): STRING is
		require
			exists: old_name /= Void and new_name /= Void
		do
			Result := "Rename Class '" + old_name + "' Locally to '" + new_name + "'"
		end

	t_Diagram_rename_class_globally_cmd (old_name, new_name: STRING): STRING is
		require
			exists: old_name /= Void and new_name /= Void
		do
			Result := "Rename Class '" + old_name + "' Globally to '" + new_name + "'"
		end

	t_Diagram_delete_client_link_cmd (a_name: STRING): STRING is
		require
			exists: a_name /= Void
		do
			Result := "Delete Client Link '" + a_name + "'"
		end

	t_Diagram_delete_inheritance_link_cmd (an_ancestor, a_descendant: STRING): STRING is
		require
			exists: an_ancestor /= Void and a_descendant /= Void
		do
			Result := "Delete Inheritance Link Between '" + an_ancestor + "' and '" + a_descendant + "'"
		end

	t_Diagram_erase_cluster_cmd (a_name: STRING): STRING is
		require
			exists: a_name /= Void
		do
			Result := "Erase Cluster '" + a_name + "'"
		end

	t_Diagram_delete_midpoint_cmd: STRING is	"Erase Midpoint"

	t_Diagram_erase_class_cmd (a_name: STRING): STRING is
		require
			exists: a_name /= Void
		do
			Result := "Erase Class '" + a_name + "'"
		end

	t_Diagram_erase_classes_cmd: STRING is		"Erase Classes"
	t_Diagram_put_right_angles_cmd: STRING is	"Put Right Angles"
	t_Diagram_remove_right_angles_cmd: STRING is	"Remove Right Angles"
	t_Diagram_put_one_handle_left_cmd: STRING is	"Put Handle Left"
	t_Diagram_put_one_handle_right_cmd: STRING is	"Put Handle Right"
	t_Diagram_put_two_handles_left_cmd: STRING is	"Put Two Handles Left"
	t_Diagram_put_two_handles_right_cmd: STRING is	"Put Two Handles Right"
	t_Diagram_remove_handles_cmd: STRING is		"Remove Handles"
	t_Diagram_zoom_in_cmd: STRING is			"Zoom In"
	t_Diagram_zoom_out_cmd: STRING is			"Zoom Out"
	t_Diagram_zoom_cmd: STRING is				"Zoom"

	t_Diagram_cluster_expand (a_name: STRING): STRING is
		require
			exists: a_name /= Void
		do
			Result := "Expand cluster '" + a_name + "'"
		end

	t_Diagram_cluster_collapse (a_name: STRING): STRING is
		require
			exists: a_name /= Void
		do
			Result := "Collapse Cluster '" + a_name + "'"
		end

	t_Diagram_disable_high_quality: STRING is	"Disable High Quality"
	t_Diagram_enable_high_quality: STRING is	"Enable High Quality"

feature -- Description texts

	e_Add_exported_feature: STRING is	"Add a new feature to this dynamic library definition"
	e_Bkpt_info: STRING is				"Show/Hide information about breakpoints"
	e_Check_exports: STRING is			"Check the validity of the library definition"
	e_Compilation_failed: STRING is		"Eiffel compilation failed"
	e_Compilation_succeeded: STRING is	"Eiffel compilation succeeded"
	e_C_compilation_failed: STRING is 	"Background C compilation failed"
	e_C_compilation_launch_failed: STRING is "Background C compilation launch failed"
	e_C_compilation_terminated: STRING is "Background C compilation has been terminated by user"
	e_C_compilication_launched: STRING is "Background C compilation launched"
	e_C_compilation_succeeded: STRING is "Background C compilation succeeded"
	e_C_compilation_running: STRING is  "Background C compilation in progress"
	e_Compiling: STRING is				"System is being compiled"
	e_Cursor_position: STRING is		"Cursor position (line:column)"
	e_Diagram_hole: STRING is			"Please drop a class or a cluster on this button %N%
										%to view its diagram.%N%
										%Use right click for both pick and drop actions."
	e_Diagram_class_header: STRING is 	"Please drop a class on this button.%NUse right click for both%N%
										%pick and drop actions."
	e_Diagram_remove_anchor: STRING is	"Please drop a class or a cluster with an%Nanchor on this button.%NUse right click for both%N%
										%pick and drop actions."
	e_Diagram_create_class: STRING is	"Please drop this button on the diagram.%N%
										%Use right click for both%Npick and drop actions."
	e_Diagram_delete_figure: STRING is	"Please drop a class, a cluster or a midpoint%N%
										%on this button. Use right click for both%Npick and drop actions."
	e_Diagram_delete_item: STRING is	"Please drop a class, a cluster or a link%N%
										%on this button. Use right click for both%Npick and drop actions."
	e_Display_error_help: STRING is		"Give help on compilation errors"
	e_Display_system_info: STRING is	"Display information concerning current system"
	e_Drop_an_error_stone: STRING is	"Pick the code of a compilation error (such as VEEN, VTCT,...)%N%
										%and drop it here to have extended information about it."
	e_Edit_exported_feature: STRING is	"Edit the properties of the selected feature"
	e_Edit_expression: STRING is		"Edit an expression"
	e_Edited: STRING is					"Some classes were edited since last compilation"
	e_Exec_debug: STRING is				"Run application and stop at breakpoints"
	e_Exec_kill: STRING is				"Kill the debugged application"
	e_Exec_into: STRING is				"Step into a routine"
	e_Exec_no_stop: STRING is			"Run application without stopping at breakpoints"
	e_Exec_out: STRING is				"Step out of a routine"
	e_Exec_step: STRING is				"Execute the application one line at a time"
	e_Exec_stop: STRING is				"Pause application at current point"
	e_History_back: STRING is			"Back"
	e_History_forth: STRING is			"Forward"
	e_Minimize_all: STRING is			"Minimize all windows"
	e_New_context_tool: STRING is		"Open a new context window"
	e_New_dynamic_lib_definition: STRING is	"Create a new dynamic library definition"
	e_New_editor: STRING is				"Open a new editor window"
	e_New_expression: STRING is			"Create a new expression"
	e_Not_running: STRING is			"Application is not running"
	e_Open_dynamic_lib_definition: STRING is "Open a dynamic library definition"
	e_Open_file: STRING is				"Open a file"
	e_Open_eac_browser: STRING is		"Open the Eiffel Assembly Cache browser tool"
	e_Paste: STRING is					"Paste"
	e_Paused: STRING is					"Application is paused"
	e_Pretty_print: STRING is			"Display an expanded view of objects"
	e_Print: STRING is					"Print the currently edited text"
	e_Project_name: STRING is			"Name of the current project"
	e_Project_settings: STRING is		"Change project settings"
	e_Quick_compile: STRING is			"Recompile classes that were edited in EiffelStudio"
	e_Raise_all: STRING is				"Raise all windows"
	e_Raise_all_unsaved: STRING is		"Raise all unsaved windows"
	e_Redo: STRING is					"Redo"
	e_Remove_class_cluster: STRING is	"Remove a class or a cluster from the system"
	e_Remove_exported_feature: STRING is	"Remove the selected feature from this dynamic library definition"
	e_Remove_expressions: STRING is		"Remove selected expressions"
	e_Remove_object: STRING is			"Remove currently selected object"
	e_Running: STRING is				"Application is running"
	e_Running_no_stop_points: STRING is	"Application is running (ignoring breakpoints)"
	e_Save_call_stack: STRING is		"Save call stack to a text file"
	e_Save_dynamic_lib_definition: STRING is "Save this dynamic library definition"
	e_Show_class_cluster: STRING is		"Locate currently edited class or cluster"
	e_Send_stone_to_context: STRING is	"Synchronize context"
	e_Separate_stone: STRING is			"Unlink the context tool from the other components"
	e_Set_stack_depth: STRING is		"Set maximum call stack depth"
	e_Shell: STRING is					"Send to external editor"
	e_Switch_num_format_to_hex: STRING is "Switch to hexadecimal format"
	e_Switch_num_format_to_dec: STRING is "Switch to decimal format"
	e_Switch_num_formating: STRING is "Hexadecimal/Decimal formating"
	e_Toggle_state_of_expressions: STRING is		"Enable/Disable expressions"
	e_Toggle_stone_management: STRING is "Link or not the context tool to other components"
	e_Undo: STRING is					"Undo"
	e_Up_to_date: STRING is				"Executable is up-to-date"
	e_Unify_stone: STRING is			"Link the context tool to the other components"
	e_Terminate_c_compilation: STRING is "Terminate current C compilation in progress"

feature -- Wizard texts

	wt_Profiler_welcome: STRING is "Welcome to the Profiler Wizard"
	wb_Profiler_welcome: STRING is
				"Using this wizard you can analyze the result of a profiling.%N%
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
				%To continue, click Next."

	wt_Compilation_mode: STRING is "Compilation mode"
	ws_Compilation_mode: STRING is "Select the Compilation mode."

	wt_Execution_Profile: STRING is "Execution Profile"
	ws_Execution_Profile: STRING is "Reuse or Generate an Execution Profile."
	wb_Execution_Profile: STRING is
			"You can generate the Execution Profile from a Run-time Information Record%N%
			%created by a profiler, or you can reuse an existing Execution Profile if you%N%
			%have already generated one for this system."

	wt_Execution_Profile_Generation: STRING is "Execution Profile Generation"
	ws_Execution_Profile_Generation: STRING is "Select a Run-time information record to generate the Execution profile"
	wb_Execution_Profile_Generation: STRING is
				"Once an execution of an instrumented system has generated the proper file,%N%
				%you must process it through a profile converter to produce the Execution%N%
				%Profile. The need for the converter comes from the various formats that%N%
				%profilers use to record run-time information during an execution.%N%
				%%N%
				%Provide the Run-time information record produced by the profiler and%N%
				%select the profiler used to create this record.%
				%%N%
				%The Execution Profile will be generated under the file %"profinfo.pfi%"."

	wt_Switches_and_query: STRING is "Switches and Query"
	ws_Switches_and_query: STRING is "Select the information you need and formulate your query."

	wt_Generation_error: STRING is "Generation Error"
	wb_Click_back_and_correct_error: STRING is "Click Back if you can correct the problem or Click Abort."

	wt_Runtime_information_record_error: STRING is "Runtime Information Record Error"
	wb_Runtime_information_record_error (generation_path: STRING): STRING is
		do
			Result :=
				"The file you have supplied as Runtime Information Record%N%
				%does not exist or is not valid.%N%
				%Do not forget that the Runtime Information Record has to%N%
				%be located in the project directory:%N"
				+ generation_path +
				"%N%N%
				%Please provide a valid file or execute your profiler again to%N%
				%generate a valid Runtime Information Record.%N%
				%%N%
				%Click Back and select a valid file or Click Abort."
		end

	wt_Execution_profile_error: STRING is "Execution Profile Error"
	wb_Execution_profile_error: STRING is
				"The file you have supplied as existring Execution Provide does%N%
				%not exist or is not valid. Please provide a valid file or generate%N%
				%a new one.%N%
				%Click Back and select a valid file or choose the generate option."

feature -- Metric constants (tooltips)

	metric_metrics: STRING is			"&Metrics"

	metric_this_archive: STRING is		"Archive..."
	metric_this_system: STRING is		"System"
	metric_this_cluster: STRING is		"Cluster"
	metric_this_class: STRING is		"Class"
	metric_this_feature: STRING is		"Feature"

	metric_ignore: STRING is						"Ignore"

	metric_all: STRING is							"All"
	metric_classes: STRING is						"Classes"
	metric_deferred_class: STRING is				"Deferred classes"
	metric_effective_class: STRING is				"Effective"
	metric_invariant_equipped: STRING is			"Invariant equipped"
	metric_obsolete: STRING is						"Obsolete"
	metric_no_invariant: STRING is					"No invariant"
	metric_no_obsolete: STRING is					"Not obsolete"

	metric_clusters: STRING is						"Clusters"

	metric_compilations: STRING is					"Compilations"

	metric_dependents: STRING is					"Dependents"
	metric_clients: STRING is						"Clients"
	metric_indirect_clients: STRING is				"Indirect clients"
	metric_heirs: STRING is							"Heirs"
	metric_indirect_heirs: STRING is				"Indirect heirs"
	metric_parents: STRING is						"Parents"
	metric_indirect_parents: STRING is				"Indirect parents"
	metric_suppliers: STRING is						"Suppliers"
	metric_indirect_suppliers: STRING is			"Indirect suppliers"
	metric_self: STRING is							"Self"

	metric_features: STRING is						"Features"
	metric_attributes: STRING is					"Attributes"
	metric_commands: STRING is						"Commands"
	metric_deferred_feature: STRING is				"Deferred features"
	metric_exported: STRING is						"Exported"
	metric_inherited: STRING is						"Inherited"
	metric_functions: STRING is						"Functions"
	metric_postcondition_equipped: STRING is		"Postcondition equipped"
	metric_precondition_equipped: STRING is			"Precondition equipped"
	metric_queries: STRING is						"Queries"
	metric_routines: STRING is						"Routines"

	metric_imm_features: STRING is					"Features: immediate"
	metric_imm_attributes: STRING is				"Imm. attributes"
	metric_imm_commands: STRING is					"Imm. commands"
	metric_imm_deferred_feature: STRING is			"Imm. deferred features"
	metric_imm_effective_feature: STRING is			"Imm. effective features"
	metric_imm_exported: STRING is					"Imm. exported"
	metric_imm_functions: STRING is					"Imm. functions"
	metric_imm_postcondition_equipped: STRING is	"Imm. post equipped"
	metric_imm_precondition_equipped: STRING is		"Imm. pre equipped"
	metric_imm_queries: STRING is					"Imm. queries"
	metric_imm_routines: STRING is					"Imm. routines"

	metric_all_features: STRING is					"Features: all"
	metric_all_attributes: STRING is				"All attributes"
	metric_all_commands: STRING is					"All commands"
	metric_all_deferred_feature: STRING is			"All deferred features"
	metric_all_effective_feature: STRING is			"All effective features"
	metric_all_exported: STRING is					"All exported"
	metric_all_functions: STRING is					"All functions"
	metric_all_postcondition_equipped: STRING is	"All post equipped"
	metric_all_precondition_equipped: STRING is		"All pre equipped"
	metric_all_queries: STRING is					"All queries"
	metric_all_routines: STRING is					"All routines"

	metric_imm_feature_assertions: STRING is		"Feature assertions: immediate"
	metric_imm_precondition_clauses: STRING is		"Imm pre. clauses"
	metric_imm_postcondition_clauses: STRING is		"Imm. post. clauses"

	metric_all_feature_assertions: STRING is		"Feature assertions: all"
	metric_all_precondition_clauses: STRING is		"All pre. clauses"
	metric_all_postcondition_clauses: STRING is		"All post. clauses"

	metric_formal_generics: STRING is				"Formal generics"
	metric_formal_generics_constrained: STRING is	"Constrained"

	metric_formals: STRING is						"Formals"
	metric_imm_formals: STRING is					"Imm. formals"

	metric_invariant_clauses: STRING is				"Invariant clauses"
	metric_imm_invariant_clauses: STRING is			"Imm. invariant clauses"

	metric_lines: STRING is							"Lines"

	metric_locals: STRING is						"Locals"
	metric_imm_locals: STRING is					"Imm. locals"

--	metric_ancestors: STRING is						"Ancestors"
--	metric_descendants: STRING is					"Descendents"
--	metric_comment_lines: STRING is					"Comment lines"

	metric_class_unit: STRING is			"Class"
	metric_feature_unit: STRING is			"Feature"
	metric_cluster_unit: STRING is			"Cluster"
	metric_line_unit: STRING is				"Line"
	metric_contract_unit: STRING is			"Contract"
	metric_contract_clause_unit: STRING is	"Contract clause"
	metric_ratio_unit: STRING is			"Ratio"
	metric_compilation_unit: STRING is		"Compilation"
	metric_local_unit: STRING is			"Local"

	metric_calculate: STRING is				"&Calculate"
	metric_add: STRING is					"&Add"
	metric_delete: STRING is				"&Delete"
	metric_details: STRING is				"&Show/hide details"
	metric_new_metrics: STRING is			"&New metrics"
	metric_management: STRING is			"&Metric management"
	metric_archive: STRING is				"A&rchive"

end -- class INTERFACE_NAMES


