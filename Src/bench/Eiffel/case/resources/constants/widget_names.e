indexing

	description:
		"Names given to widgets in the interface.";
	date: "$Date$";
	revision: "$Revision$"

class WIDGET_NAMES

feature -- Names for widget type

	Base: STRING is "base";
	Bar: STRING is "bar";
	Bulletin: STRING is "bulletin";
	Button: STRING is "button";
	Button1: STRING is "button1";
	Button2: STRING is "button2";
	Button3: STRING is "button3";
	Button4: STRING is "button4";
	Button5: STRING is "button5";
	Button6: STRING is "button6";
	Button7: STRING is "button7";
	Button8: STRING is "button8";
	Button9: STRING is "button9";
	Button10: STRING is "button10";
	Check_box: STRING is "check_box";
	Check_box1: STRING is "check_box1";
	Check_box2: STRING is "check_box2";
	Command_editor: STRING is "command_tool";
	drawing: STRING is "Drawing";
	forget_ch: STRING is "forget changes";
	Form: STRING is "form";
	Form1: STRING is "form1";
	Form2: STRING is "form2";
	Form3: STRING is "form3";
	Form4: STRING is "form4";
	Frame: STRING is "frame";
	Frame1: STRING is "frame1";
	Label: STRING is "Label";
	Label1: STRING is "label1";
	Label2: STRING is "label2";
	Label3: STRING is "label3";
	Label4: STRING is "label4";
	List: STRING is "list";
	List1: STRING is "list1";
	List2: STRING is "list2";
	Menu: STRING is "menu";
	Menu1: STRING is "menu1";
	Menu2: STRING is "menu2";
	Menu_b: STRING is "menu_b";
	Menu_b1: STRING is "menu_b1";
	Menu_b2: STRING is "menu_b2";
	Menu_b3: STRING is "menu_b3";
	Menu_b4: STRING is "menu_b4";
	Menu_b5: STRING is "menu_b5";
	Radio_box: STRING is "radio_box";
	Radio_box1: STRING is "radio_box1";
	Rowcolumn: STRING is "row_column";
	Row_column: STRING is "row_column";
	Row_column1: STRING is "row_column1";
	Row_column2: STRING is "row_column2";
	Scroll: STRING is "scroll";
	Scroll1: STRING is "scroll1";
	Scroll2: STRING is "scrolli2";
	Separator: STRING is "separator";
	Separator1: STRING is "separator1";
	Separator2: STRING is "separator2";
	Separator3: STRING is "separator3";
	Tbutton1: STRING is "t_button1";
	Tbutton2: STRING is "t_button2";
	active_class: STRING is "Active class: "
	text: STRING is "Text"
	Text1: STRING is "text1";
	Text2: STRING is "text2";
	Text3: STRING is "text3";
	Textfield: STRING is "textfield";
	Toggle: STRING is "toggle";
	Toggle1: STRING is "toggle1";
	Toggle2: STRING is "toggle2";
	Toggle3: STRING is "toggle3";
	Toggle4: STRING is "toggle4";
	Toggle5: STRING is "toggle5";
	Toggle6: STRING is "toggle6";
	Toggle7: STRING is "toggle7";
	Topshell: STRING is "topshell"; 
	Scrolledwindow: STRING is "scrolledwindow";
	Scale: STRING is "Scale";
	Scrol: STRING is "Scrolled_list"

feature -- Names for Main Panel
	cluster: STRING is "Cluster"
	class_editor: STRING is "Class"
	relation:STRING is "Relation"
	Hide_linkable:STRING is "Hidden Components"
	Namer:STRING is "Namer"
	Create_proj:STRING  is "Create project"	
	Open_proj:STRING is "Open"
	Save_proj:STRING is "Save"
	Save_proj_as:STRING is "Save as"
	Quit_case:STRING is "Quit EiffelCase"
	gene_eiff:STRING is "Code generation"
	Print_tool:STRING is "Print tool"
	View_tool:STRING is "View tool"
	deletion_hole	: STRING	is "Deletion Hole"

