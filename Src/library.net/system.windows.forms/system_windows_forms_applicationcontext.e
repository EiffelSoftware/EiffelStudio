indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.ApplicationContext"

external class
	SYSTEM_WINDOWS_FORMS_APPLICATIONCONTEXT

inherit
	ANY
		redefine
			finalize
		end

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Windows.Forms.ApplicationContext"
		end

	frozen make_1 (main_form: SYSTEM_WINDOWS_FORMS_FORM) is
		external
			"IL creator signature (System.Windows.Forms.Form) use System.Windows.Forms.ApplicationContext"
		end

feature -- Access

	frozen get_main_form: SYSTEM_WINDOWS_FORMS_FORM is
		external
			"IL signature (): System.Windows.Forms.Form use System.Windows.Forms.ApplicationContext"
		alias
			"get_MainForm"
		end

feature -- Element Change

	frozen add_thread_exit (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.ApplicationContext"
		alias
			"add_ThreadExit"
		end

	frozen remove_thread_exit (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.ApplicationContext"
		alias
			"remove_ThreadExit"
		end

	frozen set_main_form (value: SYSTEM_WINDOWS_FORMS_FORM) is
		external
			"IL signature (System.Windows.Forms.Form): System.Void use System.Windows.Forms.ApplicationContext"
		alias
			"set_MainForm"
		end

feature -- Basic Operations

	frozen exit_thread is
		external
			"IL signature (): System.Void use System.Windows.Forms.ApplicationContext"
		alias
			"ExitThread"
		end

	dispose is
		external
			"IL signature (): System.Void use System.Windows.Forms.ApplicationContext"
		alias
			"Dispose"
		end

feature {NONE} -- Implementation

	dispose_boolean (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.ApplicationContext"
		alias
			"Dispose"
		end

	exit_thread_core is
		external
			"IL signature (): System.Void use System.Windows.Forms.ApplicationContext"
		alias
			"ExitThreadCore"
		end

	on_main_form_closed (sender: ANY; e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.Object, System.EventArgs): System.Void use System.Windows.Forms.ApplicationContext"
		alias
			"OnMainFormClosed"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Windows.Forms.ApplicationContext"
		alias
			"Finalize"
		end

end -- class SYSTEM_WINDOWS_FORMS_APPLICATIONCONTEXT
