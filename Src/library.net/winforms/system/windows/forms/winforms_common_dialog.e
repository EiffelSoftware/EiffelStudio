indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.CommonDialog"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	WINFORMS_COMMON_DIALOG

inherit
	SYSTEM_DLL_COMPONENT
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE

feature -- Element Change

	frozen add_help_request (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.CommonDialog"
		alias
			"add_HelpRequest"
		end

	frozen remove_help_request (value: EVENT_HANDLER) is
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

	frozen show_dialog_iwin32_window (owner: WINFORMS_IWIN32_WINDOW): WINFORMS_DIALOG_RESULT is
		external
			"IL signature (System.Windows.Forms.IWin32Window): System.Windows.Forms.DialogResult use System.Windows.Forms.CommonDialog"
		alias
			"ShowDialog"
		end

	frozen show_dialog: WINFORMS_DIALOG_RESULT is
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

	on_help_request (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.CommonDialog"
		alias
			"OnHelpRequest"
		end

end -- class WINFORMS_COMMON_DIALOG
