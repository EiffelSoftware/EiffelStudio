indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.ThreadExceptionDialog"

external class
	SYSTEM_WINDOWS_FORMS_THREADEXCEPTIONDIALOG

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
	SYSTEM_WINDOWS_FORMS_FORM
	SYSTEM_IDISPOSABLE
	SYSTEM_WINDOWS_FORMS_IWIN32WINDOW

create
	make_threadexceptiondialog

feature {NONE} -- Initialization

	frozen make_threadexceptiondialog (t: SYSTEM_EXCEPTION) is
		external
			"IL creator signature (System.Exception) use System.Windows.Forms.ThreadExceptionDialog"
		end

end -- class SYSTEM_WINDOWS_FORMS_THREADEXCEPTIONDIALOG
