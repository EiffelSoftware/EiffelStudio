indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.WellKnownClientTypeEntry"

external class
	SYSTEM_RUNTIME_REMOTING_WELLKNOWNCLIENTTYPEENTRY

inherit
	SYSTEM_RUNTIME_REMOTING_TYPEENTRY
		redefine
			to_string
		end

create
	make_wellknownclienttypeentry_1,
	make_wellknownclienttypeentry

feature {NONE} -- Initialization

	frozen make_wellknownclienttypeentry_1 (type: SYSTEM_TYPE; object_url: STRING) is
		external
			"IL creator signature (System.Type, System.String) use System.Runtime.Remoting.WellKnownClientTypeEntry"
		end

	frozen make_wellknownclienttypeentry (type_name: STRING; assembly_name: STRING; object_url: STRING) is
		external
			"IL creator signature (System.String, System.String, System.String) use System.Runtime.Remoting.WellKnownClientTypeEntry"
		end

feature -- Access

	frozen get_object_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Runtime.Remoting.WellKnownClientTypeEntry"
		alias
			"get_ObjectType"
		end

	frozen get_object_url: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.WellKnownClientTypeEntry"
		alias
			"get_ObjectUrl"
		end

	frozen get_application_url: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.WellKnownClientTypeEntry"
		alias
			"get_ApplicationUrl"
		end

feature -- Element Change

	frozen set_application_url (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Runtime.Remoting.WellKnownClientTypeEntry"
		alias
			"set_ApplicationUrl"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.WellKnownClientTypeEntry"
		alias
			"ToString"
		end

end -- class SYSTEM_RUNTIME_REMOTING_WELLKNOWNCLIENTTYPEENTRY
