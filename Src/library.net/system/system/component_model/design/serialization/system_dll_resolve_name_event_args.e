indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.Design.Serialization.ResolveNameEventArgs"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_RESOLVE_NAME_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_system_dll_resolve_name_event_args

feature {NONE} -- Initialization

	frozen make_system_dll_resolve_name_event_args (name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.ComponentModel.Design.Serialization.ResolveNameEventArgs"
		end

feature -- Access

	frozen get_value: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.ComponentModel.Design.Serialization.ResolveNameEventArgs"
		alias
			"get_Value"
		end

	frozen get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.ComponentModel.Design.Serialization.ResolveNameEventArgs"
		alias
			"get_Name"
		end

feature -- Element Change

	frozen set_value (value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.ComponentModel.Design.Serialization.ResolveNameEventArgs"
		alias
			"set_Value"
		end

end -- class SYSTEM_DLL_RESOLVE_NAME_EVENT_ARGS
