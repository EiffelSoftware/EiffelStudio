indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.ComponentModel.Com2Interop.IComPropertyBrowser"

deferred external class
	SYSTEM_WINDOWS_FORMS_COMPONENTMODEL_COM2INTEROP_ICOMPROPERTYBROWSER

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
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

	add_com_component_name_changed (value: SYSTEM_COMPONENTMODEL_DESIGN_COMPONENTRENAMEEVENTHANDLER) is
		external
			"IL deferred signature (System.ComponentModel.Design.ComponentRenameEventHandler): System.Void use System.Windows.Forms.ComponentModel.Com2Interop.IComPropertyBrowser"
		alias
			"add_ComComponentNameChanged"
		end

	remove_com_component_name_changed (value: SYSTEM_COMPONENTMODEL_DESIGN_COMPONENTRENAMEEVENTHANDLER) is
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

	save_state (key: MICROSOFT_WIN32_REGISTRYKEY) is
		external
			"IL deferred signature (Microsoft.Win32.RegistryKey): System.Void use System.Windows.Forms.ComponentModel.Com2Interop.IComPropertyBrowser"
		alias
			"SaveState"
		end

	load_state (key: MICROSOFT_WIN32_REGISTRYKEY) is
		external
			"IL deferred signature (Microsoft.Win32.RegistryKey): System.Void use System.Windows.Forms.ComponentModel.Com2Interop.IComPropertyBrowser"
		alias
			"LoadState"
		end

end -- class SYSTEM_WINDOWS_FORMS_COMPONENTMODEL_COM2INTEROP_ICOMPROPERTYBROWSER
