indexing
	description: "EiffelBuild pixmaps."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class PIXMAPS

inherit
	CONSTANTS
	SHARED_PLATFORM_CONSTANTS
	
feature -- General Pixmaps

	Alignment_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("align")
		end

	App_interior_stipple: EV_PIXMAP is
		once
			Result := symbol_file_content ("int_stip")
		end

	Attribute_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("attrib")
		end

	Behavior_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("behavior")
		end

	Behavior_dot_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("beh_dot")
		end

	Behavior_format_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("beh_frmt")
		end

 	Bg_color_stone_pixmap: EV_PIXMAP is
 		once
 			Result := symbol_file_content ("bg_clrst")
		end

 	Bg_pixmap_stone_pixmap: EV_PIXMAP is
 		once
 			Result := symbol_file_content ("bg_pxmap")
		end

		--| Containers

 	Cat_temp_wind_pixmap: EV_PIXMAP is
 		once
 			Result := symbol_file_content ("cat_tmpw")
 		end
 
 	Cat_perm_wind_pixmap: EV_PIXMAP is
 		once
 			Result := symbol_file_content ("cat_prmw")
 		end
 
 	Cat_bulletin_pixmap: EV_PIXMAP is
 		once
 			Result := symbol_file_content ("cat_bltn")
 		end
 
	Cat_vbox_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("cat_vbox")
		end

	Cat_hbox_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("cat_hbox")
		end

	Cat_table_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("cat_table")
		end

	Cat_notebook_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("cat_notebook")
		end

	Cat_frame_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("cat_frame")
		end

	Cat_scroll_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("cat_scroll")
		end

	Cat_hsplit_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("cat_vertisplit")
		end

	Cat_vsplit_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("cat_horizsplit")
		end

		--| Primitives

	Cat_label_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("cat_label")
		end

	Cat_button_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("cat_button")
		end

	Cat_toggle_b_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("cat_toggle")
		end

	Cat_check_b_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("cat_check")
		end

	Cat_radio_b_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("cat_radio")
		end

	Cat_vseparator_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("cat_vertisep")
		end

	Cat_hseparator_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("cat_horizsep")
		end

	Cat_draw_area_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("cat_drawing")
		end

		--| Menus
	
	Cat_static_bar_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("cat_staticbar")
		end

 	Cat_bar_pixmap: EV_PIXMAP is
 		once
 			Result := symbol_file_content ("cat_bar")
 		end

 	Cat_menu_pixmap: EV_PIXMAP is
 		once
 			Result := symbol_file_content ("cat_menu")
 		end

 	Cat_menu_item_pixmap: EV_PIXMAP is
 		once
 			Result := symbol_file_content ("cat_ment")
 		end

 	Cat_check_menu_pixmap: EV_PIXMAP is
 		once
 			Result := symbol_file_content ("cat_check")
 		end

 	Cat_radio_menu_pixmap: EV_PIXMAP is
 		once
 			Result := symbol_file_content ("cat_radio")
 		end
 
 	Cat_popup_menu_pixmap: EV_PIXMAP is
 		once
 			Result := symbol_file_content ("cat_popup")
 		end
 
 	Cat_opt_pull_pixmap: EV_PIXMAP is
 		once
 			Result := symbol_file_content ("cat_opul")
 		end

	Cat_status_bar_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("cat_status")
		end

	Cat_status_bar_item_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("cat_statitem")
		end

		--| Toolbars

	Cat_toolbar_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("cat_toolbar")
		end

	Cat_toolbar_button_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("cat_button")
		end

	Cat_toolbar_toggle_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("cat_toggle")
		end

	Cat_toolbar_radio_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("cat_radio")
		end

	Cat_toolbar_separator_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("cat_vertisep")
		end

		--| Text components

	Cat_text_field_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("cat_textfield")
		end

	Cat_passwd_field_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("cat_passwd")
		end

	Cat_combo_box_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("cat_combo")
		end

	Cat_list_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("cat_list")
		end

	Cat_list_item_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("cat_ment")
		end

	Cat_multi_col_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("cat_multi")
		end

	Cat_multi_col_row_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("cat_multirow")
		end

	Cat_tree_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("cat_tree")
		end

	Cat_tree_item_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("cat_treeitem")
		end

	Cat_rich_text_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("cat_richtext")
		end

	Cat_text_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("cat_text")
		end


 	Color_pixmap: EV_PIXMAP is
 		once
 			Result := symbol_file_content ("color")
		end

 	Color_stone_pixmap: EV_PIXMAP is
 		once
 			Result := symbol_file_content ("color_st")
		end

	Command_instance_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("instance")
		end

	Command_instance_dot_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("inst_dot")
		end

	Command_page_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("cmd_page")
		end

	Command_i_icon_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("cmd_inst")
		end

	Command_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("command")
		end

	Command_dot_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("cmd_dot")
		end

	Create_command_instance_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("crt_inst")
		end

	Create_project_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("crt_proj")
		end

 	Ear_pixmap: EV_PIXMAP is
 		once
 			Result := symbol_file_content ("ear")
		end

	EiffelBuild_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("ebuild")
		end

	Ev_label_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("ev_label")
		end

	Event_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("event")
		end

	Event_dot_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("evnt_dot")
		end

	Exit_label_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("exit_lbl")
		end

	Expand_parent_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("expand")
		end

	File_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("file")
		end

 	Fg_color_stone_pixmap: EV_PIXMAP is
 		once
 			Result := symbol_file_content ("fg_clrst")
		end

	Font_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("font")
		end

	Full_help_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("fullhelp")
		end

	General_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("general")
		end

	Generate_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("generate")
		end

	generated_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("generated")
		end

	Geometry_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("geometry")
		end

 	Grid_pixmap: EV_PIXMAP is
 		once
 			Result := symbol_file_content ("grid")
		end

 	Grid5_pixmap: EV_PIXMAP is
 		once
 			Result := symbol_file_content ("grid5")
		end

 	Grid10_pixmap: EV_PIXMAP is
 		once
 			Result := symbol_file_content ("grid10")
		end

 	Grid15_pixmap: EV_PIXMAP is
 		once
 			Result := symbol_file_content ("grid15")
		end

 	Grid20_pixmap: EV_PIXMAP is
 		once
 			Result := symbol_file_content ("grid20")
		end

	Help_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("help")
		end

	Import_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("import")
		end

	Initial_state_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("initl_st")
		end

	Load_project_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("open")
		end

	Menus_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("menus")
		end

	Merge_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("merge")
		end

	Namer_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("namer")
		end

	Open_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("open")
		end

	Ok_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("ok_tick")
		end

	Parent_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("parent")
		end

	Parent_dot_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("par_dot")
		end

	Popup_filename_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("pop_fn")
		end

	Popup_instances_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("pop_inst")
		end

	Popup_context_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("pop_cntx")
		end

	Predef_command_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("pred_cmd")
		end

