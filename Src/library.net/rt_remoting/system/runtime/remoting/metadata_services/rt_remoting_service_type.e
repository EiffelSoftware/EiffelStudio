indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.Remoting.MetadataServices.ServiceType"
	assembly: "System.Runtime.Remoting", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	RT_REMOTING_SERVICE_TYPE

inherit
	SYSTEM_OBJECT

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make (type: TYPE) is
		external
			"IL creator signature (System.Type) use System.Runtime.Remoting.MetadataServices.ServiceType"
		end

	frozen make_1 (type: TYPE; url: SYSTEM_STRING) is
		external
			"IL creator signature (System.Type, System.String) use System.Runtime.Remoting.MetadataServices.ServiceType"
		end

feature -- Access

	frozen get_object_type: TYPE is
		external
			"IL signature (): System.Type use System.Runtime.Remoting.MetadataServices.ServiceType"
		alias
			"get_ObjectType"
		end

	frozen get_url: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.MetadataServices.ServiceType"
		alias
			"get_Url"
		end

end -- class RT_REMOTING_SERVICE_TYPE
