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

	static_bar_type: CONTEXT_TYPE [STATIC_MENU_BAR_C]
--	bar_type: CONTEXT_TYPE [MENU_BAR_C]
	menu_type: CONTEXT_TYPE [MENU_C]
	menu_item_type: CONTEXT_TYPE [MENU_ITEM_C]
	check_menu_type: CONTEXT_TYPE [CHECK_MENU_ITEM_C]
	radio_menu_type: CONTEXT_TYPE [RADIO_MENU_ITEM_C]
	popup_menu_type: CONTEXT_TYPE [POPUP_MENU_C]
	option_b_type: CONTEXT_TYPE [OPTION_BUTTON_C]
	status_bar_type: CONTEXT_TYPE [STATUS_BAR_C]
	status_bar_item_type: CONTEXT_TYPE [STATUS_BAR_ITEM_C]

feature {NONE} -- Initialization

	build_interface is
		do
			create static_bar_type.make (create {STATIC_MENU_BAR_C})
			create_button (static_bar_type, Pixmaps.cat_static_bar_pixmap)

 			create menu_type.make (create {MENU_C})
 			create_button (menu_type, Pixmaps.cat_menu_pixmap)

 			create menu_item_type.make (create {MENU_ITEM_C})
			create_button (menu_item_type, Pixmaps.cat_menu_item_pixmap)

			create check_menu_type.make (create {CHECK_MENU_ITEM_C})
			create_button (check_menu_type, Pixmaps.cat_check_menu_pixmap)

			create radio_menu_type.make (create {RADIO_MENU_ITEM_C})
			create_button (radio_menu_type, Pixmaps.cat_radio_menu_pixmap)

			create popup_menu_type.make (create {POPUP_MENU_C})
			create_button (popup_menu_type, Pixmaps.cat_popup_menu_pixmap)

			create option_b_type.make (create {OPTION_BUTTON_C})
			create_button (option_b_type, Pixmaps.cat_opt_pull_pixmap)

 			create status_bar_type.make (create {STATUS_BAR_C})
 			create_button (status_bar_type, Pixmaps.cat_status_bar_pixmap)

 			create status_bar_item_type.make (create {STATUS_BAR_ITEM_C})
 			create_button (status_bar_item_type, Pixmaps.cat_status_bar_item_pixmap)
		end

	tab_label: STRING is
		do
			Result := Context_const.menus_name
		end

end -- class MENU_PAGE

