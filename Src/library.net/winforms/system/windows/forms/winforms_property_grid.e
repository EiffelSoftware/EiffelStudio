indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.PropertyGrid"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_PROPERTY_GRID

inherit
	WINFORMS_CONTAINER_CONTROL
		redefine
			set_auto_scroll,
			get_auto_scroll,
			wnd_proc,
			scale_core,
			refresh,
			process_dialog_key,
			on_system_colors_changed,
			on_resize,
			on_paint,
			on_mouse_up,
			on_mouse_move,
			on_mouse_down,
			on_got_focus,
			on_handle_destroyed,
			on_handle_created,
			on_visible_changed,
			on_font_changed,
			get_show_focus_cues,
			set_fore_color,
			get_fore_color,
			get_default_size,
			set_background_image,
			get_background_image,
			set_back_color,
			get_back_color,
			set_site,
			get_site,
			dispose_boolean
		end
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE
	SYSTEM_DLL_ISYNCHRONIZE_INVOKE
		rename
			invoke as invoke_delegate_array_object,
			begin_invoke as begin_invoke_delegate_array_object
		end
	WINFORMS_IWIN32_WINDOW
	WINFORMS_ICONTAINER_CONTROL
		rename
			activate_control as system_windows_forms_icontainer_control_activate_control
		end
	WINFORMS_ICOM_PROPERTY_BROWSER
		rename
			save_state as system_windows_forms_component_model_com2_interop_icom_property_browser_save_state,
			load_state as system_windows_forms_component_model_com2_interop_icom_property_browser_load_state,
			handle_f4 as system_windows_forms_component_model_com2_interop_icom_property_browser_handle_f4,
			ensure_pending_changes_committed as system_windows_forms_component_model_com2_interop_icom_property_browser_ensure_pending_changes_committed,
			drop_down_done as system_windows_forms_component_model_com2_interop_icom_property_browser_drop_down_done,
			remove_com_component_name_changed as system_windows_forms_component_model_com2_interop_icom_property_browser_remove_com_component_name_changed,
			add_com_component_name_changed as system_windows_forms_component_model_com2_interop_icom_property_browser_add_com_component_name_changed,
			get_in_property_set as system_windows_forms_component_model_com2_interop_icom_property_browser_get_in_property_set
		end

create
	make_winforms_property_grid

feature {NONE} -- Initialization

	frozen make_winforms_property_grid is
		external
			"IL creator use System.Windows.Forms.PropertyGrid"
		end

