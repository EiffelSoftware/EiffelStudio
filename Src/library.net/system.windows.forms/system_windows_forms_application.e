indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.Application"

frozen external class
	SYSTEM_WINDOWS_FORMS_APPLICATION

create {NONE}

feature -- Access

	frozen get_current_input_language: SYSTEM_WINDOWS_FORMS_INPUTLANGUAGE is
		external
			"IL static signature (): System.Windows.Forms.InputLanguage use System.Windows.Forms.Application"
		alias
			"get_CurrentInputLanguage"
		end

	frozen get_local_user_app_data_path: STRING is
		external
			"IL static signature (): System.String use System.Windows.Forms.Application"
		alias
			"get_LocalUserAppDataPath"
		end

	frozen get_safe_top_level_caption_format: STRING is
		external
			"IL static signature (): System.String use System.Windows.Forms.Application"
		alias
			"get_SafeTopLevelCaptionFormat"
		end

	frozen get_common_app_data_registry: MICROSOFT_WIN32_REGISTRYKEY is
		external
			"IL static signature (): Microsoft.Win32.RegistryKey use System.Windows.Forms.Application"
		alias
			"get_CommonAppDataRegistry"
		end

	frozen get_allow_quit: BOOLEAN is
		external
			"IL static signature (): System.Boolean use System.Windows.Forms.Application"
		alias
			"get_AllowQuit"
		end

	frozen get_user_app_data_path: STRING is
		external
			"IL static signature (): System.String use System.Windows.Forms.Application"
		alias
			"get_UserAppDataPath"
		end

	frozen get_current_culture: SYSTEM_GLOBALIZATION_CULTUREINFO is
		external
			"IL static signature (): System.Globalization.CultureInfo use System.Windows.Forms.Application"
		alias
			"get_CurrentCulture"
		end

	frozen get_user_app_data_registry: MICROSOFT_WIN32_REGISTRYKEY is
		external
			"IL static signature (): Microsoft.Win32.RegistryKey use System.Windows.Forms.Application"
		alias
			"get_UserAppDataRegistry"
		end

	frozen get_startup_path: STRING is
		external
			"IL static signature (): System.String use System.Windows.Forms.Application"
		alias
			"get_StartupPath"
		end

	frozen get_company_name: STRING is
		external
			"IL static signature (): System.String use System.Windows.Forms.Application"
		alias
			"get_CompanyName"
		end

	frozen get_product_name: STRING is
		external
			"IL static signature (): System.String use System.Windows.Forms.Application"
		alias
			"get_ProductName"
		end

	frozen get_message_loop: BOOLEAN is
		external
			"IL static signature (): System.Boolean use System.Windows.Forms.Application"
		alias
			"get_MessageLoop"
		end

	frozen get_product_version: STRING is
		external
			"IL static signature (): System.String use System.Windows.Forms.Application"
		alias
			"get_ProductVersion"
		end

	frozen get_common_app_data_path: STRING is
		external
			"IL static signature (): System.String use System.Windows.Forms.Application"
		alias
			"get_CommonAppDataPath"
		end

	frozen get_executable_path: STRING is
		external
			"IL static signature (): System.String use System.Windows.Forms.Application"
		alias
			"get_ExecutablePath"
		end

