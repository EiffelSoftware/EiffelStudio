indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.CheckedListBox"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_CHECKED_LIST_BOX

inherit
	WINFORMS_LIST_BOX
		redefine
			wm_reflect_command,
			on_measure_item,
			on_draw_item,
			create_item_collection,
			set_selection_mode,
			get_selection_mode,
			set_item_height,
			get_item_height,
			set_draw_mode,
			get_draw_mode,
			on_selected_index_changed,
			wnd_proc,
			on_key_press,
			on_handle_created,
			on_click,
			on_font_changed,
			on_back_color_changed,
			create_accessibility_instance,
			get_create_params
		end
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE
	SYSTEM_DLL_ISYNCHRONIZE_INVOKE
		rename
			invoke as invoke_delegate_array_object,
			begin_invoke as begin_invoke_delegate_array_object
		end
	WINFORMS_IWIN32_WINDOW

create
	make_winforms_checked_list_box

feature {NONE} -- Initialization

	frozen make_winforms_checked_list_box is
		external
			"IL creator use System.Windows.Forms.CheckedListBox"
		end

feature -- Access

	frozen get_check_on_click: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.CheckedListBox"
		alias
			"get_CheckOnClick"
		end

	get_selection_mode: WINFORMS_SELECTION_MODE is
		external
			"IL signature (): System.Windows.Forms.SelectionMode use System.Windows.Forms.CheckedListBox"
		alias
			"get_SelectionMode"
		end

	get_item_height: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.CheckedListBox"
		alias
			"get_ItemHeight"
		end

	frozen get_checked_indices: WINFORMS_CHECKED_INDEX_COLLECTION_IN_WINFORMS_CHECKED_LIST_BOX is
		external
			"IL signature (): System.Windows.Forms.CheckedListBox+CheckedIndexCollection use System.Windows.Forms.CheckedListBox"
		alias
			"get_CheckedIndices"
		end

	frozen get_items_object_collection: WINFORMS_OBJECT_COLLECTION_IN_WINFORMS_CHECKED_LIST_BOX is
		external
			"IL signature (): System.Windows.Forms.CheckedListBox+ObjectCollection use System.Windows.Forms.CheckedListBox"
		alias
			"get_Items"
		end

	get_draw_mode: WINFORMS_DRAW_MODE is
		external
			"IL signature (): System.Windows.Forms.DrawMode use System.Windows.Forms.CheckedListBox"
		alias
			"get_DrawMode"
		end

	frozen get_three_dcheck_boxes: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.CheckedListBox"
		alias
			"get_ThreeDCheckBoxes"
		end

	frozen get_checked_items: WINFORMS_CHECKED_ITEM_COLLECTION_IN_WINFORMS_CHECKED_LIST_BOX is
		external
			"IL signature (): System.Windows.Forms.CheckedListBox+CheckedItemCollection use System.Windows.Forms.CheckedListBox"
		alias
			"get_CheckedItems"
		end

