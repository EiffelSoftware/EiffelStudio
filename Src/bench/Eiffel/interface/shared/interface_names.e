indexing

	description:
		"Constants for command names, etc.";
	conventions:
		"a_: Accelerator key combination; %
		%b_: Button text; %
		%d_: Degree outputter; %
		%f_: Focus label text; %
		%h_: Help text; %
		%i_: Icon ids for windows (ignored for motif); %
		%m_: Mnemonic (menu entry); %
		%l_: Label texts; %
		%n_: widget Names; %
		%s_: Stone names; %
		%t_: Title (part)";
	date: "$Date$";
	revision: "$Revision$"

class INTERFACE_NAMES
	
feature -- Button texts

	b_And: STRING is					"And"
	b_Apply: STRING is					" Apply ";
	b_All: STRING is					" All ";
	b_Browse: STRING is					"Browse...";
	b_Build: STRING is					"Build";
	b_Cancel: STRING is					" Cancel ";
	b_C_functions: STRING is			"C functions";
	b_Close: STRING is					"Close";
	b_Compile: STRING is				"Compile";
	b_Create: STRING is					"Create";
	b_Descendant_time: STRING is		"Descendant time";
	b_Discard_assertions: STRING is		"Discard assertions";
	b_Display: STRING is				" Display ";
	b_Eiffel_features: STRING is		"Eiffel features";
	b_Execute: STRING is				" Execute ";
	b_Exit: STRING is					"Exit";
	b_Exit_now: STRING is				"Exit now";
	b_Feature_name: STRING is			"Feature name";
	b_Final: STRING is					"Final mode";
	b_Finalize_now: STRING is			"Finalize now";
	b_Finalize_now_but_no_c: STRING is	"Finalize (no C comp)";
	b_Freeze_now: STRING is				"Freeze now";
	b_Freeze_now_but_no_c: STRING is	"Freeze (no C comp)";
	b_Function_time: STRING is			"Function time";
	b_Keep_assertions: STRING is		"Keep assertions";
	b_No: STRING is						" No ";
	b_Non_clickable_Stoppoints_of: STRING is "Non clickable stop points of ";
	b_Number_of_calls: STRING is		"Number of calls";
	b_Ok: STRING is						" OK ";
	b_Or: STRING is						"Or";
	b_Overwrite: STRING is				"Overwrite";
	b_Percentage: STRING is				"Percentage";
	b_Precompile_now: STRING is			"Precompile now";
	b_Recursive_functions: STRING is	"Recursive functions";
	b_Run: STRING is					"Run";
	b_Run_query: STRING is				"Run query";
	b_Run_subquery: STRING is			"Run subquery";
	b_Save: STRING is					"Save";
	b_Save_as: STRING is				"Save as";
	b_Total_time: STRING is				"Total time";
	b_Workbench: STRING is				"Workbench mode";
	b_Yes: STRING is					" Yes ";

feature -- Graphical degree output

	d_Classes_to_go: STRING is			"Classes to go:";
	d_Clusters_to_go: STRING is			"Clusters to go:";
	d_Compilation_class: STRING is		"Class:";
	d_Compilation_cluster: STRING is	"Cluster:";
	d_Compilation_progress: STRING is	"Compilation Progress";
	d_Degree: STRING is					"Degree:";
	d_Documentation: STRING is			"Documentation";
	d_Features_processed: STRING is		"Features done: ";
	d_Features_to_go: STRING is			"Features to go: ";
	d_Generating: STRING is				"Generating: ";
	d_Resynchronizing_breakpoints: STRING is "Resynchronizing breakpoints";
	d_Resynchronizing_tools: STRING is	"Resynchronizing tools";
	d_Reverse_engineering: STRING is	"Reverse Engineering Project";

feature -- Help text

	h_No_help_available: STRING is		"No help available for this element";

feature -- Icon ids for Windows

	i_Project_id: INTEGER is 1;
	i_Object_id: INTEGER is 2;
	i_Feature_id: INTEGER is 3;
	i_Explain_id: INTEGER is 4;
	i_Class_id: INTEGER is 5;
	i_System_id: INTEGER is 6;

