indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.ActivatedServiceTypeEntry"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	ACTIVATED_SERVICE_TYPE_ENTRY

inherit
	TYPE_ENTRY
		redefine
			to_string
		end

create
	make_activated_service_type_entry,
	make_activated_service_type_entry_1

feature {NONE} -- Initialization

	frozen make_activated_service_type_entry (type_name: SYSTEM_STRING; assembly_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String, System.String) use System.Runtime.Remoting.ActivatedServiceTypeEntry"
		end

	frozen make_activated_service_type_entry_1 (type: TYPE) is
		external
			"IL creator signature (System.Type) use System.Runtime.Remoting.ActivatedServiceTypeEntry"
		end

feature -- Access

	frozen get_object_type: TYPE is
		external
			"IL signature (): System.Type use System.Runtime.Remoting.ActivatedServiceTypeEntry"
		alias
			"get_ObjectType"
		end

	frozen get_context_attributes: NATIVE_ARRAY [ICONTEXT_ATTRIBUTE] is
		external
			"IL signature (): System.Runtime.Remoting.Contexts.IContextAttribute[] use System.Runtime.Remoting.ActivatedServiceTypeEntry"
		alias
			"get_ContextAttributes"
		end

feature -- Element Change

	frozen set_context_attributes (value: NATIVE_ARRAY [ICONTEXT_ATTRIBUTE]) is
		external
			"IL signature (System.Runtime.Remoting.Contexts.IContextAttribute[]): System.Void use System.Runtime.Remoting.ActivatedServiceTypeEntry"
		alias
			"set_ContextAttributes"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.ActivatedServiceTypeEntry"
		alias
			"ToString"
		end

end -- class ACTIVATED_SERVICE_TYPE_ENTRY