feature -- text field & co
	class_name : STRING is "Class name"
	aa2 : STRING is "Feature name"
	aa3 : STRING is "Class/cluster name"
	target_name_tool : STRING is "Target Name Tool"
	aa5 : STRING is "Generic parameter name"
	aa6 : STRING is "Class at the beginning of link"
	aa7 : STRING is "Class at the end of link"

feature -- system window
	ed_com : STRING is "Class"
	ed_cl : STRING is "Cluster"
	sc : STRING is "System classes/clusters"
	chart : STRING is "Chart"
	cd : STRING is "Show class dictionary"
	mc : STRING is "Modified class"
	gp : STRING is "Go to next page"
	gpr : STRING is "Go to previous page"
	gf: STRING is "Go to first page"
	gl: STRING is "Go to last page"
	components: STRING is "Components"
	dictionary: STRING is "Dictionary"

feature -- relations click page
	q2: STRING is "Add relation"
	q1: STRING is "Uncompress relation"

feature -- namer window
	aa:STRING is "Apply settings"
	bb:STRING is "Namer"
	name_hole: STRING is "Name hole"

feature -- cluster print window
	print_label:STRING is "Print"
	print_to_file:STRING is "Print to file"
	ee:STRING is "lili"
	print_color:STRING is "Select color"

feature -- relation windows...
	t1:STRING is "Relation"
	t2:STRING is "Class"
	t4:STRING is "Label"
	t5:STRING is "Markers"
	t6:STRING is "Show implementation"
	t7:STRING is "Decompress in two links"
	remove_handle:STRING is "Remove all handles"
	handles: STRING is "Handles"
	left_handle: STRING is "Place Left-Bottom Handle Corner"
	right_handle: STRING is "Place Right-Bottom Handle Corner"

feature -- Class click page
	add_inde: STRING is "Add index"
	add_g: STRING is "Add generic"
	add_fe : STRING is "Add feature"
	add_c_f : STRING is "Add clause"
	add_inv : STRING is "Add invariant"
	pr_to: STRING is "Print Tool"
	query: STRING is "Add query"
	add_com : STRING is "Add command"
	add_cons: STRING is "Add constraint"

feature -- Names for Namer Window
	l1:STRING is "Namer"
	l2:STRING is "Apply settings"

feature -- Preference windows
	apply_pr: STRING is "Apply preferences"
	print_command: STRING is "Print Command"
	notation: STRING is "Notation"
			
feature -- Names for Focus Label

	Focus_label: STRING is "Focus label"
	Quit_button: STRING is "Quit"
	Close: STRING is "Close"

feature -- Feature clause window
	p1: STRING is "aaa"
	p2: STRING is "Export"
	p3:STRING is " Comments"
	p4:STRING is "ddd"
	p5:STRING is "OK"
	p6:STRING is "FFF"
	p7:STRING is "Refresh editor"
	p8:STRING is "HHH"
	p9:STRING is "III"

feature -- feature_window
	r1: STRING is "Class"
	r2: STRING is "Feature"
	r3: STRING is "Show eiffel code"
	specification: STRING is "Specification"
	r5: STRING is "uu"

feature -- Feature click page
	add_arg: STRING is "Add argument"
	add_pre: STRING is "Add precondition"
	add_post: STRING is "Add postcondition"


feature -- generate eiffel window
	s1 : STRING is "Code generation"


feature -- Documentation Window
	stf : STRING is "Print text"
	sgf : STRING is "Print graphics"
	cluster_to_generate: STRING is "Add all clusters to generate_list"
	cluster_to_exclusion: STRING is "Move all clusters to exclusion list"
	format: STRING is "Format"

feature -- Cluster chart window
	add_index : STRING is "Add index"
	
feature -- View Window

	New_view: STRING is "New view";

feature -- Misc (more than one window share these names)

	Directory_for: STRING is "Directory name: ";
	Done: STRING is "Done";
	Generate_to: STRING is "Generate to :";
	Reverse_eng_path: STRING is "Eiffel directory path:";
	Yes: STRING is "Yes";
	No: STRING is "No";
	Ok: STRING is "OK";
	Cancel: STRING is "Cancel";
	Shell_command: STRING is "Shell command: ";
	Test_printer: STRING is "Test printer: ";
	To_do: STRING is "To do";
	Clusters_to_print: STRING is "Generate these clusters : ";
	Clusters_not_to_print: STRING is "Exclude these clusters : ";