feature -- Access

	frozen get_property_sort: WINFORMS_PROPERTY_SORT is
		external
			"IL signature (): System.Windows.Forms.PropertySort use System.Windows.Forms.PropertyGrid"
		alias
			"get_PropertySort"
		end

	get_help_visible: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.PropertyGrid"
		alias
			"get_HelpVisible"
		end

	frozen get_property_tabs: WINFORMS_PROPERTY_TAB_COLLECTION_IN_WINFORMS_PROPERTY_GRID is
		external
			"IL signature (): System.Windows.Forms.PropertyGrid+PropertyTabCollection use System.Windows.Forms.PropertyGrid"
		alias
			"get_PropertyTabs"
		end

	frozen get_view_fore_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.PropertyGrid"
		alias
			"get_ViewForeColor"
		end

	frozen get_large_buttons: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.PropertyGrid"
		alias
			"get_LargeButtons"
		end

	frozen get_browsable_attributes: SYSTEM_DLL_ATTRIBUTE_COLLECTION is
		external
			"IL signature (): System.ComponentModel.AttributeCollection use System.Windows.Forms.PropertyGrid"
		alias
			"get_BrowsableAttributes"
		end

	frozen get_commands_back_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.PropertyGrid"
		alias
			"get_CommandsBackColor"
		end

	frozen get_line_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.PropertyGrid"
		alias
			"get_LineColor"
		end

	frozen get_selected_grid_item: WINFORMS_GRID_ITEM is
		external
			"IL signature (): System.Windows.Forms.GridItem use System.Windows.Forms.PropertyGrid"
		alias
			"get_SelectedGridItem"
		end

	frozen get_controls_control_collection: WINFORMS_CONTROL_COLLECTION_IN_WINFORMS_CONTROL is
		external
			"IL signature (): System.Windows.Forms.Control+ControlCollection use System.Windows.Forms.PropertyGrid"
		alias
			"get_Controls"
		end

	frozen get_help_fore_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.PropertyGrid"
		alias
			"get_HelpForeColor"
		end

	frozen get_selected_tab: WINFORMS_PROPERTY_TAB is
		external
			"IL signature (): System.Windows.Forms.Design.PropertyTab use System.Windows.Forms.PropertyGrid"
		alias
			"get_SelectedTab"
		end

	frozen get_selected_objects: NATIVE_ARRAY [SYSTEM_OBJECT] is
		external
			"IL signature (): System.Object[] use System.Windows.Forms.PropertyGrid"
		alias
			"get_SelectedObjects"
		end

	get_toolbar_visible: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.PropertyGrid"
		alias
			"get_ToolbarVisible"
		end

	get_site: SYSTEM_DLL_ISITE is
		external
			"IL signature (): System.ComponentModel.ISite use System.Windows.Forms.PropertyGrid"
		alias
			"get_Site"
		end

	get_fore_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.PropertyGrid"
		alias
			"get_ForeColor"
		end

	frozen get_help_back_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.PropertyGrid"
		alias
			"get_HelpBackColor"
		end

	get_commands_visible: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.PropertyGrid"
		alias
			"get_CommandsVisible"
		end

	get_back_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.PropertyGrid"
		alias
			"get_BackColor"
		end

	get_background_image: DRAWING_IMAGE is
		external
			"IL signature (): System.Drawing.Image use System.Windows.Forms.PropertyGrid"
		alias
			"get_BackgroundImage"
		end

	get_commands_visible_if_available: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.PropertyGrid"
		alias
			"get_CommandsVisibleIfAvailable"
		end

	frozen get_context_menu_default_location: DRAWING_POINT is
		external
			"IL signature (): System.Drawing.Point use System.Windows.Forms.PropertyGrid"
		alias
			"get_ContextMenuDefaultLocation"
		end

	get_can_show_commands: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.PropertyGrid"
		alias
			"get_CanShowCommands"
		end

	frozen get_view_back_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.PropertyGrid"
		alias
			"get_ViewBackColor"
		end

	frozen get_commands_fore_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.PropertyGrid"
		alias
			"get_CommandsForeColor"
		end

	frozen get_selected_object: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Windows.Forms.PropertyGrid"
		alias
			"get_SelectedObject"
		end

	get_auto_scroll: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.PropertyGrid"
		alias
			"get_AutoScroll"
		end