-- 	Primitives_pixmap: EV_PIXMAP is
-- 		once
-- 			Result := symbol_file_content ("primitvs")
-- 		end

	Presentation_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("present")
		end

	Quit_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("quit")
		end

	Raise_widget_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("raise_wd")
		end
	
	Reset_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("reset")
		end

	Save_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("save")
		end

	Selected_alignment_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("salign")
		end

	Selected_attribute_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("sattrib")
		end

	Selected_behavior_format_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("sbh_frmt")
		end

	Selected_button_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("sbutton")
		end

 	Selected_color_pixmap: EV_PIXMAP is
 		once
 			Result := symbol_file_content ("scolor")
		end

	Selected_command_page_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("scmd_pge")
		end

	Selected_drawing_area_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("sdrwn_ar")
		end

	Selected_file_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("sfile")
		end

	Selected_font_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("sfont")
		end

	Selected_general_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("sgeneral")
		end

	Selected_generated_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("sgenerated")
		end

	Selected_geometry_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("sgeomtry")
		end

 	Selected_grid_pixmap: EV_PIXMAP is
 		once
 			Result := symbol_file_content ("sgrid")
		end

	Selected_list_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("sscrll_l")
		end

	Selected_scrolled_w_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("sscrll_w")
		end

	Selected_resize_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("sresize")
		end

	Selected_reset_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("sreset")
		end

-- 	Selected_windows_pixmap: EV_PIXMAP is
-- 		once
-- 			Result := symbol_file_content ("swindows")
-- 		end

-- 	Selected_primitives_pixmap: EV_PIXMAP is
-- 		once
-- 			Result := symbol_file_content ("sprimtvs")
-- 		end

-- 	Selected_menus_pixmap: EV_PIXMAP is
-- 		once
-- 			Result := symbol_file_content ("smenus")
-- 		end

	Selected_mouse_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("smouse")
		end

	Selected_scale_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("sscale")
		end

-- 	Selected_groups_pixmap: EV_PIXMAP is
-- 		once
-- 			Result := symbol_file_content ("sgroups")
-- 		end

-- 	Selected_sets_pixmap: EV_PIXMAP is
-- 		once
-- 			Result := symbol_file_content ("ssets")
-- 		end

	Selected_submenu_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("ssubmenu")
		end

	Selected_text_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("stext")
		end

	Selected_text_field_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("stxt_fld")
		end

	Selected_translation_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("strnsltn")
		end

	Selected_user_defined_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("susr_def")
		end

-- 	Sets_pixmap: EV_PIXMAP is
-- 		once
-- 			Result := symbol_file_content ("sets")
-- 		end

	Self_label_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("self_lbl")
		end

	Show_window_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("shw_wndw")
		end

	State_pixmap_small: EV_PIXMAP is
		once
			Result := symbol_file_content ("state_sm")
		end

	State_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("state")
		end

	State_dot_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("state_dt")
		end

	Return_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("return")
		end

	Transition_line_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("transitn")
		end

	Type_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("type")
		end

	Unsave_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("modified")
		end

	User_command_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("user_cmd")
		end

	User_defined_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("user_def")
		end

	Wastebasket_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("wastbskt")
		end

 	Windows_pixmap: EV_PIXMAP is
 		once
 			Result := symbol_file_content ("windows")
 		end

