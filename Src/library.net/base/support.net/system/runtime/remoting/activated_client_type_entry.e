indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.ActivatedClientTypeEntry"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	ACTIVATED_CLIENT_TYPE_ENTRY

inherit
	TYPE_ENTRY
		redefine
			to_string
		end

create
	make_activated_client_type_entry_1,
	make_activated_client_type_entry

feature {NONE} -- Initialization

	frozen make_activated_client_type_entry_1 (type: TYPE; app_url: SYSTEM_STRING) is
		external
			"IL creator signature (System.Type, System.String) use System.Runtime.Remoting.ActivatedClientTypeEntry"
		end

	frozen make_activated_client_type_entry (type_name: SYSTEM_STRING; assembly_name: SYSTEM_STRING; app_url: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.String, System.String) use System.Runtime.Remoting.ActivatedClientTypeEntry"
		end

feature -- Access

	frozen get_object_type: TYPE is
		external
			"IL signature (): System.Type use System.Runtime.Remoting.ActivatedClientTypeEntry"
		alias
			"get_ObjectType"
		end

	frozen get_application_url: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.ActivatedClientTypeEntry"
		alias
			"get_ApplicationUrl"
		end

	frozen get_context_attributes: NATIVE_ARRAY [ICONTEXT_ATTRIBUTE] is
		external
			"IL signature (): System.Runtime.Remoting.Contexts.IContextAttribute[] use System.Runtime.Remoting.ActivatedClientTypeEntry"
		alias
			"get_ContextAttributes"
		end

feature -- Element Change

	frozen set_context_attributes (value: NATIVE_ARRAY [ICONTEXT_ATTRIBUTE]) is
		external
			"IL signature (System.Runtime.Remoting.Contexts.IContextAttribute[]): System.Void use System.Runtime.Remoting.ActivatedClientTypeEntry"
		alias
			"set_ContextAttributes"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.ActivatedClientTypeEntry"
		alias
			"ToString"
		end

end -- class ACTIVATED_CLIENT_TYPE_ENTRY
