indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.EnterpriseServices.Internal.IISVirtualRoot"
	assembly: "System.EnterpriseServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	ENT_SERV_IISVIRTUAL_ROOT

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ENT_SERV_ICOM_SOAP_IISVROOT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.EnterpriseServices.Internal.IISVirtualRoot"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.EnterpriseServices.Internal.IISVirtualRoot"
		alias
			"GetHashCode"
		end

	frozen create_ (root_web: SYSTEM_STRING; in_physical_directory: SYSTEM_STRING; virtual_directory: SYSTEM_STRING; error: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String, System.String, System.String&): System.Void use System.EnterpriseServices.Internal.IISVirtualRoot"
		alias
			"Create"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.EnterpriseServices.Internal.IISVirtualRoot"
		alias
			"ToString"
		end

	frozen delete (root_web: SYSTEM_STRING; physical_directory: SYSTEM_STRING; virtual_directory: SYSTEM_STRING; error: SYSTEM_STRING) is
		external
			"IL signature (System.String, System.String, System.String, System.String&): System.Void use System.EnterpriseServices.Internal.IISVirtualRoot"
		alias
			"Delete"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.EnterpriseServices.Internal.IISVirtualRoot"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.EnterpriseServices.Internal.IISVirtualRoot"
		alias
			"Finalize"
		end

end -- class ENT_SERV_IISVIRTUAL_ROOT