feature -- Context Pixmaps

	Arrow_b_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("arrow_b")
		end

	Bar_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("bar")
		end

	Bulletin_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("bulletin")
		end

	Check_box_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("check_bx")
		end

	Context_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("context")
		end

	Context_dot_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("cont_dot")
		end

	Dialog_shell_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("dialg_sh")
		end

	Drawing_area_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("drwng_ar")
		end

	Group_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("groups")
		end

-- 	Groups_pixmap: EV_PIXMAP is
-- 		once
-- 			Result := symbol_file_content ("groups")
-- 		end

	Label_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("label")
		end

	List_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("scrll_l")
		end

	Menu_pull_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("menu_pll")
		end

	Menu_entry_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("menu_ent")
		end

	Opt_pull_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("opt_pull")
		end

	Pict_color_b_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("pictclrb")
		end

	Push_b_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("push_b")
		end

	Top_shell_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("top_shll")
		end

	Radio_box_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("radio_bx")
		end

	Scrolled_w_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("scr_w")
		end

	Scrolled_t_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("scr_t")
		end

	Separator_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("separatr")
		end

	Scale_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("scale")
		end
 
	Scroll_list_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("scrll_l")
		end

	Scrollable_list_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("scrll_l")
		end

	Text_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("text")
		end

	Text_field_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("text_fld")
		end

	Toggle_b_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("toggle_b")
		end

feature -- Event pixmaps

	Button_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("button")
		end

	Button_click_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("but_click")
		end

	Change_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("change")
		end

	Close_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("close")
		end

	Column_click_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("column_click")
		end

	Deselect_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("deselect")
		end

	Destroy_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("wdgt_dst")
		end

	Double_click_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("double_click")
		end

	Enter_notify_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("enter_notify")
		end

	Get_focus_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("get_focus")
		end

	Key_press_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("key_prss")
		end

	Key_release_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("key_rels")
		end

	Key_return_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("key_rtrn")
		end

	Leave_notify_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("leave_notify")
		end

	Lose_focus_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("button")
		end

	Motion_notify_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("motion_notify")
		end

	Mouse1_dbl_click_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("mouse1_dbl")
		end

	Mouse2_dbl_click_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("mouse2_dbl")
		end

	Mouse3_dbl_click_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("mouse3_dbl")
		end

	Mouse1_motion_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("mouse1mt")
		end

	Mouse2_motion_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("mouse2mt")
		end

	Mouse3_motion_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("mouse3mt")
		end

	Mouse1_press_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("mouse1d")
		end

	Mouse2_press_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("mouse2d")
		end

	Mouse3_press_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("mouse3d")
		end

	Mouse1_release_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("mouse1u")
		end

	Mouse2_release_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("mouse2u")
		end

	Mouse3_release_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("mouse3u")
		end

	Mouse_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("mouse")
		end

	Move_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("move")
		end

	Paint_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("paint")
		end

	Resize_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("resize")
		end

--	Scr_t_modify_pixmap: EV_PIXMAP is
--		once
--			Result := symbol_file_content ("scr_modf")
--		end
--
--	Scr_t_motion_pixmap: EV_PIXMAP is
--		once
--			Result := symbol_file_content ("scr_motn")
--		end

	Select_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("select")
		end

	Selection_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("single")
		end

--	Submenu_pixmap: EV_PIXMAP is
--		once
--			Result := symbol_file_content ("submenu")
--		end

	Subtree_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("subtree")
		end

	Switch_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("switch")
		end

	Toggle_pixmap: EV_PIXMAP is
		once
			Result := symbol_file_content ("ok_tick")
		end

--	Value_changed_pixmap: EV_PIXMAP is
--		once
--			Result := symbol_file_content ("changed")
--		end

feature {NONE} -- Read from file
	
	pixmap_suffix: STRING is
			-- Suffix for pixmaps (bmp for windows - xpm for motif).
		once
			if Platform_constants.is_windows then
				Result := "bmp"
			else
				Result := "xpm"
			end
		end
	
	Pixmap_path: DIRECTORY_NAME is
		once
			create Result.make_from_string (Environment.bitmaps_directory)
			Result.extend (Pixmap_suffix)
		end
	
	symbol_file_content (name: STRING): EV_PIXMAP is
		local
			fn: FILE_NAME
		do
			create fn.make_from_string (Pixmap_path)
			fn.set_file_name (name)	
			fn.add_extension (Pixmap_suffix)
			if fn.is_valid then
				create Result.make_from_file (fn)
			else
				Result := Void
			end
		end

end -- class PIXMAPS

