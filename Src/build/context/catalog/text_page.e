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

	text_field_type: CONTEXT_TYPE
	passwd_field_type: CONTEXT_TYPE
	combo_box_type: CONTEXT_TYPE
	list_type: CONTEXT_TYPE
	list_item_type: CONTEXT_TYPE
	multi_col_type: CONTEXT_TYPE
	multi_col_row_type: CONTEXT_TYPE
	tree_type: CONTEXT_TYPE
	tree_item_type: CONTEXT_TYPE
	text_type: CONTEXT_TYPE
	rich_text_type: CONTEXT_TYPE

feature {NONE} -- Initialization

	build_interface is
		local
			text_field_c: TEXT_FIELD_C
			passwd_field_c: PASSWORD_FIELD_C
			combo_box_c: COMBO_BOX_C
			list_c: LIST_C
			list_item_c: LIST_ITEM_C
			multi_col_c: MULTI_COLUMN_LIST_C
			multi_col_row_c: MULTI_COLUMN_ROW_C
			tree_c: TREE_C
			tree_item_c: TREE_ITEM_C
			text_c: TEXT_C
			rich_text_c: RICH_TEXT_C
		do
 			create text_field_c
 			text_field_type := create_type (text_field_c, Pixmaps.cat_text_field_pixmap)

 			create passwd_field_c
 			passwd_field_type := create_type (passwd_field_c, Pixmaps.cat_passwd_field_pixmap)

 			create combo_box_c
 			combo_box_type := create_type (combo_box_c, Pixmaps.cat_combo_box_pixmap)
 			create list_c
 			list_type := create_type (list_c, Pixmaps.cat_list_pixmap)

 			create list_item_c
 			list_item_type := create_type (list_item_c, Pixmaps.cat_list_item_pixmap)

 			create multi_col_c
 			multi_col_type := create_type (multi_col_c, Pixmaps.cat_multi_col_pixmap)

 			create multi_col_row_c
 			multi_col_row_type := create_type (multi_col_row_c, Pixmaps.cat_multi_col_row_pixmap)

 			create tree_c
 			tree_type := create_type (tree_c, Pixmaps.cat_tree_pixmap)

 			create tree_item_c
 			tree_item_type := create_type (tree_item_c, Pixmaps.cat_tree_item_pixmap)

 			create text_c
 			text_type := create_type (text_c, Pixmaps.cat_text_pixmap)

 			create rich_text_c
 			rich_text_type := create_type (rich_text_c, Pixmaps.cat_rich_text_pixmap)

-- 			button.set_focus_string (Focus_labels.windows_label)
		end

	tab_label: STRING is
		do
			Result := Context_const.texts_name
		end

end -- class TEXT_PAGE

