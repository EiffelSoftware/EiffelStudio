indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.RefreshEventArgs"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_REFRESH_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_system_dll_refresh_event_args,
	make_system_dll_refresh_event_args_1

feature {NONE} -- Initialization

	frozen make_system_dll_refresh_event_args (component_changed: SYSTEM_OBJECT) is
		external
			"IL creator signature (System.Object) use System.ComponentModel.RefreshEventArgs"
		end

	frozen make_system_dll_refresh_event_args_1 (type_changed: TYPE) is
		external
			"IL creator signature (System.Type) use System.ComponentModel.RefreshEventArgs"
		end

feature -- Access

	frozen get_component_changed: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.ComponentModel.RefreshEventArgs"
		alias
			"get_ComponentChanged"
		end

	frozen get_type_changed: TYPE is
		external
			"IL signature (): System.Type use System.ComponentModel.RefreshEventArgs"
		alias
			"get_TypeChanged"
		end

end -- class SYSTEM_DLL_REFRESH_EVENT_ARGS