feature -- Element Change

	frozen set_current_culture (value: SYSTEM_GLOBALIZATION_CULTUREINFO) is
		external
			"IL static signature (System.Globalization.CultureInfo): System.Void use System.Windows.Forms.Application"
		alias
			"set_CurrentCulture"
		end

	frozen add_application_exit (value: SYSTEM_EVENTHANDLER) is
		external
			"IL static signature (System.EventHandler): System.Void use System.Windows.Forms.Application"
		alias
			"add_ApplicationExit"
		end

	frozen remove_application_exit (value: SYSTEM_EVENTHANDLER) is
		external
			"IL static signature (System.EventHandler): System.Void use System.Windows.Forms.Application"
		alias
			"remove_ApplicationExit"
		end

	frozen add_thread_exit (value: SYSTEM_EVENTHANDLER) is
		external
			"IL static signature (System.EventHandler): System.Void use System.Windows.Forms.Application"
		alias
			"add_ThreadExit"
		end

	frozen remove_thread_exit (value: SYSTEM_EVENTHANDLER) is
		external
			"IL static signature (System.EventHandler): System.Void use System.Windows.Forms.Application"
		alias
			"remove_ThreadExit"
		end

	frozen remove_idle (value: SYSTEM_EVENTHANDLER) is
		external
			"IL static signature (System.EventHandler): System.Void use System.Windows.Forms.Application"
		alias
			"remove_Idle"
		end

	frozen set_current_input_language (value: SYSTEM_WINDOWS_FORMS_INPUTLANGUAGE) is
		external
			"IL static signature (System.Windows.Forms.InputLanguage): System.Void use System.Windows.Forms.Application"
		alias
			"set_CurrentInputLanguage"
		end

	frozen set_safe_top_level_caption_format (value: STRING) is
		external
			"IL static signature (System.String): System.Void use System.Windows.Forms.Application"
		alias
			"set_SafeTopLevelCaptionFormat"
		end

	frozen add_idle (value: SYSTEM_EVENTHANDLER) is
		external
			"IL static signature (System.EventHandler): System.Void use System.Windows.Forms.Application"
		alias
			"add_Idle"
		end

	frozen remove_thread_exception (value: SYSTEM_THREADING_THREADEXCEPTIONEVENTHANDLER) is
		external
			"IL static signature (System.Threading.ThreadExceptionEventHandler): System.Void use System.Windows.Forms.Application"
		alias
			"remove_ThreadException"
		end

	frozen add_thread_exception (value: SYSTEM_THREADING_THREADEXCEPTIONEVENTHANDLER) is
		external
			"IL static signature (System.Threading.ThreadExceptionEventHandler): System.Void use System.Windows.Forms.Application"
		alias
			"add_ThreadException"
		end

feature -- Basic Operations

	frozen exit is
		external
			"IL static signature (): System.Void use System.Windows.Forms.Application"
		alias
			"Exit"
		end

	frozen remove_message_filter (value: SYSTEM_WINDOWS_FORMS_IMESSAGEFILTER) is
		external
			"IL static signature (System.Windows.Forms.IMessageFilter): System.Void use System.Windows.Forms.Application"
		alias
			"RemoveMessageFilter"
		end

	frozen on_thread_exception (t: SYSTEM_EXCEPTION) is
		external
			"IL static signature (System.Exception): System.Void use System.Windows.Forms.Application"
		alias
			"OnThreadException"
		end

	frozen run_application_context (context: SYSTEM_WINDOWS_FORMS_APPLICATIONCONTEXT) is
		external
			"IL static signature (System.Windows.Forms.ApplicationContext): System.Void use System.Windows.Forms.Application"
		alias
			"Run"
		end

	frozen do_events is
		external
			"IL static signature (): System.Void use System.Windows.Forms.Application"
		alias
			"DoEvents"
		end

	frozen ole_required: SYSTEM_THREADING_APARTMENTSTATE is
		external
			"IL static signature (): System.Threading.ApartmentState use System.Windows.Forms.Application"
		alias
			"OleRequired"
		end

	frozen run_form (main_form: SYSTEM_WINDOWS_FORMS_FORM) is
		external
			"IL static signature (System.Windows.Forms.Form): System.Void use System.Windows.Forms.Application"
		alias
			"Run"
		end

	frozen run is
		external
			"IL static signature (): System.Void use System.Windows.Forms.Application"
		alias
			"Run"
		end

	frozen add_message_filter (value: SYSTEM_WINDOWS_FORMS_IMESSAGEFILTER) is
		external
			"IL static signature (System.Windows.Forms.IMessageFilter): System.Void use System.Windows.Forms.Application"
		alias
			"AddMessageFilter"
		end

	frozen exit_thread is
		external
			"IL static signature (): System.Void use System.Windows.Forms.Application"
		alias
			"ExitThread"
		end

end -- class SYSTEM_WINDOWS_FORMS_APPLICATION
