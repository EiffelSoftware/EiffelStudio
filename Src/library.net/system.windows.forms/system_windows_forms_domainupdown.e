indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.DomainUpDown"

external class
	SYSTEM_WINDOWS_FORMS_DOMAINUPDOWN

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_WINDOWS_FORMS_ICONTAINERCONTROL
		rename
			activate_control as system_windows_forms_icontainer_control_activate_control
		end
	SYSTEM_COMPONENTMODEL_ISYNCHRONIZEINVOKE
		rename
			invoke as invoke_delegate_array_object,
			begin_invoke as begin_invoke_delegate_array_object
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_WINDOWS_FORMS_IWIN32WINDOW
	SYSTEM_WINDOWS_FORMS_UPDOWNBASE
		redefine
			on_text_box_key_down,
			on_changed,
			create_accessibility_instance,
			to_string
		end

create
	make_domainupdown

feature {NONE} -- Initialization

	frozen make_domainupdown is
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

	frozen get_items: DOMAINUPDOWNITEMCOLLECTION_IN_SYSTEM_WINDOWS_FORMS_DOMAINUPDOWN is
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

	frozen get_selected_item: ANY is
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

	frozen remove_selected_item_changed (value: SYSTEM_EVENTHANDLER) is
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

	frozen add_selected_item_changed (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.DomainUpDown"
		alias
			"add_SelectedItemChanged"
		end

	frozen set_selected_item (value: ANY) is
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

	to_string: STRING is
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

	on_text_box_key_down (source: ANY; e: SYSTEM_WINDOWS_FORMS_KEYEVENTARGS) is
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

	frozen on_selected_item_changed (source: ANY; e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.Object, System.EventArgs): System.Void use System.Windows.Forms.DomainUpDown"
		alias
			"OnSelectedItemChanged"
		end

	on_changed (source: ANY; e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.Object, System.EventArgs): System.Void use System.Windows.Forms.DomainUpDown"
		alias
			"OnChanged"
		end

	create_accessibility_instance: SYSTEM_WINDOWS_FORMS_ACCESSIBLEOBJECT is
		external
			"IL signature (): System.Windows.Forms.AccessibleObject use System.Windows.Forms.DomainUpDown"
		alias
			"CreateAccessibilityInstance"
		end

end -- class SYSTEM_WINDOWS_FORMS_DOMAINUPDOWN
