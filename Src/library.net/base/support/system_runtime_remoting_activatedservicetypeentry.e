indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.Remoting.ActivatedServiceTypeEntry"

external class
	SYSTEM_RUNTIME_REMOTING_ACTIVATEDSERVICETYPEENTRY

inherit
	SYSTEM_RUNTIME_REMOTING_TYPEENTRY
		redefine
			to_string
		end

create
	make_activated_service_type_entry,
	make_activated_service_type_entry_1

feature {NONE} -- Initialization

	frozen make_activated_service_type_entry (typeName2: STRING; assemblyName2: STRING) is
		external
			"IL creator signature (System.String, System.String) use System.Runtime.Remoting.ActivatedServiceTypeEntry"
		end

	frozen make_activated_service_type_entry_1 (type: SYSTEM_TYPE) is
		external
			"IL creator signature (System.Type) use System.Runtime.Remoting.ActivatedServiceTypeEntry"
		end

feature -- Access

	frozen get_object_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Runtime.Remoting.ActivatedServiceTypeEntry"
		alias
			"get_ObjectType"
		end

	frozen get_context_attributes: ARRAY [SYSTEM_RUNTIME_REMOTING_CONTEXTS_ICONTEXTATTRIBUTE] is
		external
			"IL signature (): System.Runtime.Remoting.Contexts.IContextAttribute[] use System.Runtime.Remoting.ActivatedServiceTypeEntry"
		alias
			"get_ContextAttributes"
		end

feature -- Element Change

	frozen set_context_attributes (value: ARRAY [SYSTEM_RUNTIME_REMOTING_CONTEXTS_ICONTEXTATTRIBUTE]) is
		external
			"IL signature (System.Runtime.Remoting.Contexts.IContextAttribute[]): System.Void use System.Runtime.Remoting.ActivatedServiceTypeEntry"
		alias
			"set_ContextAttributes"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.ActivatedServiceTypeEntry"
		alias
			"ToString"
		end

end -- class SYSTEM_RUNTIME_REMOTING_ACTIVATEDSERVICETYPEENTRY
