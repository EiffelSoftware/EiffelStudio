-- Names given for undoable commands inserted
-- into history list.
class COMMAND_NAME_CONSTANTS

feature -- Application commands

	App_add_line_cmd_name: STRING is "Add Line";
	App_add_state_cmd_name: STRING is "Add State";
	App_add_sub_cmd_name: STRING is "Add Sub-Application";
	App_change_size_cmd_name: STRING is "Change Size";
	App_cut_label_cmd_name: STRING is "Cut Label";
	App_cut_line_cmd_name: STRING is "Cut Line";
	App_cut_state_cmd_name: STRING is "Cut State";
	App_cut_application_cmd_name: STRING is "Cut Sub-Application";
	App_edit_state_cmd_name: STRING is "Edit State";
	App_move_figure_cmd_name: STRING is "Move Figure";
	App_resize_figure_cmd_name: STRING is "Resize Figure";
	App_set_initial_state_cmd_name: STRING is "Initial State";
	App_set_exit_cmd_name: STRING is "Set Exit";
	App_set_return_cmd_name: STRING is "Set Return";
	App_set_state_cmd_name: STRING is "Set State";
	App_update_transitions_cmd_name: STRING is "Update Transition";

feature -- Context commands

	Cont_alignment_cmd_name: STRING is "Alignment";
	Cont_arrow_cmd_name: STRING is "Arrow direction";
	Cont_bg_color_cmd_name: STRING is "Background color";
	Cont_bg_pixmap_cmd_name: STRING is "Pixmap name";
	Cont_colors_cmd_name: STRING is "Colors";
	Cont_cut_cmd_name: STRING is "Cut";
	Cont_cut_group_type_cmd_name: STRING is "Cut group";
	Cont_create_cmd_name: STRING is "Create context";
	Cont_drawing_box_cmd_name: STRING is "Drawing area size";
	Cont_fg_color_cmd_name: STRING is "Foreground color";
	Cont_font_cmd_name: STRING is "Font";
	Cont_geometry_cmd_name: STRING is "Geometry";
	Cont_group_cmd_name: STRING is "Group creation";
	Cont_label_alignment_cmd_name: STRING is "Text alignment";
	Cont_label_resize_cmd_name: STRING is "Resize policy";
	Cont_label_text_cmd_name: STRING is "Set text";
	Cont_list_count_cmd_name: STRING is "Visible item count";
	Cont_list_select_cmd_name: STRING is "Selection mode";
	Cont_menu_cmd_name: STRING is "Set title";
	Cont_perm_icon_name_cmd_name: STRING is "Set icon name";
	Cont_perm_icon_cmd_name: STRING is "Set icon pixmap";
	Cont_perm_iconic_cmd_name: STRING is "Iconic state";
	Cont_perm_resize_cmd_name: STRING is "Resize policy";
	Cont_perm_shown_cmd_name: STRING is "Start hidden";
	Cont_perm_title_cmd_name: STRING is "Set title";
	Cont_pict_clr_cmd_name: STRING is "Pixmap name";
	Cont_pulldown_cmd_name: STRING is "Button text";
	Cont_pulldown_resize_cmd_name: STRING is "Resize_policy";
	Cont_resize_cmd_name: STRING is "Resize policy";
	Cont_scale_dir_cmd_name: STRING is "Scale direction";
	Cont_scale_gran_cmd_name: STRING is "Granularity";
	Cont_scale_max_cmd_name: STRING is "Maximum value";
	Cont_scale_max_right_cmd_name: STRING is "Maximum position";
	Cont_scale_min_cmd_name: STRING is "Minimum value";
	Cont_scale_output_cmd_name: STRING is "Output only";
	Cont_scale_show_cmd_name: STRING is "Show value";
	Cont_scale_text_cmd_name: STRING is "Set text";
	Cont_sep_dir_cmd_name: STRING is "Separator direction";
	Cont_sep_line_cmd_name: STRING is "Line style";
	Cont_set_position_cmd_name: STRING is "Set position";
	Cont_set_size_cmd_name: STRING is "Set size";
	Cont_temp_resize_cmd_name: STRING is "Resize policy";
	Cont_temp_shown_cmd_name: STRING is "Start hidden";
	Cont_temp_title_cmd_name: STRING is "Set title";
	Cont_text_field_cmd_name: STRING is "Maximum size";
	Cont_text_h_resize_cmd_name: STRING is "Height resizeable";
	Cont_text_height_cmd_name: STRING is "Margin height";
	Cont_text_max_cmd_name: STRING is "Maximum size";
	Cont_text_read_cmd_name: STRING is "Read only";
	Cont_text_w_resize_cmd_name: STRING is "Width resizeable";
	Cont_text_width_cmd_name: STRING is "Margin width";
	Cont_text_wrap_cmd_name: STRING is "Word wrap";
	Cont_toggle_arm_cmd_name: STRING is "Toggle arm";
	Cont_win_position_cmd_name: STRING is "Set default position";

feature -- Function commands

	Func_cut_elements_cmd_name: STRING is "Cut Elements";
	Func_drop_cmd_name: STRING is "Drop";
	Func_edit_cmd_name: STRING is "Edit Function";
	Func_merge_cmd_name: STRING is "Merge";
	Func_set_element_cmd_name: STRING is "Set Element";
	Func_wipe_out_cmd_name: STRING is "Wipe out";

feature -- Catalog commands

	Cat_swap_page_cmd_name: STRING is "Swap";
	Cat_cut_cmd_name: STRING is "Cut";
	Cat_edit_cmd_name: STRING is "Edit";
	Cat_new_cmd_name: STRING is "New";

feature -- Command Editor commands

	Cmd_add_arg_and_create_cmd_name: STRING is "Create command by adding argument";
	Cmd_add_argument_cmd_name: STRING is "Add Argument";
	Cmd_add_label_cmd_name: STRING is "Add Label";
	Cmd_create_instance_cmd_name: STRING is "Create instance";
	Cmd_cut_arg_and_create_cmd_name: STRING is "Create command by cutting argument";
	Cmd_cut_argument_cmd_name: STRING is "Cut Argument";
	Cmd_cut_parent_cmd_name: STRING is "Cut parent";
	Cmd_cut_label_cmd_name: STRING is "Cut Label";
	Cmd_instantiated_cmd_name: STRING is "Instantiated";
	Cmd_set_parent_cmd_name: STRING is "Set parent";
	Cmd_non_undoable_cmd_name: STRING is "Non-undoable command";
	Cmd_undoable_cmd_name: STRING is "Undoable command";

feature -- Command Instance commands

	Cmd_add_observer_cmd_name: STRING is "Add observer";
	Cmd_remove_observer_cmd_name: STRING is "Remove observer";

feature -- Misc commands

	Generate_tool_cmd_name: STRING is "Generate tool for"
	Import_cmd_name: STRING is "Import";
	Set_visual_name_cmd_name: STRING is "Set visual name";

end
