
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

	build is
		local
			bar_c: BAR_C;
			submenu_c: MENU_PULL_C;
			option_btn_c: OPT_PULL_C;
			menu_entry_c: MENU_ENTRY_C;
		do
			!!menu_entry_c;
			menu_entry_type := create_type (M_enu_entry_name, menu_entry_c, Cat_menu_entry_pixmap);

			!!bar_c;
			bar_type := create_type (B_ar_name, bar_c, Cat_bar_pixmap);

			!!submenu_c;
			submenu_type := create_type (S_ubmenu_name, submenu_c, Cat_menu_pull_pixmap);

			!!option_btn_c;
			option_btn_type := create_type (O_pt_pull_name, option_btn_c, Cat_opt_pull_pixmap);

			attach_left (bar_type.source, 1);
			attach_left_widget (bar_type.source, option_btn_type.source, 10);
			attach_left (submenu_type.source, 1);
			attach_left_widget (submenu_type.source, menu_entry_type.source, 10);

			attach_top (bar_type.source, 1);
			attach_top (option_btn_type.source, 1);

			attach_top_widget (bar_type.source, submenu_type.source, 10);
			attach_top_widget (bar_type.source, menu_entry_type.source, 10);
		end;

end
