indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.MenuItem"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_MENU_ITEM

inherit
	WINFORMS_MENU
		redefine
			get_is_parent,
			dispose_boolean,
			to_string
		end
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE

create
	make_winforms_menu_item,
	make_winforms_menu_item_3,
	make_winforms_menu_item_2,
	make_winforms_menu_item_1,
	make_winforms_menu_item_5,
	make_winforms_menu_item_4

feature {NONE} -- Initialization

	frozen make_winforms_menu_item is
		external
			"IL creator use System.Windows.Forms.MenuItem"
		end

	frozen make_winforms_menu_item_3 (text: SYSTEM_STRING; on_click2: EVENT_HANDLER; shortcut: WINFORMS_SHORTCUT) is
		external
			"IL creator signature (System.String, System.EventHandler, System.Windows.Forms.Shortcut) use System.Windows.Forms.MenuItem"
		end

	frozen make_winforms_menu_item_2 (text: SYSTEM_STRING; on_click2: EVENT_HANDLER) is
		external
			"IL creator signature (System.String, System.EventHandler) use System.Windows.Forms.MenuItem"
		end

	frozen make_winforms_menu_item_1 (text: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Windows.Forms.MenuItem"
		end

	frozen make_winforms_menu_item_5 (merge_type: WINFORMS_MENU_MERGE; merge_order: INTEGER; shortcut: WINFORMS_SHORTCUT; text: SYSTEM_STRING; on_click2: EVENT_HANDLER; on_popup2: EVENT_HANDLER; on_select2: EVENT_HANDLER; items: NATIVE_ARRAY [WINFORMS_MENU_ITEM]) is
		external
			"IL creator signature (System.Windows.Forms.MenuMerge, System.Int32, System.Windows.Forms.Shortcut, System.String, System.EventHandler, System.EventHandler, System.EventHandler, System.Windows.Forms.MenuItem[]) use System.Windows.Forms.MenuItem"
		end

	frozen make_winforms_menu_item_4 (text: SYSTEM_STRING; items: NATIVE_ARRAY [WINFORMS_MENU_ITEM]) is
		external
			"IL creator signature (System.String, System.Windows.Forms.MenuItem[]) use System.Windows.Forms.MenuItem"
		end

feature -- Access

	frozen get_enabled: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.MenuItem"
		alias
			"get_Enabled"
		end

	frozen get_visible: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.MenuItem"
		alias
			"get_Visible"
		end

	frozen get_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.MenuItem"
		alias
			"get_Text"
		end

	frozen get_shortcut: WINFORMS_SHORTCUT is
		external
			"IL signature (): System.Windows.Forms.Shortcut use System.Windows.Forms.MenuItem"
		alias
			"get_Shortcut"
		end

	frozen get_radio_check: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.MenuItem"
		alias
			"get_RadioCheck"
		end

	frozen get_owner_draw: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.MenuItem"
		alias
			"get_OwnerDraw"
		end

	frozen get_default_item: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.MenuItem"
		alias
			"get_DefaultItem"
		end

	frozen get_mnemonic: CHARACTER is
		external
			"IL signature (): System.Char use System.Windows.Forms.MenuItem"
		alias
			"get_Mnemonic"
		end

	frozen get_checked: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.MenuItem"
		alias
			"get_Checked"
		end

	frozen get_merge_order: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.MenuItem"
		alias
			"get_MergeOrder"
		end

	frozen get_bar_break: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.MenuItem"
		alias
			"get_BarBreak"
		end

	frozen get_mdi_list: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.MenuItem"
		alias
			"get_MdiList"
		end

	frozen get_parent: WINFORMS_MENU is
		external
			"IL signature (): System.Windows.Forms.Menu use System.Windows.Forms.MenuItem"
		alias
			"get_Parent"
		end

	frozen get_index: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.MenuItem"
		alias
			"get_Index"
		end

	get_is_parent: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.MenuItem"
		alias
			"get_IsParent"
		end

	frozen get_merge_type: WINFORMS_MENU_MERGE is
		external
			"IL signature (): System.Windows.Forms.MenuMerge use System.Windows.Forms.MenuItem"
		alias
			"get_MergeType"
		end

	frozen get_break: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.MenuItem"
		alias
			"get_Break"
		end

	frozen get_show_shortcut: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.MenuItem"
		alias
			"get_ShowShortcut"
		end

feature -- Element Change

	frozen set_bar_break (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.MenuItem"
		alias
			"set_BarBreak"
		end

	frozen remove_draw_item (value: WINFORMS_DRAW_ITEM_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.DrawItemEventHandler): System.Void use System.Windows.Forms.MenuItem"
		alias
			"remove_DrawItem"
		end

	frozen set_visible (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.MenuItem"
		alias
			"set_Visible"
		end

	frozen add_select (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.MenuItem"
		alias
			"add_Select"
		end

	frozen set_show_shortcut (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.MenuItem"
		alias
			"set_ShowShortcut"
		end

	frozen remove_click (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.MenuItem"
		alias
			"remove_Click"
		end

	frozen add_popup (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.MenuItem"
		alias
			"add_Popup"
		end

	frozen set_mdi_list (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.MenuItem"
		alias
			"set_MdiList"
		end

	frozen set_owner_draw (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.MenuItem"
		alias
			"set_OwnerDraw"
		end

	frozen remove_measure_item (value: WINFORMS_MEASURE_ITEM_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.MeasureItemEventHandler): System.Void use System.Windows.Forms.MenuItem"
		alias
			"remove_MeasureItem"
		end

	frozen remove_popup (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.MenuItem"
		alias
			"remove_Popup"
		end

	frozen add_measure_item (value: WINFORMS_MEASURE_ITEM_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.MeasureItemEventHandler): System.Void use System.Windows.Forms.MenuItem"
		alias
			"add_MeasureItem"
		end

	frozen set_break (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.MenuItem"
		alias
			"set_Break"
		end

	frozen set_index (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.MenuItem"
		alias
			"set_Index"
		end

	frozen set_default_item (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.MenuItem"
		alias
			"set_DefaultItem"
		end

	frozen remove_select (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.MenuItem"
		alias
			"remove_Select"
		end

	frozen set_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.MenuItem"
		alias
			"set_Text"
		end

	frozen add_click (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.MenuItem"
		alias
			"add_Click"
		end

	frozen set_merge_order (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.MenuItem"
		alias
			"set_MergeOrder"
		end

	frozen add_draw_item (value: WINFORMS_DRAW_ITEM_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.DrawItemEventHandler): System.Void use System.Windows.Forms.MenuItem"
		alias
			"add_DrawItem"
		end

	frozen set_merge_type (value: WINFORMS_MENU_MERGE) is
		external
			"IL signature (System.Windows.Forms.MenuMerge): System.Void use System.Windows.Forms.MenuItem"
		alias
			"set_MergeType"
		end

	frozen set_enabled (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.MenuItem"
		alias
			"set_Enabled"
		end

	frozen set_radio_check (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.MenuItem"
		alias
			"set_RadioCheck"
		end

	frozen set_checked (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.MenuItem"
		alias
			"set_Checked"
		end

	frozen set_shortcut (value: WINFORMS_SHORTCUT) is
		external
			"IL signature (System.Windows.Forms.Shortcut): System.Void use System.Windows.Forms.MenuItem"
		alias
			"set_Shortcut"
		end

feature -- Basic Operations

	merge_menu_menu_item: WINFORMS_MENU_ITEM is
		external
			"IL signature (): System.Windows.Forms.MenuItem use System.Windows.Forms.MenuItem"
		alias
			"MergeMenu"
		end

	frozen merge_menu_menu_item2 (item_src: WINFORMS_MENU_ITEM) is
		external
			"IL signature (System.Windows.Forms.MenuItem): System.Void use System.Windows.Forms.MenuItem"
		alias
			"MergeMenu"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.MenuItem"
		alias
			"ToString"
		end

	frozen perform_click is
		external
			"IL signature (): System.Void use System.Windows.Forms.MenuItem"
		alias
			"PerformClick"
		end

	clone_menu_menu_item: WINFORMS_MENU_ITEM is
		external
			"IL signature (): System.Windows.Forms.MenuItem use System.Windows.Forms.MenuItem"
		alias
			"CloneMenu"
		end

	perform_select is
		external
			"IL signature (): System.Void use System.Windows.Forms.MenuItem"
		alias
			"PerformSelect"
		end

feature {NONE} -- Implementation

	on_measure_item (e: WINFORMS_MEASURE_ITEM_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.MeasureItemEventArgs): System.Void use System.Windows.Forms.MenuItem"
		alias
			"OnMeasureItem"
		end

	frozen clone_menu_menu_item2 (item_src: WINFORMS_MENU_ITEM) is
		external
			"IL signature (System.Windows.Forms.MenuItem): System.Void use System.Windows.Forms.MenuItem"
		alias
			"CloneMenu"
		end

	dispose_boolean (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.MenuItem"
		alias
			"Dispose"
		end

	on_select (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.MenuItem"
		alias
			"OnSelect"
		end

	on_popup (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.MenuItem"
		alias
			"OnPopup"
		end

	on_click (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.MenuItem"
		alias
			"OnClick"
		end

	on_draw_item (e: WINFORMS_DRAW_ITEM_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.DrawItemEventArgs): System.Void use System.Windows.Forms.MenuItem"
		alias
			"OnDrawItem"
		end

	on_init_menu_popup (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.MenuItem"
		alias
			"OnInitMenuPopup"
		end

	frozen get_menu_id: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.MenuItem"
		alias
			"get_MenuID"
		end

end -- class WINFORMS_MENU_ITEM
