indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.DefaultEventAttribute"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SYSTEM_DLL_DEFAULT_EVENT_ATTRIBUTE

inherit
	ATTRIBUTE
		redefine
			get_hash_code,
			equals
		end

create
	make_system_dll_default_event_attribute

feature {NONE} -- Initialization

	frozen make_system_dll_default_event_attribute (name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.ComponentModel.DefaultEventAttribute"
		end

feature -- Access

	frozen default_: SYSTEM_DLL_DEFAULT_EVENT_ATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.DefaultEventAttribute use System.ComponentModel.DefaultEventAttribute"
		alias
			"Default"
		end

	frozen get_name: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.ComponentModel.DefaultEventAttribute"
		alias
			"get_Name"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.DefaultEventAttribute"
		alias
			"GetHashCode"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.DefaultEventAttribute"
		alias
			"Equals"
		end

end -- class SYSTEM_DLL_DEFAULT_EVENT_ATTRIBUTE