feature -- Element Change

	frozen add_item_check (value: WINFORMS_ITEM_CHECK_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.ItemCheckEventHandler): System.Void use System.Windows.Forms.CheckedListBox"
		alias
			"add_ItemCheck"
		end

	set_selection_mode (value: WINFORMS_SELECTION_MODE) is
		external
			"IL signature (System.Windows.Forms.SelectionMode): System.Void use System.Windows.Forms.CheckedListBox"
		alias
			"set_SelectionMode"
		end

	frozen add_measure_item_measure_item_event_handler (value: WINFORMS_MEASURE_ITEM_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.MeasureItemEventHandler): System.Void use System.Windows.Forms.CheckedListBox"
		alias
			"add_MeasureItem"
		end

	frozen set_three_dcheck_boxes (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.CheckedListBox"
		alias
			"set_ThreeDCheckBoxes"
		end

	frozen remove_draw_item_draw_item_event_handler (value: WINFORMS_DRAW_ITEM_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.DrawItemEventHandler): System.Void use System.Windows.Forms.CheckedListBox"
		alias
			"remove_DrawItem"
		end

	frozen remove_measure_item_measure_item_event_handler (value: WINFORMS_MEASURE_ITEM_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.MeasureItemEventHandler): System.Void use System.Windows.Forms.CheckedListBox"
		alias
			"remove_MeasureItem"
		end

	frozen add_draw_item_draw_item_event_handler (value: WINFORMS_DRAW_ITEM_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.DrawItemEventHandler): System.Void use System.Windows.Forms.CheckedListBox"
		alias
			"add_DrawItem"
		end

	set_item_height (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.CheckedListBox"
		alias
			"set_ItemHeight"
		end

	frozen remove_item_check (value: WINFORMS_ITEM_CHECK_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.ItemCheckEventHandler): System.Void use System.Windows.Forms.CheckedListBox"
		alias
			"remove_ItemCheck"
		end

	frozen add_click_event_handler2 (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.CheckedListBox"
		alias
			"add_Click"
		end

	frozen remove_click_event_handler2 (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.CheckedListBox"
		alias
			"remove_Click"
		end

	set_draw_mode (value: WINFORMS_DRAW_MODE) is
		external
			"IL signature (System.Windows.Forms.DrawMode): System.Void use System.Windows.Forms.CheckedListBox"
		alias
			"set_DrawMode"
		end

	frozen set_check_on_click (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.CheckedListBox"
		alias
			"set_CheckOnClick"
		end

feature -- Basic Operations

	frozen set_item_check_state (index: INTEGER; value: WINFORMS_CHECK_STATE) is
		external
			"IL signature (System.Int32, System.Windows.Forms.CheckState): System.Void use System.Windows.Forms.CheckedListBox"
		alias
			"SetItemCheckState"
		end

	frozen get_item_check_state (index: INTEGER): WINFORMS_CHECK_STATE is
		external
			"IL signature (System.Int32): System.Windows.Forms.CheckState use System.Windows.Forms.CheckedListBox"
		alias
			"GetItemCheckState"
		end

	frozen set_item_checked (index: INTEGER; value: BOOLEAN) is
		external
			"IL signature (System.Int32, System.Boolean): System.Void use System.Windows.Forms.CheckedListBox"
		alias
			"SetItemChecked"
		end

	frozen get_item_checked (index: INTEGER): BOOLEAN is
		external
			"IL signature (System.Int32): System.Boolean use System.Windows.Forms.CheckedListBox"
		alias
			"GetItemChecked"
		end

feature {NONE} -- Implementation

	wm_reflect_command (m: WINFORMS_MESSAGE) is
		external
			"IL signature (System.Windows.Forms.Message&): System.Void use System.Windows.Forms.CheckedListBox"
		alias
			"WmReflectCommand"
		end

	on_measure_item (e: WINFORMS_MEASURE_ITEM_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.MeasureItemEventArgs): System.Void use System.Windows.Forms.CheckedListBox"
		alias
			"OnMeasureItem"
		end

	create_accessibility_instance: WINFORMS_ACCESSIBLE_OBJECT is
		external
			"IL signature (): System.Windows.Forms.AccessibleObject use System.Windows.Forms.CheckedListBox"
		alias
			"CreateAccessibilityInstance"
		end

	on_item_check (ice: WINFORMS_ITEM_CHECK_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.ItemCheckEventArgs): System.Void use System.Windows.Forms.CheckedListBox"
		alias
			"OnItemCheck"
		end

	on_font_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.CheckedListBox"
		alias
			"OnFontChanged"
		end

	on_click (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.CheckedListBox"
		alias
			"OnClick"
		end

	create_item_collection: WINFORMS_OBJECT_COLLECTION_IN_WINFORMS_LIST_BOX is
		external
			"IL signature (): System.Windows.Forms.ListBox+ObjectCollection use System.Windows.Forms.CheckedListBox"
		alias
			"CreateItemCollection"
		end

	on_selected_index_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.CheckedListBox"
		alias
			"OnSelectedIndexChanged"
		end

	on_draw_item (e: WINFORMS_DRAW_ITEM_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.DrawItemEventArgs): System.Void use System.Windows.Forms.CheckedListBox"
		alias
			"OnDrawItem"
		end

	on_handle_created (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.CheckedListBox"
		alias
			"OnHandleCreated"
		end

	wnd_proc (m: WINFORMS_MESSAGE) is
		external
			"IL signature (System.Windows.Forms.Message&): System.Void use System.Windows.Forms.CheckedListBox"
		alias
			"WndProc"
		end

	get_create_params: WINFORMS_CREATE_PARAMS is
		external
			"IL signature (): System.Windows.Forms.CreateParams use System.Windows.Forms.CheckedListBox"
		alias
			"get_CreateParams"
		end

	on_key_press (e: WINFORMS_KEY_PRESS_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.KeyPressEventArgs): System.Void use System.Windows.Forms.CheckedListBox"
		alias
			"OnKeyPress"
		end

	on_back_color_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.CheckedListBox"
		alias
			"OnBackColorChanged"
		end

end -- class WINFORMS_CHECKED_LIST_BOX
