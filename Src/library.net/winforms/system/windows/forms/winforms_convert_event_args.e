indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.ConvertEventArgs"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_CONVERT_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_winforms_convert_event_args

feature {NONE} -- Initialization

	frozen make_winforms_convert_event_args (value: SYSTEM_OBJECT; desired_type: TYPE) is
		external
			"IL creator signature (System.Object, System.Type) use System.Windows.Forms.ConvertEventArgs"
		end

feature -- Access

	frozen get_desired_type: TYPE is
		external
			"IL signature (): System.Type use System.Windows.Forms.ConvertEventArgs"
		alias
			"get_DesiredType"
		end

	frozen get_value: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Windows.Forms.ConvertEventArgs"
		alias
			"get_Value"
		end

feature -- Element Change

	frozen set_value (value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Windows.Forms.ConvertEventArgs"
		alias
			"set_Value"
		end

end -- class WINFORMS_CONVERT_EVENT_ARGS
