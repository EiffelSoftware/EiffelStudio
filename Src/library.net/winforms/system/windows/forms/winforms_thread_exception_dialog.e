indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.ThreadExceptionDialog"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_THREAD_EXCEPTION_DIALOG

inherit
	WINFORMS_FORM
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
	make_winforms_thread_exception_dialog

feature {NONE} -- Initialization

	frozen make_winforms_thread_exception_dialog (t: EXCEPTION) is
		external
			"IL creator signature (System.Exception) use System.Windows.Forms.ThreadExceptionDialog"
		end

end -- class WINFORMS_THREAD_EXCEPTION_DIALOG
