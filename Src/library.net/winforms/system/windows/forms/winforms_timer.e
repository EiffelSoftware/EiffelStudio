indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.Timer"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_TIMER

inherit
	SYSTEM_DLL_COMPONENT
		redefine
			dispose_boolean,
			to_string
		end
	SYSTEM_DLL_ICOMPONENT
	IDISPOSABLE

create
	make_winforms_timer_1,
	make_winforms_timer

feature {NONE} -- Initialization

	frozen make_winforms_timer_1 (container: SYSTEM_DLL_ICONTAINER) is
		external
			"IL creator signature (System.ComponentModel.IContainer) use System.Windows.Forms.Timer"
		end

	frozen make_winforms_timer is
		external
			"IL creator use System.Windows.Forms.Timer"
		end

feature -- Access

	frozen get_interval: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.Timer"
		alias
			"get_Interval"
		end

	get_enabled: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.Timer"
		alias
			"get_Enabled"
		end

feature -- Element Change

	frozen add_tick (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Timer"
		alias
			"add_Tick"
		end

	frozen set_interval (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.Timer"
		alias
			"set_Interval"
		end

	set_enabled (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.Timer"
		alias
			"set_Enabled"
		end

	frozen remove_tick (value: EVENT_HANDLER) is
		external
			"IL signature (System.EventHandler): System.Void use System.Windows.Forms.Timer"
		alias
			"remove_Tick"
		end

feature -- Basic Operations

	frozen stop is
		external
			"IL signature (): System.Void use System.Windows.Forms.Timer"
		alias
			"Stop"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.Timer"
		alias
			"ToString"
		end

	frozen start is
		external
			"IL signature (): System.Void use System.Windows.Forms.Timer"
		alias
			"Start"
		end

feature {NONE} -- Implementation

	dispose_boolean (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.Timer"
		alias
			"Dispose"
		end

	on_tick (e: EVENT_ARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Timer"
		alias
			"OnTick"
		end

end -- class WINFORMS_TIMER
