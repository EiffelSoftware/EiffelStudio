indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.WellKnownClientTypeEntry"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WELL_KNOWN_CLIENT_TYPE_ENTRY

inherit
	TYPE_ENTRY
		redefine
			to_string
		end

create
	make_well_known_client_type_entry_1,
	make_well_known_client_type_entry

feature {NONE} -- Initialization

	frozen make_well_known_client_type_entry_1 (type: TYPE; object_url: SYSTEM_STRING) is
		external
			"IL creator signature (System.Type, System.String) use System.Runtime.Remoting.WellKnownClientTypeEntry"
		end

	frozen make_well_known_client_type_entry (type_name: SYSTEM_STRING; assembly_name: SYSTEM_STRING; object_url: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.String, System.String) use System.Runtime.Remoting.WellKnownClientTypeEntry"
		end

feature -- Access

	frozen get_object_type: TYPE is
		external
			"IL signature (): System.Type use System.Runtime.Remoting.WellKnownClientTypeEntry"
		alias
			"get_ObjectType"
		end

	frozen get_object_url: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.WellKnownClientTypeEntry"
		alias
			"get_ObjectUrl"
		end

	frozen get_application_url: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.WellKnownClientTypeEntry"
		alias
			"get_ApplicationUrl"
		end

feature -- Element Change

	frozen set_application_url (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Remoting.WellKnownClientTypeEntry"
		alias
			"set_ApplicationUrl"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.WellKnownClientTypeEntry"
		alias
			"ToString"
		end

end -- class WELL_KNOWN_CLIENT_TYPE_ENTRY
