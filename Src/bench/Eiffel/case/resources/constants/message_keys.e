indexing

	description: 
		"Keys used to retrieve the help information from %
		%a resource file.";
	date: "$Date$";
	revision: "$Revision $"

class MESSAGE_KEYS 

creation
	make


feature -- Error Constant Keys

	another_reflexive_link_er: STRING is "E8";
	argument_name_exists_er: STRING is "E12";
	attribute_er: STRING is "Eb";					
	class_exists_er: STRING is "Ec";
	class_name_expected_er: STRING is "E22";
	cluster_deiconization_er: STRING is "Ed";		
	cluster_exists_er: STRING is "Ee";				
	cluster_doesnt_exists_er : STRING is "E33"
	cluster_moved_into_content_er: STRING is "E7";
	compress_link_er: STRING is "Ef";				
	not_find_com_link_er: STRING is "Eg";			
	create_cluster_er: STRING is "Eh";				
	dir_exists_er:STRING is "Ei";					
	empty_input_er: STRING is "E15";
	feature_exists_er: STRING is "Ej";				
	filename_exists_in_parent_cluster_er: STRING is "E10";
	generate_code_er:STRING is "Ek";				
	generic_exists_er: STRING is "El";				
	generic_name_exists_er: STRING is "E13";
	help_font_er:STRING is "Em";					
	illegal_characters_er: STRING is "En";			
	illegal_filename_er: STRING is "E14";
	illegal_input_er: STRING is "Eo";		
	invalid_class_name_er: STRING is "E21";
	letter_expected_er: STRING is "E23";
	not_dirty_before_exit_er: STRING is "E24";
	no_matching_classes_er: STRING is "E16";
	no_matching_clusters_er: STRING is "E17";
	no_matching_features_er: STRING is "E18";
	no_matching_relations_er: STRING is "E19";
	resize_cluster_er:STRING is "Ep";				
	print_doc_er:STRING is "Eq";
	problem_creation: STRING is "E32"					
	read_er:STRING is "Er";							
	relation_not_found_er: STRING is "E20";
	reparent_cluster_er:STRING is "Es";				
	reparent_figure_er: STRING is "E9";
	reparent_figure_filename_er: STRING is "E11";
	root_class_exists_er: STRING is "Et";			
	retrieve_operating_system_er:STRING is "Eu";	
	retrieve_proj_er:STRING is "Ev";				
	rescue_er:STRING is "Ew";						
	stone_invalid_er: STRING is "Ex";				
	store_operating_system_er:STRING is "Ey";		
	store_proj_er:STRING is "Ez";					
	store_view_er:STRING is "E1";					
	valid_proj_name_er:STRING is "E2";				
	view_name_exists_er:STRING is "E3";				
	workarea_hidden_class:STRING is "E4";			
	write_er:STRING is "E5";						
	write_to_dir_er:STRING is "E6";					

feature -- Message keys

	all_merged_msg: STRING is "Ma";