feature -- Window names

	Class_window: STRING is "Class";
	Cluster_chart_window: STRING is "Chart";
	Cluster_dir_name_window: STRING is "Cluster directory Names";
	Color_window: STRING is "Color";
	Error_window: STRING is "Error";
	Feature_window: STRING is "Feature";
	Feature_clause_window: STRING is "Feature clause";
	File_box: STRING is "File box";
	Generate_window: STRING is "Generate code";
	Generate_doc: STRING is "Documentation generation";
	Help_window: STRING is "Help";
	Hidden_entity_window: STRING is "Hidden Components";
	History_window: STRING is "History";
	Question_window: STRING is "Warning";
	eiffelcase: STRING is "EiffelCase 4.5";
	Message_window: STRING is "Message";
	Merging_tool: STRING is "Merging tool";
	Mp_print_window: STRING is "Documentation";
	Namer_window: STRING is "Name";
	Preference_tool: STRING is "Preference Tool";
	Print_window: STRING is "Print Graph";
	Relation_tool: STRING is "Relation Tool";
	System_tool: STRING is "System Tool";
	View: STRING is "View";

feature -- Project Window

	Create_project: STRING is "Create project";
	Directories: STRING is "Directories";
	Retrieve_project: STRING is "Retrieve project";
	Projects: STRING is "Projects";
	Delete: STRING is "Delete";
	Save_project_as: STRING is "Save project as";
	Selection: STRING is "Selection"

feature -- Names for Main panel

	Visibility: STRING is "Visibility";
	History: STRING is "History";
	Preferences: STRING is "Preferences";
	System: STRING is "System";
	Help: STRING is "Help";
	Main_graph_area: STRING is "System architecture"

feature -- Preference Window

	Grid_settings: STRING is "Grid settings";
	Show_bon: STRING is "BON Notation";
	show_uml: STRING is "UML Notation"
	grid_visible: STRING is "Grid Visible";
	Snap: STRING is "Snap";
	Spacing: STRING is "Spacing";

feature -- Main Panel Print Window

	Generate_to_file: STRING is "Print to file";
	Generate_to_printer: STRING is "Print";
	Cluster_charts: STRING is "Cluster charts";
	Class_charts: STRING is "Class charts";
	Class_specification: STRING is "Class specification";
	Class_dictionary: STRING is "Class dictionary";
	Directory: STRING is "Directory";
	File: STRING is "File";
	printer	: STRING	is "Printer"
	Select_a_filter: STRING is "Select a filter";
	System_chart: STRING is "System chart";

feature -- Generate Window

	Case_project: STRING is "Case project";
	Eiffel_project: STRING is "Eiffel project";
	destination: STRING is "Destination"
	generation_tool: STRING is "Generation Tool"

feature -- Class & Feature Window

	Constant: STRING is "Constant";
	D_eferred: STRING is "Deferred ";
	Effective: STRING is "Effective ";
	O_nce: STRING is "Once";
	properties: STRING is "Properties"
	edit: STRING is "Edit"

feature -- Class Window

	Filename: STRING is "File Name: ";
	Interfaced: STRING is "Interfaced ";
	Root: STRING is "Root ";
	Persistent: STRING is "Persistent ";
	Reused: STRING is "Reused ";
	expand: STRING is "Expanded ";
	ex_port: STRING is "Export"
	add_export: STRING is "Select export"
	k1: STRING is "Class"
	k2:STRING is "Export"
	k3:STRING is "Feature"
	k4:STRING is "Annotations"
	k5:STRING is "Chart"
	k6:STRING is "Specifications"
	k7:STRING is "Show Eiffel code"
	features:STRING is "Features"
	relations:STRING is "Relations"
	k10:STRING is "Modified features"
	add_gene:STRING is "Add generic"
	exit: STRING is "Exit"
	cloning_hole: STRING is "Cloning Hole"
	class_hole: STRING is "Class Hole"
	feature_hole: STRING is "Feature Hole"
	import_indexing: STRING is "Import Indexing"
	default_label: STRING is "Default"
	eiffel_code: STRING is "Eiffel Code"
	basic_information: STRING is "Basic Information"

