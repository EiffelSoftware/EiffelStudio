indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.ListView"

external class
	SYSTEM_WINDOWS_FORMS_LISTVIEW

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_COMPONENTMODEL_ISYNCHRONIZEINVOKE
		rename
			invoke as invoke_delegate_array_object,
			begin_invoke as begin_invoke_delegate_array_object
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_WINDOWS_FORMS_CONTROL
		redefine
			wnd_proc,
			on_handle_destroyed,
			on_handle_created,
			on_font_changed,
			on_enabled_changed,
			is_input_key,
			create_handle,
			set_text,
			get_text,
			set_fore_color,
			get_fore_color,
			get_default_size,
			get_create_params,
			set_background_image,
			get_background_image,
			set_back_color,
			get_back_color,
			dispose_boolean,
			to_string
		end
	SYSTEM_WINDOWS_FORMS_IWIN32WINDOW

create
	make_listview

feature {NONE} -- Initialization

	frozen make_listview is
		external
			"IL creator use System.Windows.Forms.ListView"
		end

feature -- Access

	frozen get_view: SYSTEM_WINDOWS_FORMS_VIEW is
		external
			"IL signature (): System.Windows.Forms.View use System.Windows.Forms.ListView"
		alias
			"get_View"
		end

	frozen get_checked_indices: CHECKEDINDEXCOLLECTION_IN_SYSTEM_WINDOWS_FORMS_LISTVIEW is
		external
			"IL signature (): System.Windows.Forms.ListView+CheckedIndexCollection use System.Windows.Forms.ListView"
		alias
			"get_CheckedIndices"
		end

	frozen get_label_edit: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ListView"
		alias
			"get_LabelEdit"
		end

	frozen get_auto_arrange: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ListView"
		alias
			"get_AutoArrange"
		end

	frozen get_scrollable: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ListView"
		alias
			"get_Scrollable"
		end

	frozen get_focused_item: SYSTEM_WINDOWS_FORMS_LISTVIEWITEM is
		external
			"IL signature (): System.Windows.Forms.ListViewItem use System.Windows.Forms.ListView"
		alias
			"get_FocusedItem"
		end

	get_text: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.ListView"
		alias
			"get_Text"
		end

	frozen get_border_style: SYSTEM_WINDOWS_FORMS_BORDERSTYLE is
		external
			"IL signature (): System.Windows.Forms.BorderStyle use System.Windows.Forms.ListView"
		alias
			"get_BorderStyle"
		end

	frozen get_small_image_list: SYSTEM_WINDOWS_FORMS_IMAGELIST is
		external
			"IL signature (): System.Windows.Forms.ImageList use System.Windows.Forms.ListView"
		alias
			"get_SmallImageList"
		end

	frozen get_large_image_list: SYSTEM_WINDOWS_FORMS_IMAGELIST is
		external
			"IL signature (): System.Windows.Forms.ImageList use System.Windows.Forms.ListView"
		alias
			"get_LargeImageList"
		end

	frozen get_activation: SYSTEM_WINDOWS_FORMS_ITEMACTIVATION is
		external
			"IL signature (): System.Windows.Forms.ItemActivation use System.Windows.Forms.ListView"
		alias
			"get_Activation"
		end

	frozen get_alignment: SYSTEM_WINDOWS_FORMS_LISTVIEWALIGNMENT is
		external
			"IL signature (): System.Windows.Forms.ListViewAlignment use System.Windows.Forms.ListView"
		alias
			"get_Alignment"
		end

	frozen get_full_row_select: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ListView"
		alias
			"get_FullRowSelect"
		end

	frozen get_columns: COLUMNHEADERCOLLECTION_IN_SYSTEM_WINDOWS_FORMS_LISTVIEW is
		external
			"IL signature (): System.Windows.Forms.ListView+ColumnHeaderCollection use System.Windows.Forms.ListView"
		alias
			"get_Columns"
		end

	frozen get_selected_indices: SELECTEDINDEXCOLLECTION_IN_SYSTEM_WINDOWS_FORMS_LISTVIEW is
		external
			"IL signature (): System.Windows.Forms.ListView+SelectedIndexCollection use System.Windows.Forms.ListView"
		alias
			"get_SelectedIndices"
		end

	frozen get_top_item: SYSTEM_WINDOWS_FORMS_LISTVIEWITEM is
		external
			"IL signature (): System.Windows.Forms.ListViewItem use System.Windows.Forms.ListView"
		alias
			"get_TopItem"
		end

	frozen get_items: LISTVIEWITEMCOLLECTION_IN_SYSTEM_WINDOWS_FORMS_LISTVIEW is
		external
			"IL signature (): System.Windows.Forms.ListView+ListViewItemCollection use System.Windows.Forms.ListView"
		alias
			"get_Items"
		end

	get_fore_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.ListView"
		alias
			"get_ForeColor"
		end

	frozen get_hide_selection: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ListView"
		alias
			"get_HideSelection"
		end

	frozen get_allow_column_reorder: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ListView"
		alias
			"get_AllowColumnReorder"
		end

	frozen get_sorting: SYSTEM_WINDOWS_FORMS_SORTORDER is
		external
			"IL signature (): System.Windows.Forms.SortOrder use System.Windows.Forms.ListView"
		alias
			"get_Sorting"
		end

	get_back_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.ListView"
		alias
			"get_BackColor"
		end

	frozen get_list_view_item_sorter: SYSTEM_COLLECTIONS_ICOMPARER is
		external
			"IL signature (): System.Collections.IComparer use System.Windows.Forms.ListView"
		alias
			"get_ListViewItemSorter"
		end

	frozen get_checked_items: CHECKEDLISTVIEWITEMCOLLECTION_IN_SYSTEM_WINDOWS_FORMS_LISTVIEW is
		external
			"IL signature (): System.Windows.Forms.ListView+CheckedListViewItemCollection use System.Windows.Forms.ListView"
		alias
			"get_CheckedItems"
		end

	get_background_image: SYSTEM_DRAWING_IMAGE is
		external
			"IL signature (): System.Drawing.Image use System.Windows.Forms.ListView"
		alias
			"get_BackgroundImage"
		end

	frozen get_state_image_list: SYSTEM_WINDOWS_FORMS_IMAGELIST is
		external
			"IL signature (): System.Windows.Forms.ImageList use System.Windows.Forms.ListView"
		alias
			"get_StateImageList"
		end

	frozen get_header_style: SYSTEM_WINDOWS_FORMS_COLUMNHEADERSTYLE is
		external
			"IL signature (): System.Windows.Forms.ColumnHeaderStyle use System.Windows.Forms.ListView"
		alias
			"get_HeaderStyle"
		end

	frozen get_grid_lines: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ListView"
		alias
			"get_GridLines"
		end

	frozen get_selected_items: SELECTEDLISTVIEWITEMCOLLECTION_IN_SYSTEM_WINDOWS_FORMS_LISTVIEW is
		external
			"IL signature (): System.Windows.Forms.ListView+SelectedListViewItemCollection use System.Windows.Forms.ListView"
		alias
			"get_SelectedItems"
		end

	frozen get_label_wrap: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ListView"
		alias
			"get_LabelWrap"
		end

	frozen get_multi_select: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ListView"
		alias
			"get_MultiSelect"
		end

	frozen get_hover_selection: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ListView"
		alias
			"get_HoverSelection"
		end

	frozen get_check_boxes: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.ListView"
		alias
			"get_CheckBoxes"
		end

