class INTERFACE_ONLY_B 
inherit

	MAIN_PANEL_TOGGLE;

creation
	make
	
feature {NONE}

	cont_cat_t_state: BOOLEAN;
	cont_tree_t_state: BOOLEAN;
	history_t_state: BOOLEAN;
	editor_t_state: BOOLEAN;
	cmd_cat_t_state: BOOLEAN;
	app_edit_t_state: BOOLEAN;
	interface_t_state: BOOLEAN;

	toggle_pressed is
		do
			if armed then
				show_interface_only
			else
				reinstate_toggles
			end;
		end;

	show_interface_only is
		do
			cont_cat_t_state := main_panel.cont_cat_t.armed;
			if cont_cat_t_state then
				main_panel.cont_cat_t.disarm;
			end;
			cont_tree_t_state := main_panel.cont_tree_t.armed;
			if cont_tree_t_state then
				main_panel.cont_tree_t.disarm;
			end;
			history_t_state := main_panel.history_t.armed;
			if history_t_state then
				main_panel.history_t.disarm;
			end;
			editor_t_state := main_panel.editor_t.armed;
			if editor_t_state then
				main_panel.editor_t.disarm;
			end
			cmd_cat_t_state := main_panel.cmd_cat_t.armed;
			if cmd_cat_t_state then
				main_panel.cmd_cat_t.disarm
			end;
			app_edit_t_state := main_panel.app_edit_t.armed;
			if app_edit_t_state then
				main_panel.app_edit_t.disarm
			end;
			interface_t_state := main_panel.interface_t.armed;
			if not interface_t_state then
				main_panel.interface_t.arm;
			end	
		end;

	reinstate_toggles is
		do
			if cont_cat_t_state and then
				not main_panel.cont_cat_t.armed
			then
				main_panel.cont_cat_t.arm;
			end;
			if cont_tree_t_state and then
				not main_panel.cont_tree_t.armed
			then
				main_panel.cont_tree_t.arm;
			end;
			if history_t_state and then 
				not main_panel.history_t.armed
			then
				main_panel.history_t.arm;
			end;
			if editor_t_state and then 
				not main_panel.editor_t.armed
			then
				main_panel.editor_t.arm;
			end
			if cmd_cat_t_state and then
				not main_panel.cmd_cat_t.armed
			then
				main_panel.cmd_cat_t.arm
			end;
			if app_edit_t_state and then
				not main_panel.app_edit_t.armed
			then
				main_panel.app_edit_t.arm
			end;
			if not interface_t_state then
				main_panel.interface_t.disarm
			end	
		end;

end
