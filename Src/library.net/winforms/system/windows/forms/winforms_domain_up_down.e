indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.DomainUpDown"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_DOMAIN_UP_DOWN

inherit
	WINFORMS_UP_DOWN_BASE
		redefine
			on_text_box_key_down,
			on_changed,
			wnd_proc,
			create_accessibility_instance,
			to_string
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

create
	make_winforms_domain_up_down

feature {NONE} -- Initialization

	frozen make_winforms_domain_up_down is
		external
			"IL creator use System.Windows.Forms.DomainUpDown"
		end

feature -- Access

	frozen get_selected_index: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.DomainUpDown"
		alias
			"get_SelectedIndex"
		end

	frozen get_items: WINFORMS_DOMAIN_UP_DOWN_ITEM_COLLECTION_IN_WINFORMS_DOMAIN_UP_DOWN is
		external
			"IL signature (): System.Windows.Forms.DomainUpDown+DomainUpDownItemCollection use System.Windows.Forms.DomainUpDown"
		alias
			"get_Items"
		end

	frozen get_sorted: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.DomainUpDown"
		alias
			"get_Sorted"
		end

	frozen get_selected_item: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Windows.Forms.DomainUpDown"
		alias
			"get_SelectedItem"
		end

	frozen get_wrap: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.DomainUpDown"
		alias
			"get_Wrap"
		end

feature -- Element Change

	frozen set_wrap (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.DomainUpDown"
		alias
			"set_Wrap"
		end

	frozen remove_selected_item_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DomainUpDown"
		alias
			"remove_SelectedItemChanged"
		end

	frozen set_selected_index (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.DomainUpDown"
		alias
			"set_SelectedIndex"
		end

	frozen set_sorted (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.DomainUpDown"
		alias
			"set_Sorted"
		end

	frozen add_selected_item_changed (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DomainUpDown"
		alias
			"add_SelectedItemChanged"
		end

	frozen set_selected_item (value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Windows.Forms.DomainUpDown"
		alias
			"set_SelectedItem"
		end

feature -- Basic Operations

	down_button is
		external
			"IL signature (): System.Void use System.Windows.Forms.DomainUpDown"
		alias
			"DownButton"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.DomainUpDown"
		alias
			"ToString"
		end

	up_button is
		external
			"IL signature (): System.Void use System.Windows.Forms.DomainUpDown"
		alias
			"UpButton"
		end

feature {NONE} -- Implementation

	frozen on_selected_item_changed (source: SYSTEM_OBJECT; e: EVENT_ARGS) is
		external
			"IL signature (System.Object, System.EventArgs): System.Void use System.Windows.Forms.DomainUpDown"
		alias
			"OnSelectedItemChanged"
		end

	on_text_box_key_down (source: SYSTEM_OBJECT; e: WINFORMS_KEY_EVENT_ARGS) is
		external
			"IL signature (System.Object, System.Windows.Forms.KeyEventArgs): System.Void use System.Windows.Forms.DomainUpDown"
		alias
			"OnTextBoxKeyDown"
		end

	update_edit_text is
		external
			"IL signature (): System.Void use System.Windows.Forms.DomainUpDown"
		alias
			"UpdateEditText"
		end

	wnd_proc (m: WINFORMS_MESSAGE) is
		external
			"IL signature (System.Windows.Forms.Message&): System.Void use System.Windows.Forms.DomainUpDown"
		alias
			"WndProc"
		end

	on_changed (source: SYSTEM_OBJECT; e: EVENT_ARGS) is
		external
			"IL signature (System.Object, System.EventArgs): System.Void use System.Windows.Forms.DomainUpDown"
		alias
			"OnChanged"
		end

	create_accessibility_instance: WINFORMS_ACCESSIBLE_OBJECT is
		external
			"IL signature (): System.Windows.Forms.AccessibleObject use System.Windows.Forms.DomainUpDown"
		alias
			"CreateAccessibilityInstance"
		end

end -- class WINFORMS_DOMAIN_UP_DOWN
