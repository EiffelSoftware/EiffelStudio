indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.WellKnownServiceTypeEntry"

external class
	SYSTEM_RUNTIME_REMOTING_WELLKNOWNSERVICETYPEENTRY

inherit
	SYSTEM_RUNTIME_REMOTING_TYPEENTRY
		redefine
			to_string
		end

create
	make_wellknownservicetypeentry,
	make_wellknownservicetypeentry_1

feature {NONE} -- Initialization

	frozen make_wellknownservicetypeentry (type_name: STRING; assembly_name: STRING; object_uri: STRING; mode: SYSTEM_RUNTIME_REMOTING_WELLKNOWNOBJECTMODE) is
		external
			"IL creator signature (System.String, System.String, System.String, System.Runtime.Remoting.WellKnownObjectMode) use System.Runtime.Remoting.WellKnownServiceTypeEntry"
		end

	frozen make_wellknownservicetypeentry_1 (type: SYSTEM_TYPE; object_uri: STRING; mode: SYSTEM_RUNTIME_REMOTING_WELLKNOWNOBJECTMODE) is
		external
			"IL creator signature (System.Type, System.String, System.Runtime.Remoting.WellKnownObjectMode) use System.Runtime.Remoting.WellKnownServiceTypeEntry"
		end

feature -- Access

	frozen get_mode: SYSTEM_RUNTIME_REMOTING_WELLKNOWNOBJECTMODE is
		external
			"IL signature (): System.Runtime.Remoting.WellKnownObjectMode use System.Runtime.Remoting.WellKnownServiceTypeEntry"
		alias
			"get_Mode"
		end

	frozen get_object_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Runtime.Remoting.WellKnownServiceTypeEntry"
		alias
			"get_ObjectType"
		end

	frozen get_context_attributes: ARRAY [SYSTEM_RUNTIME_REMOTING_CONTEXTS_ICONTEXTATTRIBUTE] is
		external
			"IL signature (): System.Runtime.Remoting.Contexts.IContextAttribute[] use System.Runtime.Remoting.WellKnownServiceTypeEntry"
		alias
			"get_ContextAttributes"
		end

	frozen get_object_uri: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.WellKnownServiceTypeEntry"
		alias
			"get_ObjectUri"
		end

feature -- Element Change

	frozen set_context_attributes (value: ARRAY [SYSTEM_RUNTIME_REMOTING_CONTEXTS_ICONTEXTATTRIBUTE]) is
		external
			"IL signature (System.Runtime.Remoting.Contexts.IContextAttribute[]): System.Void use System.Runtime.Remoting.WellKnownServiceTypeEntry"
		alias
			"set_ContextAttributes"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.WellKnownServiceTypeEntry"
		alias
			"ToString"
		end

end -- class SYSTEM_RUNTIME_REMOTING_WELLKNOWNSERVICETYPEENTRY
