indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Timers.Timer"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_TIMER

inherit
	SYSTEM_DLL_COMPONENT
		redefine
			set_site,
			get_site,
			dispose_boolean
		end
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE
	SYSTEM_DLL_ISUPPORT_INITIALIZE

create
	make_system_dll_timer_1,
	make_system_dll_timer

feature {NONE} -- Initialization

	frozen make_system_dll_timer_1 (interval: DOUBLE) is
		external
			"IL creator signature (System.Double) use System.Timers.Timer"
		end

	frozen make_system_dll_timer is
		external
			"IL creator use System.Timers.Timer"
		end

feature -- Access

	frozen get_interval: DOUBLE is
		external
			"IL signature (): System.Double use System.Timers.Timer"
		alias
			"get_Interval"
		end

	get_site: SYSTEM_DLL_ISITE is
		external
			"IL signature (): System.ComponentModel.ISite use System.Timers.Timer"
		alias
			"get_Site"
		end

	frozen get_auto_reset: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Timers.Timer"
		alias
			"get_AutoReset"
		end

	frozen get_enabled: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Timers.Timer"
		alias
			"get_Enabled"
		end

	frozen get_synchronizing_object: SYSTEM_DLL_ISYNCHRONIZE_INVOKE is
		external
			"IL signature (): System.ComponentModel.ISynchronizeInvoke use System.Timers.Timer"
		alias
			"get_SynchronizingObject"
		end

feature -- Element Change

	frozen set_synchronizing_object (value: SYSTEM_DLL_ISYNCHRONIZE_INVOKE) is
		external
			"IL signature (System.ComponentModel.ISynchronizeInvoke): System.Void use System.Timers.Timer"
		alias
			"set_SynchronizingObject"
		end

	frozen set_auto_reset (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Timers.Timer"
		alias
			"set_AutoReset"
		end

	set_site (value: SYSTEM_DLL_ISITE) is
		external
			"IL signature (System.ComponentModel.ISite): System.Void use System.Timers.Timer"
		alias
			"set_Site"
		end

	frozen add_elapsed (value: SYSTEM_DLL_ELAPSED_EVENT_HANDLER) is
		external
			"IL signature (System.Timers.ElapsedEventHandler): System.Void use System.Timers.Timer"
		alias
			"add_Elapsed"
		end

	frozen remove_elapsed (value: SYSTEM_DLL_ELAPSED_EVENT_HANDLER) is
		external
			"IL signature (System.Timers.ElapsedEventHandler): System.Void use System.Timers.Timer"
		alias
			"remove_Elapsed"
		end

	frozen set_interval (value: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use System.Timers.Timer"
		alias
			"set_Interval"
		end

	frozen set_enabled (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Timers.Timer"
		alias
			"set_Enabled"
		end

feature -- Basic Operations

	frozen end_init is
		external
			"IL signature (): System.Void use System.Timers.Timer"
		alias
			"EndInit"
		end

	frozen start is
		external
			"IL signature (): System.Void use System.Timers.Timer"
		alias
			"Start"
		end

	frozen begin_init is
		external
			"IL signature (): System.Void use System.Timers.Timer"
		alias
			"BeginInit"
		end

	frozen stop is
		external
			"IL signature (): System.Void use System.Timers.Timer"
		alias
			"Stop"
		end

	frozen close is
		external
			"IL signature (): System.Void use System.Timers.Timer"
		alias
			"Close"
		end

feature {NONE} -- Implementation

	dispose_boolean (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Timers.Timer"
		alias
			"Dispose"
		end

end -- class SYSTEM_DLL_TIMER
