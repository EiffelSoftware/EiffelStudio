indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.Timer"

external class
	SYSTEM_WINDOWS_FORMS_TIMER

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_COMPONENTMODEL_COMPONENT
		redefine
			dispose_boolean,
			to_string
		end
	SYSTEM_IDISPOSABLE

create
	make_timer,
	make_timer_1

feature {NONE} -- Initialization

	frozen make_timer is
		external
			"IL creator use System.Windows.Forms.Timer"
		end

	frozen make_timer_1 (container: SYSTEM_COMPONENTMODEL_ICONTAINER) is
		external
			"IL creator signature (System.ComponentModel.IContainer) use System.Windows.Forms.Timer"
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

	frozen add_tick (value: SYSTEM_EVENTHANDLER) is
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

	frozen remove_tick (value: SYSTEM_EVENTHANDLER) is
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

	to_string: STRING is
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

	on_tick (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.Timer"
		alias
			"OnTick"
		end

end -- class SYSTEM_WINDOWS_FORMS_TIMER