feature -- Accelerator, focus label and menu name

	m_Apply: STRING is					"&Apply"
	f_Case_storage: STRING is			"Reverse engineer (case)";
	m_Case_storage: STRING is			"&Reverse engineer (case)";
	f_Clear_breakpoints: STRING is		"Clear stop points";
	m_Clear_breakpoints: STRING is		"C&lear stop points";
	f_Close_all_tools: STRING is		"Close all tools";
	m_Close_all_tools: STRING is		"Close &all tools";
	f_Copy: STRING is					"Copy";
	m_Windows_copy: STRING is			"&Copy%TCtrl+C";
	m_Unix_copy: STRING is				"&Copy%TCtrl+Insert";
	a_Current: STRING is				"Ctrl<Key>u";
	f_Current: STRING is				"Current";
	m_Current: STRING is				"C&urrent%TCtrl+U";
	f_Cut: STRING is					"Cut";
	m_Windows_cut: STRING is			"&Cut%TCtrl+X";
	m_Unix_cut: STRING is				"&Cut%TShift+Delete";
	a_Debug_quit: STRING is				"Ctrl<Key>e";
	f_Debug_quit: STRING is				"Interrupt";
	m_Debug_quit: STRING is				"E&nd run%TCtrl+E";
	a_Debug_run: STRING is				"Ctrl<Key>r";
	f_Debug_run: STRING is				"Run";
	m_Debug_run: STRING is				"&Run%TCtrl+R";
	f_Debug_status: STRING is			"Execution status";
	m_Debug_status: STRING is			"E&xecution status";
	f_Disable_stop_points: STRING is	"Disable all stop points";
	m_Disable_stop_points: STRING is	"&Disable all stop points";
	f_Down_stack: STRING is				"Go down one level";
	m_Down_stack: STRING is				"Go &down one level";
	f_Enable_stop_points: STRING is		"Enable all stop points";
	m_Enable_stop_points: STRING is		"&Enable all stop points";
	f_Exec_last: STRING is				"Out of routine";
	m_Exec_last: STRING is				"&Out of routine";
	f_Exec_nostop: STRING is			"Ignore stop points";
	m_Exec_nostop: STRING is			"&Ignore stop points";
	f_Exec_step: STRING is				"Step by step";
	m_Exec_step: STRING is				"S&tep by step";
	f_Exec_stop: STRING is				"To next stop point";
	m_Exec_stop: STRING is				"To ne&xt stop point";
	f_Exit: STRING is					"Exit tool";
	m_Exit: STRING is					"E&xit tool";

	f_new_project: STRING is			"New Project..."
	m_new_project: STRING is			"&New Project...%TCtrl+N"
	a_new_project: STRING is			"Ctrl<Key>N"
	f_Open_project: STRING is			"Open Project..."
	m_Open_project: STRING is			"&Open Project...%TCtrl+O"
	a_Open_project: STRING is			"Ctrl<Key>O"
	m_Recent_project: STRING is			"&Recent Projects"
	f_Exit_project: STRING is			"Exit"
	m_Exit_project: STRING is			"E&xit"

	f_Filter: STRING is					"Filter";
	m_Filter: STRING is					"&Filter";
	f_Finalize: STRING is				"Finalize...";
	m_Finalize: STRING is				"Finali&ze...";
	f_Final_mode: STRING is				"Final mode";
	m_Final_mode: STRING is				"&Final mode";
	a_Find: STRING is					"Ctrl<Key>f";
	f_Find: STRING is					"Find";
	m_Find: STRING is					"&Find%TCtrl+F";
	f_flat_doc: STRING is				"Flat";
	m_flat_doc: STRING is				"&Flat";
	f_flat_short_doc: STRING is			"Flat short";
	m_flat_short_doc: STRING is			"F&lat short";
	f_text_doc: STRING is				"Text";
	m_text_doc: STRING is				"&Text";
	f_short_doc: STRING is				"Short";
	m_short_doc: STRING is				"&Short";
	f_Show_cluster_heir_list: STRING is	"Show cluster hierarchy";
	m_Show_cluster_heir_list: STRING is	"Cluster &hierarchy";
	a_Freeze: STRING is					"Ctrl<Key>n";
	f_Freeze: STRING is					"Freeze...";
	m_Freeze: STRING is					"&Freeze...%TCtrl+N";
	f_Generate: STRING is				"Generate";
	m_Generate: STRING is				"&Generate";
	f_Help: STRING is					"Help";
	m_Help: STRING is					"&Help";
	f_Hide_feature: STRING is			"Hide feature";
	m_Hide_feature: STRING is			"Hide &feature";
	f_Hide_object: STRING is			"Hide object";
	m_Hide_object: STRING is			"Hide &object";
	a_List_targets: STRING is			"Ctrl<Key>l";
	f_List_targets: STRING is			"List targets";
	m_List_targets: STRING is			"&List targets%TCtrl+L";
	f_New_class: STRING is				"New class tool";
	m_New_class: STRING is				"New &class tool";
	f_New_explain: STRING is			"New explain tool";
	m_New_explain: STRING is			"New &explain tool";
	f_New_object: STRING is				"New object tool";
	m_New_object: STRING is				"New &object tool";
	f_New_routine: STRING is			"New feature tool";
	m_New_routine: STRING is			"New &feature tool";
	f_Next_target: STRING is			"Next";
	m_Next_target: STRING is			"N&ext";
	f_Non_clickable_showstops: STRING is "Non clickable stop points";
	m_Non_clickable_showstops: STRING is "&Non clickable stop points";
	m_Ok: STRING is						"&Ok";
	a_Open: STRING is					"Ctrl<Key>o";
	f_Open: STRING is					"Open";
	m_Open: STRING is					"&Open%TCtrl+O";
	f_Paste: STRING is					"Paste";
	m_Windows_paste: STRING is			"&Paste%TCtrl+V";
	m_Unix_Paste: STRING is				"&Paste%TShift+Insert";
	a_Precompile: STRING is				"Ctrl<Key>P";
	f_Precompile: STRING is				"&Precompile...";
	m_Precompile: STRING is				"Precompile...%TCtrl+P";
	f_Print: STRING is					"Print...";
	m_Print: STRING is					"&Print";
	f_Preferences: STRING is			"Preferences";
	m_Preferences: STRING is			"&Preferences";
	f_Profile_tool: STRING is			"Profile tool";
	m_Profile_tool: STRING is			"Pro&file tool";
	f_Previous_target: STRING is		"Previous";
	m_Previous_target: STRING is		"&Previous";
	a_Quick_update: STRING is			"Ctrl<Key>q";
	f_Quick_update: STRING is			"Quick melt";
	m_Quick_update: STRING is			"&Quick Melt%TCtrl+Q";
	f_Raise_all_tools: STRING is		"Raise all tools";
	m_Raise_all_tools: STRING is		"&Raise all tools";
	f_Raise_project: STRING is			"Raise project tool";
	m_Raise_project: STRING is			"&Raise project tool%TAlt+R";
	a_Raise_project: STRING is			"Alt<Key>P";
	f_Run_finalized: STRING is			"Run finalized system";
	m_Run_finalized: STRING is			"&Run finalized system";
	a_Save: STRING is					"Ctrl<Key>S";
	f_Save: STRING is					"Save";
	m_Save: STRING is					"&Save%TCtrl+S";
	f_Save_As: STRING is				"Save as...";
	m_Save_As: STRING is				"S&ave as...";
	f_Shell: STRING is					"Shell";
	m_Shell: STRING is					"S&hell";
	f_Showallcallers: STRING is			"All callers";
	m_Showallcallers: STRING is			"All &callers";
	f_Showancestors: STRING is			"Ancestors";
	m_Showancestors: STRING is			"&Ancestors";
	f_Showattributes: STRING is			"Attributes";
	m_Showattributes: STRING is			"A&ttributes";
	f_Showcallers: STRING is			"Callers";
	m_Showcallers: STRING is			"&Callers";
	f_Showclass_list: STRING is			"Classes";
	m_Showclass_list: STRING is			"C&lasses";
	f_Showclick: STRING is				"Clickable";
	m_Showclick: STRING is				"Cl&ickable";
	f_Showclients: STRING is			"Clients";
	m_Showclients: STRING is			"Cli&ents";
	f_Showclusters: STRING is			"Clusters";
	m_Showclusters: STRING is			"&Clusters";
	f_Showdeferreds: STRING is			"Deferred";
	m_Showdeferreds: STRING is			"&Deferred";
	f_Showdescendants: STRING is		"Descendants";
	m_Showdescendants: STRING is		"Des&cendants";
	f_Showexported: STRING is			"Exported";
	m_Showexported: STRING is			"E&xported";
	f_Showexternals: STRING is			"Externals";
	m_Showexternals: STRING is			"Ex&ternals";
	f_Showflat: STRING is				"Flat";
	m_Showflat: STRING is				"&Flat";
	f_Showfs: STRING is					"Flat/short";
	m_Showfs: STRING is					"Flat/s&hort";
	a_Showfuture: STRING is				"versions";
	f_Showfuture: STRING is				"Descendant versions";
	m_Showfuture: STRING is				"&Descendant versions";
	f_Showhistory: STRING is			"Implementers";
	m_Showhistory: STRING is			"&Implementers";
	f_Showindexing: STRING is			"Indexing clauses";
	m_Showindexing: STRING is			"&Indexing clauses";
	f_Showmodified: STRING is			"Modified classes";
	m_Showmodified: STRING is			"&Modified classes";
	f_Show_feature: STRING is			"Show feature";
	m_Show_feature: STRING is			"Show &feature";
	f_Show_object: STRING is			"Show object";
	m_Show_object: STRING is			"Show &object";
	f_Showonces: STRING is				"Once/Constants";
	m_Showonces: STRING is				"&Once/Constants";
	f_Showoncefunc: STRING is			"`Once' functions";
	m_Showoncefunc: STRING is			"`&Once' functions";
	f_Showpast: STRING is				"Ancestor versions";
	m_Showpast: STRING is				"&Ancestor versions";
	f_Showroutines: STRING is			"Routines";
	m_Showroutines: STRING is			"&Routines";
	f_Showshort: STRING is				"Short";
	m_Showshort: STRING is				"&Short";
	f_Showstatistics: STRING is			"Statistics";
	m_Showstatistics: STRING is			"&Statistics";
	f_Showhomonyms: STRING is			"Homonyms";
	m_Showhomonyms: STRING is			"&Homonyms";
	f_Showstops: STRING is				"Stop points";
	m_Showstops: STRING is				"Stop &points";
	f_Showsuppliers: STRING is			"Suppliers";
	m_Showsuppliers: STRING is			"&Suppliers";
	a_Showtext: STRING is				"Ctrl<Key>t";
	f_Showtext: STRING is				"Text";
	m_Showtext: STRING is				"&Text%TCtrl+T";
	f_Slice: STRING is					"Slice";
	m_Slice: STRING is					"S&lice";
	f_Stoppable: STRING is				"Stoppable";
	m_Stoppable: STRING is				"&Stoppable";
	f_System: STRING is					"System";
	m_System: STRING is					"&System tool";
	a_Update: STRING is					"Ctrl<Key>m";
	f_Update: STRING is					"Melt";
	m_Update: STRING is					"&Melt%TCtrl+M";
	f_Up_stack: STRING is				"Go up one level";
	m_Up_stack: STRING is				"Go &up one level";
	m_Validate: STRING is				"&Validate";
	m_Version: STRING is				"&Version";

