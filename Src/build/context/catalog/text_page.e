indexing
	description: "Page containing contexts representing text components."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEXT_PAGE

inherit
	CONTEXT_CAT_PAGE

creation
	make
	
feature -- Access

	text_field_type: CONTEXT_TYPE [TEXT_FIELD_C]
	passwd_field_type: CONTEXT_TYPE [PASSWORD_FIELD_C]
	combo_box_type: CONTEXT_TYPE [COMBO_BOX_C]
	list_type: CONTEXT_TYPE [LIST_C]
	list_item_type: CONTEXT_TYPE [LIST_ITEM_C]
	multi_col_type: CONTEXT_TYPE [MULTI_COLUMN_LIST_C]
	multi_col_row_type: CONTEXT_TYPE [MULTI_COLUMN_ROW_C]
	tree_type: CONTEXT_TYPE [TREE_C]
	tree_item_type: CONTEXT_TYPE [TREE_ITEM_C]
	text_type: CONTEXT_TYPE [TEXT_C]
	rich_text_type: CONTEXT_TYPE [RICH_TEXT_C]

feature {NONE} -- Initialization

	build_interface is
		do
 			create text_field_type.make (create {TEXT_FIELD_C})
 			create_button (text_field_type, Pixmaps.cat_text_field_pixmap)

 			create passwd_field_type.make (create {PASSWORD_FIELD_C})
 			create_button (passwd_field_type, Pixmaps.cat_passwd_field_pixmap)

 			create combo_box_type.make (create {COMBO_BOX_C})
 			create_button (combo_box_type, Pixmaps.cat_combo_box_pixmap)

 			create list_type.make (create {LIST_C})
 			create_button (list_type, Pixmaps.cat_list_pixmap)

 			create list_item_type.make (create {LIST_ITEM_C})
 			create_button (list_item_type, Pixmaps.cat_list_item_pixmap)

 			create multi_col_type.make (create {MULTI_COLUMN_LIST_C})
 			create_button (multi_col_type, Pixmaps.cat_multi_col_pixmap)

 			create multi_col_row_type.make (create {MULTI_COLUMN_ROW_C})
 			create_button (multi_col_row_type, Pixmaps.cat_multi_col_row_pixmap)

 			create tree_type.make (create {TREE_C})
 			create_button (tree_type, Pixmaps.cat_tree_pixmap)

 			create tree_item_type.make (create {TREE_ITEM_C})
 			create_button (tree_item_type, Pixmaps.cat_tree_item_pixmap)

 			create text_type.make (create {TEXT_C})
 			create_button (text_type, Pixmaps.cat_text_pixmap)

 			create rich_text_type.make (create {RICH_TEXT_C})
 			create_button (rich_text_type, Pixmaps.cat_rich_text_pixmap)
		end

	tab_label: STRING is
		do
			Result := Context_const.texts_name
		end

end -- class TEXT_PAGE