feature -- Feature Window

	Attribute: STRING is "Attribute";
	Comments: STRING is "Comments";
	F_rom: STRING is "from";
	Private: STRING is "Private";
	Redefined: STRING is "Redefined";
	R_esult: STRING is "Result";
	R_ename: STRING is "Rename";

feature -- Relation Window

	Shared: STRING is "Shared";
	X_offset: STRING is "X offset: ";
	Y_offset: STRING is "Y offset: ";
	T_o: STRING is "to";
	double_link: STRING is "Double Link";
	hide_link: STRING is "Hide Link";
	Link: STRING is "Link";
	Reverse_Link_information: STRING is "Reverse link's information";
	Multiplicity: STRING is "Multiplicity"
	Left: STRING is "Left"
	Right_side: STRING is "Right side";
	One_line_only: STRING is "One line only";
	window: STRING is "Window"
	save_size: STRING is "Save Size"
	relation_hole: STRING is "Relation Hole"
	change_side: STRING is "Change Side"
	hide_label: STRING is "Hide Label"


feature -- Cluster Window
	n6:STRING is "Go to the upper left"
	n2:STRING is "Go to top"
	n8:STRING is "Go to upper right"
	n4:STRING is "Go to the left"
	n1:STRING is "Go to center"
	n5:STRING is "Go to the right"
	n7:STRING is "Go to the lower left"
	n3:STRING is "Go to bottom"
	n9:STRING is "Go to the lower right"
	iconify:STRING is "Iconify/deiconify cluster"
	compr:STRING is "Compress/uncompress link"
	retarget_to_parent:STRING is "Retarget to parent"
	direc:STRING is "Cluster directory name"
	graph:STRING is "Print (postscript)"
	clus_chart:STRING is "Chart"
	color:STRING is "Color tool"
	clu_cre:STRING is "Cluster"
	cla_cre:STRING is "Class"
	client: STRING is "Client"
	agg:STRING is "Aggregation"
	inh:STRING is "Inheritance"
	hs_aggregation:STRING is "Hide/Show Aggregation"
	hs_client_links:STRING is "Hide/Show Client Links"
	hs_inheritance:STRING is "Hide/Show Inheritance"
	hs_labels:STRING is "Hide/Show Labels"
	hs_implementation:STRINg is "Hide/Show Implementation"
	automatic_save	: STRING	is "Automatic Save"
	advanced_color_tool	: STRING	is "Advanced Color Tool"
	client_links	: STRING	is "Client Links"
	aggregation_link	: STRING	is "Aggregation Link"
	inheritance_link	: STRING	is "Inheritance Link"
	right_angles: STRING is "Right Angles"
	both: STRING is "Both"
	redo: STRING is "Redo"
	undo: STRING is "Undo"
	recent_systems: STRING is "Recent Sytems"
	open_project: STRING is "Open Project"
	import_cluster: STRING is "Import Cluster"
	import_glossary: STRING is "Import Glossary"
	html_generation: STRING is "HTML Generation"
	editor: STRING is "Editor: "
	generate_eiffel_whole_system: STRING is "Generate Eiffel (Whole System)"
	generate_eiffel_this_cluster: STRING is "Generate Eiffel (This Cluster)"
	resizing: STRING is "Resizing"
	modify_height: STRING is "Modify Height"
	modify_width: STRING is "Modify Width"
	automatic_resizing: STRING is "Automatic Resizing"
	options: STRING is "Options"
	gather: STRING is "Gather"
	up: STRING is "Up"
	up_left: STRING is "Up Left"

feature -- Question Box

	Discard_name: STRING is "Discard";
	New_choice_name: STRING is "New choice";
	Open: STRING is "Open";

