indexing
	description: "Page representing the menus."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class MENU_PAGE 

inherit

	CONTEXT_CAT_PAGE

creation

	make
	
feature -- Access

	static_bar_type: CONTEXT_TYPE
--	bar_type: CONTEXT_TYPE
	menu_type: CONTEXT_TYPE
	menu_item_type: CONTEXT_TYPE
	check_menu_type: CONTEXT_TYPE
	radio_menu_type: CONTEXT_TYPE
	popup_menu_type: CONTEXT_TYPE
	option_b_type: CONTEXT_TYPE
	status_bar_type: CONTEXT_TYPE
	status_bar_item_type: CONTEXT_TYPE

feature {NONE} -- Initialization

	build_interface is
		local
 			static_bar_c: STATIC_MENU_BAR_C
--			bar_c: MENU_BAR_C
			menu_c: MENU_C
			menu_item_c: MENU_ITEM_C
			check_menu_c: CHECK_MENU_ITEM_C
			radio_menu_c: RADIO_MENU_ITEM_C
			popup_menu_c: POPUP_MENU_C
			option_b_c: OPTION_BUTTON_C
			status_bar_c: STATUS_BAR_C
			status_item_c: STATUS_BAR_ITEM_C
		do
			create static_bar_c
			static_bar_type := create_type (static_bar_c, Pixmaps.cat_static_bar_pixmap)
 			create menu_c
 			menu_type := create_type (menu_c, Pixmaps.cat_menu_pixmap)

 			create menu_item_c
			menu_item_type := create_type (menu_item_c, Pixmaps.cat_menu_item_pixmap)

			create check_menu_c
			check_menu_type := create_type (check_menu_c, Pixmaps.cat_check_menu_pixmap)

			create radio_menu_c
			radio_menu_type := create_type (radio_menu_c, Pixmaps.cat_radio_menu_pixmap)

			create popup_menu_c
			popup_menu_type := create_type (popup_menu_c, Pixmaps.cat_popup_menu_pixmap)

			create option_b_c
			option_b_type := create_type (option_b_c, Pixmaps.cat_opt_pull_pixmap)

 			create status_bar_c
 			status_bar_type := create_type (status_bar_c, Pixmaps.cat_status_bar_pixmap)

 			create status_item_c
 			status_bar_item_type := create_type (status_item_c, Pixmaps.cat_status_bar_item_pixmap)

-- 			button.set_focus_string (Focus_labels.menus_label)
		end

	tab_label: STRING is
		do
			Result := Context_const.menus_name
		end

end -- class MENU_PAGE