feature -- Element Change

	set_text (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.ListView"
		alias
			"set_Text"
		end

	set_back_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.ListView"
		alias
			"set_BackColor"
		end

	frozen set_view (value: SYSTEM_WINDOWS_FORMS_VIEW) is
		external
			"IL signature (System.Windows.Forms.View): System.Void use System.Windows.Forms.ListView"
		alias
			"set_View"
		end

	frozen set_small_image_list (value: SYSTEM_WINDOWS_FORMS_IMAGELIST) is
		external
			"IL signature (System.Windows.Forms.ImageList): System.Void use System.Windows.Forms.ListView"
		alias
			"set_SmallImageList"
		end

	frozen set_full_row_select (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.ListView"
		alias
			"set_FullRowSelect"
		end

	frozen set_list_view_item_sorter (value: SYSTEM_COLLECTIONS_ICOMPARER) is
		external
			"IL signature (System.Collections.IComparer): System.Void use System.Windows.Forms.ListView"
		alias
			"set_ListViewItemSorter"
		end

	frozen set_sorting (value: SYSTEM_WINDOWS_FORMS_SORTORDER) is
		external
			"IL signature (System.Windows.Forms.SortOrder): System.Void use System.Windows.Forms.ListView"
		alias
			"set_Sorting"
		end

	frozen set_large_image_list (value: SYSTEM_WINDOWS_FORMS_IMAGELIST) is
		external
			"IL signature (System.Windows.Forms.ImageList): System.Void use System.Windows.Forms.ListView"
		alias
			"set_LargeImageList"
		end

	frozen remove_item_drag (value: SYSTEM_WINDOWS_FORMS_ITEMDRAGEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.ItemDragEventHandler): System.Void use System.Windows.Forms.ListView"
		alias
			"remove_ItemDrag"
		end

	frozen remove_item_activate (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.ListView"
		alias
			"remove_ItemActivate"
		end

	frozen set_label_wrap (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.ListView"
		alias
			"set_LabelWrap"
		end

	frozen set_label_edit (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.ListView"
		alias
			"set_LabelEdit"
		end

	frozen set_allow_column_reorder (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.ListView"
		alias
			"set_AllowColumnReorder"
		end

	frozen set_hide_selection (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.ListView"
		alias
			"set_HideSelection"
		end

	frozen set_activation (value: SYSTEM_WINDOWS_FORMS_ITEMACTIVATION) is
		external
			"IL signature (System.Windows.Forms.ItemActivation): System.Void use System.Windows.Forms.ListView"
		alias
			"set_Activation"
		end

	frozen remove_before_label_edit (value: SYSTEM_WINDOWS_FORMS_LABELEDITEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.LabelEditEventHandler): System.Void use System.Windows.Forms.ListView"
		alias
			"remove_BeforeLabelEdit"
		end

	frozen set_state_image_list (value: SYSTEM_WINDOWS_FORMS_IMAGELIST) is
		external
			"IL signature (System.Windows.Forms.ImageList): System.Void use System.Windows.Forms.ListView"
		alias
			"set_StateImageList"
		end

	frozen add_item_activate (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.ListView"
		alias
			"add_ItemActivate"
		end

	set_background_image (value: SYSTEM_DRAWING_IMAGE) is
		external
			"IL signature (System.Drawing.Image): System.Void use System.Windows.Forms.ListView"
		alias
			"set_BackgroundImage"
		end

	frozen set_header_style (value: SYSTEM_WINDOWS_FORMS_COLUMNHEADERSTYLE) is
		external
			"IL signature (System.Windows.Forms.ColumnHeaderStyle): System.Void use System.Windows.Forms.ListView"
		alias
			"set_HeaderStyle"
		end

	frozen add_before_label_edit (value: SYSTEM_WINDOWS_FORMS_LABELEDITEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.LabelEditEventHandler): System.Void use System.Windows.Forms.ListView"
		alias
			"add_BeforeLabelEdit"
		end

	frozen set_check_boxes (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.ListView"
		alias
			"set_CheckBoxes"
		end

	frozen add_selected_index_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.ListView"
		alias
			"add_SelectedIndexChanged"
		end

	frozen remove_column_click (value: SYSTEM_WINDOWS_FORMS_COLUMNCLICKEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.ColumnClickEventHandler): System.Void use System.Windows.Forms.ListView"
		alias
			"remove_ColumnClick"
		end

	frozen set_alignment (value: SYSTEM_WINDOWS_FORMS_LISTVIEWALIGNMENT) is
		external
			"IL signature (System.Windows.Forms.ListViewAlignment): System.Void use System.Windows.Forms.ListView"
		alias
			"set_Alignment"
		end

	frozen set_scrollable (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.ListView"
		alias
			"set_Scrollable"
		end

	frozen set_auto_arrange (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.ListView"
		alias
			"set_AutoArrange"
		end

	frozen set_border_style (value: SYSTEM_WINDOWS_FORMS_BORDERSTYLE) is
		external
			"IL signature (System.Windows.Forms.BorderStyle): System.Void use System.Windows.Forms.ListView"
		alias
			"set_BorderStyle"
		end

	set_fore_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.ListView"
		alias
			"set_ForeColor"
		end

	frozen set_hover_selection (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.ListView"
		alias
			"set_HoverSelection"
		end

	frozen remove_selected_index_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.ListView"
		alias
			"remove_SelectedIndexChanged"
		end

	frozen remove_item_check (value: SYSTEM_WINDOWS_FORMS_ITEMCHECKEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.ItemCheckEventHandler): System.Void use System.Windows.Forms.ListView"
		alias
			"remove_ItemCheck"
		end

	frozen add_after_label_edit (value: SYSTEM_WINDOWS_FORMS_LABELEDITEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.LabelEditEventHandler): System.Void use System.Windows.Forms.ListView"
		alias
			"add_AfterLabelEdit"
		end

	frozen remove_after_label_edit (value: SYSTEM_WINDOWS_FORMS_LABELEDITEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.LabelEditEventHandler): System.Void use System.Windows.Forms.ListView"
		alias
			"remove_AfterLabelEdit"
		end

	frozen set_multi_select (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.ListView"
		alias
			"set_MultiSelect"
		end

	frozen add_item_drag (value: SYSTEM_WINDOWS_FORMS_ITEMDRAGEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.ItemDragEventHandler): System.Void use System.Windows.Forms.ListView"
		alias
			"add_ItemDrag"
		end

	frozen add_column_click (value: SYSTEM_WINDOWS_FORMS_COLUMNCLICKEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.ColumnClickEventHandler): System.Void use System.Windows.Forms.ListView"
		alias
			"add_ColumnClick"
		end

	frozen add_item_check (value: SYSTEM_WINDOWS_FORMS_ITEMCHECKEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.ItemCheckEventHandler): System.Void use System.Windows.Forms.ListView"
		alias
			"add_ItemCheck"
		end

	frozen set_grid_lines (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.ListView"
		alias
			"set_GridLines"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.ListView"
		alias
			"ToString"
		end

	frozen arrange_icons_list_view_alignment (value: SYSTEM_WINDOWS_FORMS_LISTVIEWALIGNMENT) is
		external
			"IL signature (System.Windows.Forms.ListViewAlignment): System.Void use System.Windows.Forms.ListView"
		alias
			"ArrangeIcons"
		end

	frozen ensure_visible (index: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.ListView"
		alias
			"EnsureVisible"
		end

	frozen end_update is
		external
			"IL signature (): System.Void use System.Windows.Forms.ListView"
		alias
			"EndUpdate"
		end

	frozen sort is
		external
			"IL signature (): System.Void use System.Windows.Forms.ListView"
		alias
			"Sort"
		end

	frozen arrange_icons is
		external
			"IL signature (): System.Void use System.Windows.Forms.ListView"
		alias
			"ArrangeIcons"
		end

	frozen begin_update is
		external
			"IL signature (): System.Void use System.Windows.Forms.ListView"
		alias
			"BeginUpdate"
		end

	frozen clear is
		external
			"IL signature (): System.Void use System.Windows.Forms.ListView"
		alias
			"Clear"
		end

	frozen get_item_rect (index: INTEGER): SYSTEM_DRAWING_RECTANGLE is
		external
			"IL signature (System.Int32): System.Drawing.Rectangle use System.Windows.Forms.ListView"
		alias
			"GetItemRect"
		end

	frozen get_item_at (x: INTEGER; y: INTEGER): SYSTEM_WINDOWS_FORMS_LISTVIEWITEM is
		external
			"IL signature (System.Int32, System.Int32): System.Windows.Forms.ListViewItem use System.Windows.Forms.ListView"
		alias
			"GetItemAt"
		end

	frozen get_item_rect_int32_item_bounds_portion (index: INTEGER; portion: SYSTEM_WINDOWS_FORMS_ITEMBOUNDSPORTION): SYSTEM_DRAWING_RECTANGLE is
		external
			"IL signature (System.Int32, System.Windows.Forms.ItemBoundsPortion): System.Drawing.Rectangle use System.Windows.Forms.ListView"
		alias
			"GetItemRect"
		end

feature {NONE} -- Implementation

	on_before_label_edit (e: SYSTEM_WINDOWS_FORMS_LABELEDITEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.LabelEditEventArgs): System.Void use System.Windows.Forms.ListView"
		alias
			"OnBeforeLabelEdit"
		end

	get_create_params: SYSTEM_WINDOWS_FORMS_CREATEPARAMS is
		external
			"IL signature (): System.Windows.Forms.CreateParams use System.Windows.Forms.ListView"
		alias
			"get_CreateParams"
		end

	on_selected_index_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.ListView"
		alias
			"OnSelectedIndexChanged"
		end

	create_handle is
		external
			"IL signature (): System.Void use System.Windows.Forms.ListView"
		alias
			"CreateHandle"
		end

	on_enabled_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.ListView"
		alias
			"OnEnabledChanged"
		end

	frozen update_extended_styles is
		external
			"IL signature (): System.Void use System.Windows.Forms.ListView"
		alias
			"UpdateExtendedStyles"
		end

	wnd_proc (m: SYSTEM_WINDOWS_FORMS_MESSAGE) is
		external
			"IL signature (System.Windows.Forms.Message&): System.Void use System.Windows.Forms.ListView"
		alias
			"WndProc"
		end

	on_item_check (ice: SYSTEM_WINDOWS_FORMS_ITEMCHECKEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.ItemCheckEventArgs): System.Void use System.Windows.Forms.ListView"
		alias
			"OnItemCheck"
		end

	frozen realize_properties is
		external
			"IL signature (): System.Void use System.Windows.Forms.ListView"
		alias
			"RealizeProperties"
		end

	on_handle_created (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.ListView"
		alias
			"OnHandleCreated"
		end

	get_default_size: SYSTEM_DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.ListView"
		alias
			"get_DefaultSize"
		end

	on_after_label_edit (e: SYSTEM_WINDOWS_FORMS_LABELEDITEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.LabelEditEventArgs): System.Void use System.Windows.Forms.ListView"
		alias
			"OnAfterLabelEdit"
		end

	on_column_click (e: SYSTEM_WINDOWS_FORMS_COLUMNCLICKEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.ColumnClickEventArgs): System.Void use System.Windows.Forms.ListView"
		alias
			"OnColumnClick"
		end

	dispose_boolean (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.ListView"
		alias
			"Dispose"
		end

	on_item_activate (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.ListView"
		alias
			"OnItemActivate"
		end

	on_font_changed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.ListView"
		alias
			"OnFontChanged"
		end

	on_handle_destroyed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.ListView"
		alias
			"OnHandleDestroyed"
		end

	is_input_key (key_data: SYSTEM_WINDOWS_FORMS_KEYS): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.Keys): System.Boolean use System.Windows.Forms.ListView"
		alias
			"IsInputKey"
		end

	on_item_drag (e: SYSTEM_WINDOWS_FORMS_ITEMDRAGEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.ItemDragEventArgs): System.Void use System.Windows.Forms.ListView"
		alias
			"OnItemDrag"
		end

end -- class SYSTEM_WINDOWS_FORMS_LISTVIEW