feature -- Merging window

	Case_version: STRING is "EiffelCase version"
	Case_label	: STRING is "EiffelCase"
	Code_version: STRING is "Eiffel text version"
	code_label: STRING is "Eiffel text"
	merging: STRING is "Merging: class ";
	Feature_clause_merging: STRING is "Feature clause merging: class ";
	Only_eiffel_version:STRING is "Retain Eiffel text versions for all"
	Only_case_version:STRING is "Retain EiffelCase versions for all";
	Add_selection:STRING is "Add selection"
	Remove_selection:STRING is "Remove selection";
	Quit_Merging_window:STRING is "Quit merging window";
	Show_class_differences: STRING is "Show class differences"
	Show_statistics: STRING is "Show statistics";
	first_class: STRING is "First class"
	previous_class: STRING is "Previous class"
	next_class:STRING is "Next class"
	last_class:STRING is "Last class"
	first_class_dif:STRING is "First feature" 
    	previous_feature:STRING is "Previous feature"
    	next_feature:STRING is "Next feature"
    	last_class_dif:STRING is "To last feature" 
	accep_class_dif:STRING is "Retain selected EiffelCase version"
	rejec_class_dif:STRING is "Retain selected Eiffel text" 
	apply_ch:STRING is "Apply selections (no undo)"
	reset_all_for_class:STRING is "Reset all for class"
	forget_all_ch:STRING is "Reset all classes" 
	retain: STRING is "Retain"
	retain_selected_eiffel_case_version: STRING is "Retain selected EiffelCase version"
	retain_selected_eiffel_text: STRING is "Retain selected Eiffel text"
	select_eiffel_case_version: STRING is "Select EiffelCase version"
	select_eiffel_text: STRING is "Select Eiffel text version"
	next_differing_item_in_class: STRING is "Next differing item in class"
	previous_differing_item_in_class: STRING is "Previous differing item in class"
	selection_for_other_clauses: STRING is "Selection for other clauses (no undo):"
	inheritance: STRING is "Inheritance"
	invariant_label: STRING is "Invariant clause:"
	indexing_label: STRING is "Indexing clause:"
	generic_parameters: STRING is "Generic parameters:"
	select_version: STRING is "Select a version:"
	highlighted_feature: STRING is "Highlighted feature:"
	classes_already_reconciled: STRING is "Classes already reconciled"
	classes_remaining: STRING is "Classes remaining"
	everything: STRING is "Everything:"
	

feature -- kind of realtion, new_window
	
	generate: STRING is "Generate" 
	add_nw:STRING is "Add" 
	kind_of_relation:STRING is "Code generation for client link"
	attrib_nw:STRING is " Attribute"  
	function:STRING is " Function"
	nogen_nw:STRING is "No generation"
	client_of_nw:STRING is "is client of"
	label1_nw:STRING is "Add to"
	cancel_nw:STRING is "Cancel client link"
	type:STRING is "Type"
	label1_gene:STRING is ", generic parameters:"
	add_ind:STRING is "Indexing clause"
	apply_change:STRING is "Apply additions "	
	new_features: STRING is "New Features"
	feature_type: STRING is "Feature Type :"

feature -- Feature clause window

	E_xport: STRING is "Export";

feature
	-- Menu Window

	class_menu: STRING is "Class Menu"

feature
	-- Color Window

	color_palette: STRING is "Color Palette"

feature
	-- Advanced Color Window

	color_label: STRING is "Color :"
	override: STRING is "Override previous coloring"
	restrict: STRING is "Restrict to same cluster"
	classes: STRING is "Classes"
	extend: STRING is "Extend to cluster"
	remove: STRING is "Remove"
	extend_tooltip: STRING is "Add to list all classes from cluster of selected class"
	remove_tooltip: STRING is "Remove selected class from list"
	reset: STRING is "Reset"
	apply: STRING is "Apply"
	supplier: STRING is "Supplier"
	parent: STRING is "Parent"
	heir: STRING is "Heir"

feature
	-- Ace Window

	browse: STRING is "Browse"
	flat_form: STRING is "Flat Form"

end -- class WIDGET_NAMES