feature -- Help keys

	abstract_entity_k: STRING is "AA";			
	accept_class_diff_k: STRING is "EF";
	add_argument_k: STRING is "AB";				
	add_command_k: STRING is "AC";				
	add_comment_k: STRING is "AD";				
	add_constraint_k: STRING is "AE";			
	add_description_k: STRING is "AF";			
	add_feature_k: STRING is "AG";
	add_feat_clause_k: STRING is "EQ";				
	add_generic_k: STRING is "AH";				
	add_index_k: STRING is "AI";				
	add_invariant_k: STRING is "AJ";			
	add_precondition_k: STRING is "AK";			
	add_postcondition_k: STRING is "AL";		
	add_query_k: STRING is "AM";				
	add_relation_k: STRING is "AN";
	all_rel_imp_vis_k: STRING is "DP"; 
	ancestor_format_k: STRING is "AO";			
	annotations_format_k: STRING is "AP";		
	aggreg_vis_k: STRING is "AQ";				
    apply_diff_changes_k: STRING is "EN";
	apply_k: STRING is "AR";
	case_version_of_class_k: STRING is "EV";
	chart_format_k: STRING is "AS";
	check_apply_k: STRING is "ET";
	class_diffs_k: STRING is "EK";
	class_diff_stats_k: STRING is "EL";
	class_merged_k: STRING is "EJ";
	class_entry_k: STRING is "AT";				
	class_hole_k: STRING is "AU";				
	client_vis_k: STRING is "AV";				
	cluster_entry_k: STRING is "AW";			
	cluster_file_name_k: STRING is "AX";		
	cluster_hole_k: STRING is "AY";				
	close_k: STRING is "AZ";
	code_version_of_class_k: STRING is "EW";
	color_window_k: STRING is "BA";
	comments_k: STRING is "EU";
	component_format_k: STRING is "BB";
	comp_link_hole_k: STRING is "BC";			
	compressed_format_k: STRING is "BD";		
	create_project_k: STRING is "BE";
	detailed_class_diff_stats_k: STRING is "EM";			
	dictionary_format_k: STRING is "BF";		
	down_arrow_k: STRING is "BG";				
	feature_clause_export_k: STRING is "ES";
	feature_clause_hole_k: STRING is "ER";
	feature_entry_k: STRING is "BH";			
	feature_hole_k: STRING is "BI";				
	features_format_k: STRING is "BJ";			
	first_class_k: STRING is "EH";
	first_class_diff_k: STRING is "EB";
	forget_all_diff_changes_k: STRING is "EP";
    forget_diff_changes_k: STRING is "EO";
	generate_code_k: STRING is "BK";			
	generate_print_k: STRING is "BL";			
	generate_format_k: STRING is "BN";			
	goto_end_k: STRING is "BO";					
	goto_start_k: STRING is "BP";				
	graphics_k: STRING is "BQ";					
	help_ff_k: STRING is "BR";					
	help_up_k: STRING is "BS";					
	help_rew_k: STRING is "BT";					
	help_toc_k: STRING is "BU";					
	iconize_hole_k: STRING is "BV";				
	inherit_vis_k: STRING is "BW";				
	last_class_k: STRING is "EI";
	last_class_diff_k: STRING is "EE";
	left_arrow_k: STRING is "BX";				
	left_down_arrow_k: STRING is "BY";			
	left_up_arrow_k: STRING is "BZ";			
	label_format_k: STRING is "CA";				
	label_vis_k: STRING is "CB";				
	print_documentation_k: STRING is "CC";		
	marker_format_k: STRING is "CD";			
	middle_graph_k: STRING is "CE";				
	modified_classes_since_last_re_k: STRING is "DX";
	modified_features_since_last_re_k: STRING is "DY";
	namer_k: STRING is "DW";					
	new_aggreg_k: STRING is "CF";				
	new_class_k: STRING is "CG";				
	new_client_k: STRING is "CH";				
	new_cluster_k: STRING is "CI";				
	new_inherit_k: STRING is "CJ";				
	next_class_k: STRING is "EA";
	next_class_diff_k: STRING is "ED";
	next_page_k: STRING is "CK";				
	not_print_click_text_k: STRING is "CL";			
	not_selected_clusters_k: STRING is "CL";		
	open_project_k: STRING is "CM";				
	previous_class_k: STRING is "DZ";
	previous_class_diff_k: STRING is "EC";
	previous_page_k: STRING is "CN";			
	print_click_text_k: STRING is "CO";			
	print_graphics_k: STRING is "CP";			
	print_document_k: STRING is "CQ";			
	print_to_file_k: STRING is "CR";			
	print_to_printer_k: STRING is "CS";			
	range_k: STRING is "CT";					
	relation_hole_k: STRING is "CU";			
	relations_format_k: STRING is "CV";			
	redo_k: STRING is "CW";						
	reject_class_diff_k: STRING is "EG";
	remove_handles_k: STRING is "DU";
	remove_relation_k: STRING is "CX";			
	remove_reverse_k: STRING is "CY";			
	reverse_eng_path_k: STRING is "AX";
	right_arrow_k: STRING is "CZ";				
	right_down_arrow_k: STRING is "DA";			
	right_up_arrow_k: STRING is "DB";			
	save_k: STRING is "DC";						
	save_as_k: STRING is "DD";					
	selected_aggreg_vis_k: STRING is "DS";
	selected_all_rel_imp_vis_k: STRING is "DE"; 
	selected_client_vis_k: STRING is "DT";
	selected_clusters_k: STRING is "CO";			
	selected_inherit_vis_k: STRING is "DR";
	selected_label_vis_k: STRING is "DQ";
	sort_hierarchy_k: STRING is "DF";			
	sort_features_k: STRING is "DG";			
	specification_format_k: STRING is "DH";		
	text_k: STRING is "DI";						
	trash_hole_k: STRING is "DJ";				
	quit_k: STRING is "DK";						
	undo_k: STRING is "DL";						
	unzoom_cluster_k: STRING is "DM";			
	up_arrow_k: STRING is "DN";					
	view_k: STRING is "DO";						

feature -- Warning Constant keys
	
	corrupted_wa: STRING  is "Wa";				
	create_wa: STRING is "Wn";
	delete_view_confirm_wa: STRING is "Wb";
	error_at_merging_wa: STRING is "Wr";
	forget_all_mergings_wa: STRING is "Wp";
	internal_error_wa: STRING is "Wc";
	merging_in_progress_wa: STRING is "Wq";
	open_wa: STRING is "Wd";			
	overwrite_proj_wa:STRING is "We";			
	project_exists_wa: STRING is "Wo";			
	quit_proj_wa: STRING is "Wf";				
	read_project_wa:STRING is "Wg";				
	read_file_wa:STRING is "Wh";				
	rescue_proj_wa:STRING is "Wi";				
	save_proj_wa:STRING is "Wj";				
	valid_delete_view_wa:STRING is "Wl";		
	valid_proj_name_wa:STRING is "Wm";			

end -- class MESSAGE_KEYS
