indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Net.Sockets.LingerOption"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_LINGER_OPTION

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make (enable: BOOLEAN; seconds: INTEGER) is
		external
			"IL creator signature (System.Boolean, System.Int32) use System.Net.Sockets.LingerOption"
		end

feature -- Access

	frozen get_linger_time: INTEGER is
		external
			"IL signature (): System.Int32 use System.Net.Sockets.LingerOption"
		alias
			"get_LingerTime"
		end

	frozen get_enabled: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Net.Sockets.LingerOption"
		alias
			"get_Enabled"
		end

feature -- Element Change

	frozen set_enabled (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Net.Sockets.LingerOption"
		alias
			"set_Enabled"
		end

	frozen set_linger_time (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Net.Sockets.LingerOption"
		alias
			"set_LingerTime"
		end

end -- class SYSTEM_DLL_LINGER_OPTION