feature -- Menu mnenomics

	m_Category: STRING is				"&Category";
	m_Class_tools: STRING is			"&Class tools";
	m_Commands: STRING is				"&Commands";
	m_Compile: STRING is				"&Compile";
	m_C_Compilation: STRING is			"C Com&pilation";
	m_Document: STRING is				"&Documentation";
	m_Debug: STRING is					"&Debug";
	m_Edit: STRING is					"&Edit";
	m_Explain_tools: STRING is			"&Explain tools";
	m_Feature: STRING is				"&Feature";
	m_Feature_tools: STRING is			"&Feature tools";
	m_File: STRING is					"&File";
	m_Formats: STRING is				"F&ormats";
	m_Object: STRING is					"&Object";
	m_Object_tools: STRING is			"&Object tools";
	m_Special: STRING is				"&Special";
	m_Windows: STRING is				"&Windows";

feature -- Label texts

	l_Active_query: STRING is			"Active query";
	l_Add: STRING is					"Add:";
	l_Change_operator: STRING is		"Change operator";
	l_Cluster: STRING is				"Cluster:";
	l_Compile_type: STRING is			"Compile type";
	l_File_name: STRING is				"File name: ";
	l_Inactivate: STRING is				"Inactivate";
	l_Inactive_subqueries: STRING is	"Inactive subqueries";
	l_Input_file: STRING is				"Input file";
	l_Language_type: STRING is			"Language type";
	l_Non_clickable_showstops: STRING is "Non clickable stop points";
	l_Output_switches: STRING is		"Output switches";
	l_Query: STRING is					"Query";
	l_Reactivate: STRING is				"Reactivate";
	l_Results: STRING is				"Results";
	l_Select_profiler: STRING is		"Select used profiler";
	l_Showallcallers: STRING is			"Show all callers";
	l_Showcallers: STRING is			"Show static callers";
	l_Showstops: STRING is				"Show stoppoints";
	l_Specify_arguments: STRING is		"Specify arguments";
	l_Subquery: STRING is				"Define new subquery";

