indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.Menu"

deferred external class
	SYSTEM_WINDOWS_FORMS_MENU

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_COMPONENTMODEL_COMPONENT
		redefine
			dispose_boolean,
			to_string
		end
	SYSTEM_IDISPOSABLE

feature -- Access

	frozen get_handle: POINTER is
		external
			"IL signature (): System.IntPtr use System.Windows.Forms.Menu"
		alias
			"get_Handle"
		end

	frozen find_shortcut: INTEGER is 0x1

	frozen find_handle: INTEGER is 0x0

	frozen get_mdi_list_item: SYSTEM_WINDOWS_FORMS_MENUITEM is
		external
			"IL signature (): System.Windows.Forms.MenuItem use System.Windows.Forms.Menu"
		alias
			"get_MdiListItem"
		end

	frozen get_menu_items: MENUITEMCOLLECTION_IN_SYSTEM_WINDOWS_FORMS_MENU is
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

	frozen get_context_menu: SYSTEM_WINDOWS_FORMS_CONTEXTMENU is
		external
			"IL signature (): System.Windows.Forms.ContextMenu use System.Windows.Forms.Menu"
		alias
			"GetContextMenu"
		end

	frozen get_main_menu: SYSTEM_WINDOWS_FORMS_MAINMENU is
		external
			"IL signature (): System.Windows.Forms.MainMenu use System.Windows.Forms.Menu"
		alias
			"GetMainMenu"
		end

	frozen find_menu_item (type: INTEGER; value: POINTER): SYSTEM_WINDOWS_FORMS_MENUITEM is
		external
			"IL signature (System.Int32, System.IntPtr): System.Windows.Forms.MenuItem use System.Windows.Forms.Menu"
		alias
			"FindMenuItem"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.Menu"
		alias
			"ToString"
		end

	merge_menu (menu_src: SYSTEM_WINDOWS_FORMS_MENU) is
		external
			"IL signature (System.Windows.Forms.Menu): System.Void use System.Windows.Forms.Menu"
		alias
			"MergeMenu"
		end

feature {NONE} -- Implementation

	process_cmd_key (msg: SYSTEM_WINDOWS_FORMS_MESSAGE; key_data: SYSTEM_WINDOWS_FORMS_KEYS): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.Message&, System.Windows.Forms.Keys): System.Boolean use System.Windows.Forms.Menu"
		alias
			"ProcessCmdKey"
		end

	frozen clone_menu (menu_src: SYSTEM_WINDOWS_FORMS_MENU) is
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

end -- class SYSTEM_WINDOWS_FORMS_MENU
