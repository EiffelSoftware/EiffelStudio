indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.CommonDialog"

deferred external class
	SYSTEM_WINDOWS_FORMS_COMMONDIALOG

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_COMPONENTMODEL_COMPONENT
	SYSTEM_IDISPOSABLE

feature -- Element Change

	frozen add_help_request (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.CommonDialog"
		alias
			"add_HelpRequest"
		end

	frozen remove_help_request (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.CommonDialog"
		alias
			"remove_HelpRequest"
		end

feature -- Basic Operations

	reset is
		external
			"IL deferred signature (): System.Void use System.Windows.Forms.CommonDialog"
		alias
			"Reset"
		end

	frozen show_dialog: SYSTEM_WINDOWS_FORMS_DIALOGRESULT is
		external
			"IL signature (): System.Windows.Forms.DialogResult use System.Windows.Forms.CommonDialog"
		alias
			"ShowDialog"
		end

feature {NONE} -- Implementation

	run_dialog (hwnd_owner: POINTER): BOOLEAN is
		external
			"IL deferred signature (System.IntPtr): System.Boolean use System.Windows.Forms.CommonDialog"
		alias
			"RunDialog"
		end

	owner_wnd_proc (h_wnd: POINTER; msg: INTEGER; wparam: POINTER; lparam: POINTER): POINTER is
		external
			"IL signature (System.IntPtr, System.Int32, System.IntPtr, System.IntPtr): System.IntPtr use System.Windows.Forms.CommonDialog"
		alias
			"OwnerWndProc"
		end

	hook_proc (h_wnd: POINTER; msg: INTEGER; wparam: POINTER; lparam: POINTER): POINTER is
		external
			"IL signature (System.IntPtr, System.Int32, System.IntPtr, System.IntPtr): System.IntPtr use System.Windows.Forms.CommonDialog"
		alias
			"HookProc"
		end

	on_help_request (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.CommonDialog"
		alias
			"OnHelpRequest"
		end

end -- class SYSTEM_WINDOWS_FORMS_COMMONDIALOG