feature -- Widget names

	n_Command_bar_name: STRING is		"Command bar";
	n_Format_bar_name: STRING is		"Format bar";
	n_X_resource_name: STRING is		"ebench";

feature -- Stone names

	s_Class_stone: STRING is			"Class";
	s_Explain_stone: STRING is			"Explanation";
	s_Object_stone: STRING is			"Object";
	s_Routine_stone: STRING is			"Feature";
	s_Showstops: STRING is				"Show stoppoints";
	s_System: STRING is					"System";

feature -- Title part

	t_Ace_builder: STRING is			"Ace builder";
	t_All_callers: STRING is			"All callers of ";
	t_Argument_w: STRING is				"Execution arguments";
	t_Ancestors_of: STRING is			"Ancestors of class ";
	t_Attributes_of: STRING is			"Attributes of class ";
	t_Attrvalues_of: STRING is			"Attributes of ";
	t_Browse: STRING is					"Browse...";
	t_Callers: STRING is				"Callers of ";
	t_Class_list_of: STRING is			"Classes in universe ";
	t_Click_form_of: STRING is			"Clickable form of class ";
	t_Clients_of: STRING is				"Clients of class ";
	t_Clusters_hierarchy: STRING is		"Cluster Hierarchy";
	t_Clusters_of: STRING is			"Clusters in universe ";
	t_Configuration_error: STRING is	"An error occured while loading the configuration for your profiler";
	t_Confirm: STRING is				"Please confirm";
	t_Custom_of: STRING is				"Custom view of class ";
	t_Deferreds_of: STRING is			"Deferred routines of class ";
	t_Descendants_of: STRING is			"Descendants of class ";
	t_Empty: STRING is					"";
	t_Empty_class: STRING is			"Empty class tool";
	t_Empty_explain: STRING is			"Empty explain tool";
	t_Empty_object: STRING is			"Empty object tool";
	t_Empty_routine: STRING is			"Empty feature tool";
	t_Exported_of: STRING is			"Exported features of ";
	t_Externals_of: STRING is			"Externals of class ";
	t_File_selection: STRING is			"File selection";
	t_Filter_w: STRING is				"Filter selection";
	t_Find: STRING is					"Find";
	t_Flat_form_of: STRING is			"Flat form of class ";
	t_Feature_flat_form_of: STRING is	"Flat form of feature ";
	t_Flatshort_form_of: STRING is		"Interface of class ";
	t_Future: STRING is					"Descendant versions of ";
	t_Generation_options: STRING is		"Generation options...";
	t_History: STRING is				"Implementers of ";
	t_Homonyms_of: STRING is			"Homonyms of ";
	t_Indexing_of: STRING is			"Indexing clauses of classes in universe ";
	t_Modified_of: STRING is			"Modified classes in universe ";
	t_Name_chooser: STRING is			"Name chooser...";
	t_New_class: STRING is				"New class";
	t_New_project: STRING is			"New project";
	t_Non_clickable_stoppoints_of: STRING is "Non clickable stop points";
	t_Onces_of: STRING is				"`Once/Constant' routines of class ";
	t_Oncefunc_of: STRING is			"`Once' functions of ";
	t_Past: STRING is					"Ancestor versions of ";
	t_Print_to_file: STRING is			"Print to file";
	t_Postscript: STRING is				"PostScript";
	t_Project: STRING is				"ISE EiffelBench";
	t_Profile_tool: STRING is			"Profile tool";
	t_Profile_query_window: STRING is	"Profile query window";
	t_Preference_tool: STRING is		"Preference tool";
	t_Routines_of: STRING is			"Routines of class ";
	t_Select_class: STRING is			"Select class";
	t_Select_class_version: STRING is	"Select class version";
	t_Select_color: STRING is			"Select color";
	t_Select_feature: STRING is			"Select feature";
	t_Select_object: STRING is			"Select object";
	t_Shell_command: STRING is			"Shell Command: ";
	t_Suppliers_of: STRING is			"Suppliers of class ";
	t_Routine_custom_tool: STRING is	"Routine custom tool";
	t_Search: STRING is					"Search";
	t_Select_a_file: STRING is			"Select a file";
	t_Select_a_directory: STRING is		"Select a directory";
	t_Shell_w: STRING is				"Shell command";
	t_Short_form_of: STRING is			"Short form of class ";
	t_Stoppoints_of: STRING is			"Stop points of ";
	t_Slice_w: STRING is				"Special object slice";
	t_Statistics_of: STRING is			"Statistics of system ";
	t_System: STRING is					"System";
	t_Warning: STRING is				"Warning";
	f_Workbench_mode: STRING is			"Workbench mode";
	m_Workbench_mode: STRING is			"&Workbench mode";

end -- class INTERFACE_NAMES
	

