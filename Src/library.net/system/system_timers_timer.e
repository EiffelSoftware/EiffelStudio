indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Timers.Timer"

external class
	SYSTEM_TIMERS_TIMER

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_COMPONENTMODEL_COMPONENT
		redefine
			dispose,
			set_site,
			get_site,
			dispose_boolean
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_COMPONENTMODEL_ISUPPORTINITIALIZE

create
	make_timer,
	make_timer_1

feature {NONE} -- Initialization

	frozen make_timer is
		external
			"IL creator use System.Timers.Timer"
		end

	frozen make_timer_1 (interval: DOUBLE) is
		external
			"IL creator signature (System.Double) use System.Timers.Timer"
		end

feature -- Access

	frozen get_interval: DOUBLE is
		external
			"IL signature (): System.Double use System.Timers.Timer"
		alias
			"get_Interval"
		end

	get_site: SYSTEM_COMPONENTMODEL_ISITE is
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

	frozen get_synchronizing_object: SYSTEM_COMPONENTMODEL_ISYNCHRONIZEINVOKE is
		external
			"IL signature (): System.ComponentModel.ISynchronizeInvoke use System.Timers.Timer"
		alias
			"get_SynchronizingObject"
		end

feature -- Element Change

	frozen set_interval (value: DOUBLE) is
		external
			"IL signature (System.Double): System.Void use System.Timers.Timer"
		alias
			"set_Interval"
		end

	frozen set_auto_reset (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Timers.Timer"
		alias
			"set_AutoReset"
		end

	frozen add_elapsed (value: SYSTEM_TIMERS_ELAPSEDEVENTHANDLER) is
		external
			"IL signature (System.Timers.ElapsedEventHandler): System.Void use System.Timers.Timer"
		alias
			"add_Elapsed"
		end

	frozen add_tick (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Timers.Timer"
		alias
			"add_Tick"
		end

	set_site (value: SYSTEM_COMPONENTMODEL_ISITE) is
		external
			"IL signature (System.ComponentModel.ISite): System.Void use System.Timers.Timer"
		alias
			"set_Site"
		end

	frozen set_synchronizing_object (value: SYSTEM_COMPONENTMODEL_ISYNCHRONIZEINVOKE) is
		external
			"IL signature (System.ComponentModel.ISynchronizeInvoke): System.Void use System.Timers.Timer"
		alias
			"set_SynchronizingObject"
		end

	frozen set_enabled (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Timers.Timer"
		alias
			"set_Enabled"
		end

	frozen remove_tick (value: SYSTEM_EVENTHANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Timers.Timer"
		alias
			"remove_Tick"
		end

	frozen remove_elapsed (value: SYSTEM_TIMERS_ELAPSEDEVENTHANDLER) is
		external
			"IL signature (System.Timers.ElapsedEventHandler): System.Void use System.Timers.Timer"
		alias
			"remove_Elapsed"
		end

feature -- Basic Operations

	frozen end_init is
		external
			"IL signature (): System.Void use System.Timers.Timer"
		alias
			"EndInit"
		end

	dispose is
		external
			"IL signature (): System.Void use System.Timers.Timer"
		alias
			"Dispose"
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

end -- class SYSTEM_TIMERS_TIMER
