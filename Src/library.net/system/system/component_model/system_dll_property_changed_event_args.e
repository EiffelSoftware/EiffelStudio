indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.PropertyChangedEventArgs"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_PROPERTY_CHANGED_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_system_dll_property_changed_event_args

feature {NONE} -- Initialization

	frozen make_system_dll_property_changed_event_args (property_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.ComponentModel.PropertyChangedEventArgs"
		end

feature -- Access

	get_property_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.ComponentModel.PropertyChangedEventArgs"
		alias
			"get_PropertyName"
		end

end -- class SYSTEM_DLL_PROPERTY_CHANGED_EVENT_ARGS
