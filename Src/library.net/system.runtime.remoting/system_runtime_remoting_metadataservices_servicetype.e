indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.Remoting.MetadataServices.ServiceType"

external class
	SYSTEM_RUNTIME_REMOTING_METADATASERVICES_SERVICETYPE

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make (type: SYSTEM_TYPE) is
		external
			"IL creator signature (System.Type) use System.Runtime.Remoting.MetadataServices.ServiceType"
		end

	frozen make_1 (type: SYSTEM_TYPE; url: STRING) is
		external
			"IL creator signature (System.Type, System.String) use System.Runtime.Remoting.MetadataServices.ServiceType"
		end

feature -- Access

	frozen get_object_type: SYSTEM_TYPE is
		external
			"IL signature (): System.Type use System.Runtime.Remoting.MetadataServices.ServiceType"
		alias
			"get_ObjectType"
		end

	frozen get_url: STRING is
		external
			"IL signature (): System.String use System.Runtime.Remoting.MetadataServices.ServiceType"
		alias
			"get_Url"
		end

end -- class SYSTEM_RUNTIME_REMOTING_METADATASERVICES_SERVICETYPE
