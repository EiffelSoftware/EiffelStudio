indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.WellKnownServiceTypeEntry"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WELL_KNOWN_SERVICE_TYPE_ENTRY

inherit
	TYPE_ENTRY
		redefine
			to_string
		end

create
	make_well_known_service_type_entry_1,
	make_well_known_service_type_entry

feature {NONE} -- Initialization

	frozen make_well_known_service_type_entry_1 (type: TYPE; object_uri: SYSTEM_STRING; mode: WELL_KNOWN_OBJECT_MODE) is
		external
			"IL creator signature (System.Type, System.String, System.Runtime.Remoting.WellKnownObjectMode) use System.Runtime.Remoting.WellKnownServiceTypeEntry"
		end

	frozen make_well_known_service_type_entry (type_name: SYSTEM_STRING; assembly_name: SYSTEM_STRING; object_uri: SYSTEM_STRING; mode: WELL_KNOWN_OBJECT_MODE) is
		external
			"IL creator signature (System.String, System.String, System.String, System.Runtime.Remoting.WellKnownObjectMode) use System.Runtime.Remoting.WellKnownServiceTypeEntry"
		end

feature -- Access

	frozen get_mode: WELL_KNOWN_OBJECT_MODE is
		external
			"IL signature (): System.Runtime.Remoting.WellKnownObjectMode use System.Runtime.Remoting.WellKnownServiceTypeEntry"
		alias
			"get_Mode"
		end

	frozen get_object_type: TYPE is
		external
			"IL signature (): System.Type use System.Runtime.Remoting.WellKnownServiceTypeEntry"
		alias
			"get_ObjectType"
		end

	frozen get_context_attributes: NATIVE_ARRAY [ICONTEXT_ATTRIBUTE] is
		external
			"IL signature (): System.Runtime.Remoting.Contexts.IContextAttribute[] use System.Runtime.Remoting.WellKnownServiceTypeEntry"
		alias
			"get_ContextAttributes"
		end

	frozen get_object_uri: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.WellKnownServiceTypeEntry"
		alias
			"get_ObjectUri"
		end

feature -- Element Change

	frozen set_context_attributes (value: NATIVE_ARRAY [ICONTEXT_ATTRIBUTE]) is
		external
			"IL signature (System.Runtime.Remoting.Contexts.IContextAttribute[]): System.Void use System.Runtime.Remoting.WellKnownServiceTypeEntry"
		alias
			"set_ContextAttributes"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.WellKnownServiceTypeEntry"
		alias
			"ToString"
		end

end -- class WELL_KNOWN_SERVICE_TYPE_ENTRY
