indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.Menu"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	WINFORMS_MENU

inherit
	SYSTEM_DLL_COMPONENT
		redefine
			dispose_boolean,
			to_string
		end
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE

feature -- Access

	frozen get_handle: POINTER is
		external
			"IL signature (): System.IntPtr use System.Windows.Forms.Menu"
		alias
			"get_Handle"
		end

	frozen find_shortcut: INTEGER is 0x1

	frozen find_handle: INTEGER is 0x0

	frozen get_mdi_list_item: WINFORMS_MENU_ITEM is
		external
			"IL signature (): System.Windows.Forms.MenuItem use System.Windows.Forms.Menu"
		alias
			"get_MdiListItem"
		end

	frozen get_menu_items: WINFORMS_MENU_ITEM_COLLECTION_IN_WINFORMS_MENU is
		external
			"IL signature (): System.Windows.Forms.Menu+MenuItemCollection use System.Windows.Forms.Menu"
		alias
			"get_MenuItems"
		end

	get_is_parent: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Menu"
		alias
			"get_IsParent"
		end

feature -- Basic Operations

	frozen get_context_menu: WINFORMS_CONTEXT_MENU is
		external
			"IL signature (): System.Windows.Forms.ContextMenu use System.Windows.Forms.Menu"
		alias
			"GetContextMenu"
		end

	frozen get_main_menu: WINFORMS_MAIN_MENU is
		external
			"IL signature (): System.Windows.Forms.MainMenu use System.Windows.Forms.Menu"
		alias
			"GetMainMenu"
		end

	frozen find_menu_item (type: INTEGER; value: POINTER): WINFORMS_MENU_ITEM is
		external
			"IL signature (System.Int32, System.IntPtr): System.Windows.Forms.MenuItem use System.Windows.Forms.Menu"
		alias
			"FindMenuItem"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.Menu"
		alias
			"ToString"
		end

	merge_menu (menu_src: WINFORMS_MENU) is
		external
			"IL signature (System.Windows.Forms.Menu): System.Void use System.Windows.Forms.Menu"
		alias
			"MergeMenu"
		end

feature {NONE} -- Implementation

	process_cmd_key (msg: WINFORMS_MESSAGE; key_data: WINFORMS_KEYS): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.Message&, System.Windows.Forms.Keys): System.Boolean use System.Windows.Forms.Menu"
		alias
			"ProcessCmdKey"
		end

	frozen clone_menu (menu_src: WINFORMS_MENU) is
		external
			"IL signature (System.Windows.Forms.Menu): System.Void use System.Windows.Forms.Menu"
		alias
			"CloneMenu"
		end

	create_menu_handle: POINTER is
		external
			"IL signature (): System.IntPtr use System.Windows.Forms.Menu"
		alias
			"CreateMenuHandle"
		end

	frozen find_merge_position (merge_order: INTEGER): INTEGER is
		external
			"IL signature (System.Int32): System.Int32 use System.Windows.Forms.Menu"
		alias
			"FindMergePosition"
		end

	dispose_boolean (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.Menu"
		alias
			"Dispose"
		end

end -- class WINFORMS_MENU