feature -- Element Change

	frozen remove_selected_objects_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"remove_SelectedObjectsChanged"
		end

	frozen set_browsable_attributes (value: SYSTEM_DLL_ATTRIBUTE_COLLECTION) is
		external
			"IL signature (System.ComponentModel.AttributeCollection): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"set_BrowsableAttributes"
		end

	frozen remove_selected_grid_item_changed (value: WINFORMS_SELECTED_GRID_ITEM_CHANGED_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.SelectedGridItemChangedEventHandler): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"remove_SelectedGridItemChanged"
		end

	set_back_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"set_BackColor"
		end

	frozen set_property_sort (value: WINFORMS_PROPERTY_SORT) is
		external
			"IL signature (System.Windows.Forms.PropertySort): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"set_PropertySort"
		end

	frozen set_commands_fore_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"set_CommandsForeColor"
		end

	frozen add_property_value_changed (value: WINFORMS_PROPERTY_VALUE_CHANGED_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.PropertyValueChangedEventHandler): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"add_PropertyValueChanged"
		end

	frozen set_help_back_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"set_HelpBackColor"
		end

	set_auto_scroll (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"set_AutoScroll"
		end

	set_commands_visible_if_available (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"set_CommandsVisibleIfAvailable"
		end

	frozen set_view_back_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"set_ViewBackColor"
		end

	frozen set_help_fore_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"set_HelpForeColor"
		end

	frozen set_selected_object (value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"set_SelectedObject"
		end

	frozen set_line_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"set_LineColor"
		end

	frozen set_selected_objects (value: NATIVE_ARRAY [SYSTEM_OBJECT]) is
		external
			"IL signature (System.Object[]): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"set_SelectedObjects"
		end

	frozen add_selected_objects_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"add_SelectedObjectsChanged"
		end

	frozen set_commands_back_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"set_CommandsBackColor"
		end

	set_fore_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"set_ForeColor"
		end

	frozen set_selected_grid_item (value: WINFORMS_GRID_ITEM) is
		external
			"IL signature (System.Windows.Forms.GridItem): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"set_SelectedGridItem"
		end

	frozen remove_property_sort_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"remove_PropertySortChanged"
		end

	set_site (value: SYSTEM_DLL_ISITE) is
		external
			"IL signature (System.ComponentModel.ISite): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"set_Site"
		end

	frozen remove_property_value_changed (value: WINFORMS_PROPERTY_VALUE_CHANGED_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.PropertyValueChangedEventHandler): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"remove_PropertyValueChanged"
		end

	frozen add_property_tab_changed (value: WINFORMS_PROPERTY_TAB_CHANGED_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.PropertyTabChangedEventHandler): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"add_PropertyTabChanged"
		end

	set_toolbar_visible (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"set_ToolbarVisible"
		end

	frozen add_selected_grid_item_changed (value: WINFORMS_SELECTED_GRID_ITEM_CHANGED_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.SelectedGridItemChangedEventHandler): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"add_SelectedGridItemChanged"
		end

	frozen add_property_sort_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"add_PropertySortChanged"
		end

	frozen remove_property_tab_changed (value: WINFORMS_PROPERTY_TAB_CHANGED_EVENT_HANDLER) is
		external
			"IL signature (System.Windows.Forms.PropertyTabChangedEventHandler): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"remove_PropertyTabChanged"
		end

	frozen set_large_buttons (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"set_LargeButtons"
		end

	frozen set_view_fore_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"set_ViewForeColor"
		end

	set_help_visible (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"set_HelpVisible"
		end

	set_background_image (value: DRAWING_IMAGE) is
		external
			"IL signature (System.Drawing.Image): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"set_BackgroundImage"
		end

feature -- Basic Operations

	frozen expand_all_grid_items is
		external
			"IL signature (): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"ExpandAllGridItems"
		end

	frozen collapse_all_grid_items is
		external
			"IL signature (): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"CollapseAllGridItems"
		end

	frozen reset_selected_property is
		external
			"IL signature (): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"ResetSelectedProperty"
		end

	frozen refresh_tabs (tab_scope: SYSTEM_DLL_PROPERTY_TAB_SCOPE) is
		external
			"IL signature (System.ComponentModel.PropertyTabScope): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"RefreshTabs"
		end

	refresh is
		external
			"IL signature (): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"Refresh"
		end

feature {NONE} -- Implementation

	on_paint (pevent: WINFORMS_PAINT_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.PaintEventArgs): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"OnPaint"
		end

	on_mouse_up (me: WINFORMS_MOUSE_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.MouseEventArgs): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"OnMouseUp"
		end

	on_handle_destroyed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"OnHandleDestroyed"
		end

	frozen system_windows_forms_component_model_com2_interop_icom_property_browser_save_state (opt_root: REGISTRY_KEY) is
		external
			"IL signature (Microsoft.Win32.RegistryKey): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"System.Windows.Forms.ComponentModel.Com2Interop.IComPropertyBrowser.SaveState"
		end

	on_property_tab_changed (e: WINFORMS_PROPERTY_TAB_CHANGED_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.PropertyTabChangedEventArgs): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"OnPropertyTabChanged"
		end

	on_handle_created (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"OnHandleCreated"
		end

	frozen system_windows_forms_component_model_com2_interop_icom_property_browser_remove_com_component_name_changed (value: SYSTEM_DLL_COMPONENT_RENAME_EVENT_HANDLER) is
		external
			"IL signature (System.ComponentModel.Design.ComponentRenameEventHandler): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"System.Windows.Forms.ComponentModel.Com2Interop.IComPropertyBrowser.remove_ComComponentNameChanged"
		end

	on_font_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"OnFontChanged"
		end

	frozen system_windows_forms_component_model_com2_interop_icom_property_browser_handle_f4 is
		external
			"IL signature (): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"System.Windows.Forms.ComponentModel.Com2Interop.IComPropertyBrowser.HandleF4"
		end

	frozen on_com_component_name_changed (e: SYSTEM_DLL_COMPONENT_RENAME_EVENT_ARGS) is
		external
			"IL signature (System.ComponentModel.Design.ComponentRenameEventArgs): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"OnComComponentNameChanged"
		end

	on_selected_grid_item_changed (e: WINFORMS_SELECTED_GRID_ITEM_CHANGED_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.SelectedGridItemChangedEventArgs): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"OnSelectedGridItemChanged"
		end

	process_dialog_key (key_data: WINFORMS_KEYS): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.Keys): System.Boolean use System.Windows.Forms.PropertyGrid"
		alias
			"ProcessDialogKey"
		end

	frozen set_draw_flat_toolbar (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"set_DrawFlatToolbar"
		end

	on_selected_objects_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"OnSelectedObjectsChanged"
		end

	get_default_size: DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.PropertyGrid"
		alias
			"get_DefaultSize"
		end

	get_show_focus_cues: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.PropertyGrid"
		alias
			"get_ShowFocusCues"
		end

	dispose_boolean (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"Dispose"
		end

	wnd_proc (m: WINFORMS_MESSAGE) is
		external
			"IL signature (System.Windows.Forms.Message&): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"WndProc"
		end

	frozen system_windows_forms_component_model_com2_interop_icom_property_browser_add_com_component_name_changed (value: SYSTEM_DLL_COMPONENT_RENAME_EVENT_HANDLER) is
		external
			"IL signature (System.ComponentModel.Design.ComponentRenameEventHandler): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"System.Windows.Forms.ComponentModel.Com2Interop.IComPropertyBrowser.add_ComComponentNameChanged"
		end

	frozen on_notify_property_value_uiitems_changed (sender: SYSTEM_OBJECT; e: EVENT_ARGS) is
		external
			"IL signature (System.Object, System.EventArgs): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"OnNotifyPropertyValueUIItemsChanged"
		end

	frozen system_windows_forms_component_model_com2_interop_icom_property_browser_get_in_property_set: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.PropertyGrid"
		alias
			"System.Windows.Forms.ComponentModel.Com2Interop.IComPropertyBrowser.get_InPropertySet"
		end

	frozen show_events_button (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"ShowEventsButton"
		end

	frozen get_draw_flat_toolbar: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.PropertyGrid"
		alias
			"get_DrawFlatToolbar"
		end

	on_mouse_down (me: WINFORMS_MOUSE_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.MouseEventArgs): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"OnMouseDown"
		end

	on_got_focus (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"OnGotFocus"
		end

	on_property_value_changed (e: WINFORMS_PROPERTY_VALUE_CHANGED_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.PropertyValueChangedEventArgs): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"OnPropertyValueChanged"
		end

	frozen system_windows_forms_component_model_com2_interop_icom_property_browser_drop_down_done is
		external
			"IL signature (): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"System.Windows.Forms.ComponentModel.Com2Interop.IComPropertyBrowser.DropDownDone"
		end

	frozen system_windows_forms_component_model_com2_interop_icom_property_browser_ensure_pending_changes_committed: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.PropertyGrid"
		alias
			"System.Windows.Forms.ComponentModel.Com2Interop.IComPropertyBrowser.EnsurePendingChangesCommitted"
		end

	scale_core (dx: REAL; dy: REAL) is
		external
			"IL signature (System.Single, System.Single): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"ScaleCore"
		end

	frozen system_windows_forms_component_model_com2_interop_icom_property_browser_load_state (opt_root: REGISTRY_KEY) is
		external
			"IL signature (Microsoft.Win32.RegistryKey): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"System.Windows.Forms.ComponentModel.Com2Interop.IComPropertyBrowser.LoadState"
		end

	on_visible_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"OnVisibleChanged"
		end

	on_system_colors_changed (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"OnSystemColorsChanged"
		end

	on_resize (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"OnResize"
		end

	create_property_tab (tab_type: TYPE): WINFORMS_PROPERTY_TAB is
		external
			"IL signature (System.Type): System.Windows.Forms.Design.PropertyTab use System.Windows.Forms.PropertyGrid"
		alias
			"CreatePropertyTab"
		end

	on_mouse_move (me: WINFORMS_MOUSE_EVENT_ARGS) is
		external
			"IL signature (System.Windows.Forms.MouseEventArgs): System.Void use System.Windows.Forms.PropertyGrid"
		alias
			"OnMouseMove"
		end

	get_default_tab_type: TYPE is
		external
			"IL signature (): System.Type use System.Windows.Forms.PropertyGrid"
		alias
			"get_DefaultTabType"
		end

end -- class WINFORMS_PROPERTY_GRID
