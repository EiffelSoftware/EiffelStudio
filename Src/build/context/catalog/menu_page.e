
class MENU_PAGE 

inherit

	CONTEXT_CAT_PAGE

creation

	make
	
feature 

	submenu_type: CONTEXT_TYPE;
	menu_entry_type: CONTEXT_TYPE;
	bar_type: CONTEXT_TYPE;
	option_btn_type: CONTEXT_TYPE;

feature {NONE}

	build_interface is
		local
			bar_c: BAR_C;
			submenu_c: MENU_PULL_C;
			option_btn_c: OPT_PULL_C;
			menu_entry_c: MENU_ENTRY_C;
		do
			!!menu_entry_c;
			menu_entry_type := create_type (Widget_names.menu_entry_name, 
					menu_entry_c, Pixmaps.cat_menu_entry_pixmap);

			!!bar_c;
			bar_type := create_type (Widget_names.bar_name, 
					bar_c, Pixmaps.cat_bar_pixmap);

			!!submenu_c;
			submenu_type := create_type (Widget_names.submenu_name, 
					submenu_c, Pixmaps.cat_menu_pull_pixmap);

			!!option_btn_c;
			option_btn_type := create_type (Widget_names.opt_pull_name, 
					option_btn_c, Pixmaps.cat_opt_pull_pixmap);

			attach_left (bar_type.source, 1);
			attach_left_widget (bar_type.source, option_btn_type.source, 10);
			attach_left (submenu_type.source, 1);
			attach_left_widget (submenu_type.source, menu_entry_type.source, 10);

			attach_top (bar_type.source, 1);
			attach_top (option_btn_type.source, 1);

			attach_top_widget (bar_type.source, submenu_type.source, 10);
			attach_top_widget (bar_type.source, menu_entry_type.source, 10);

			button.set_focus_string (Focus_labels.menus_label)
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.menus_pixmap
		end;

	selected_symbol: PIXMAP is
		do
			Result := Pixmaps.selected_menus_pixmap
		end;

-- samik	focus_string: STRING is
-- samik		do
-- samik			Result := Focus_labels.menus_label
-- samik		end;

end
