indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.ComponentModel.Com2Interop.IComPropertyBrowser"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	WINFORMS_ICOM_PROPERTY_BROWSER

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	get_in_property_set: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Windows.Forms.ComponentModel.Com2Interop.IComPropertyBrowser"
		alias
			"get_InPropertySet"
		end

feature -- Element Change

	add_com_component_name_changed (value: SYSTEM_DLL_COMPONENT_RENAME_EVENT_HANDLER) is
		external
			"IL deferred signature (System.ComponentModel.Design.ComponentRenameEventHandler): System.Void use System.Windows.Forms.ComponentModel.Com2Interop.IComPropertyBrowser"
		alias
			"add_ComComponentNameChanged"
		end

	remove_com_component_name_changed (value: SYSTEM_DLL_COMPONENT_RENAME_EVENT_HANDLER) is
		external
			"IL deferred signature (System.ComponentModel.Design.ComponentRenameEventHandler): System.Void use System.Windows.Forms.ComponentModel.Com2Interop.IComPropertyBrowser"
		alias
			"remove_ComComponentNameChanged"
		end

feature -- Basic Operations

	handle_f4 is
		external
			"IL deferred signature (): System.Void use System.Windows.Forms.ComponentModel.Com2Interop.IComPropertyBrowser"
		alias
			"HandleF4"
		end

	ensure_pending_changes_committed: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Windows.Forms.ComponentModel.Com2Interop.IComPropertyBrowser"
		alias
			"EnsurePendingChangesCommitted"
		end

	drop_down_done is
		external
			"IL deferred signature (): System.Void use System.Windows.Forms.ComponentModel.Com2Interop.IComPropertyBrowser"
		alias
			"DropDownDone"
		end

	save_state (key: REGISTRY_KEY) is
		external
			"IL deferred signature (Microsoft.Win32.RegistryKey): System.Void use System.Windows.Forms.ComponentModel.Com2Interop.IComPropertyBrowser"
		alias
			"SaveState"
		end

	load_state (key: REGISTRY_KEY) is
		external
			"IL deferred signature (Microsoft.Win32.RegistryKey): System.Void use System.Windows.Forms.ComponentModel.Com2Interop.IComPropertyBrowser"
		alias
			"LoadState"
		end

end -- class WINFORMS_ICOM_PROPERTY_BROWSER
