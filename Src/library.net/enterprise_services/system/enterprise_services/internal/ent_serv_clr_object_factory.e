indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.EnterpriseServices.Internal.ClrObjectFactory"
	assembly: "System.EnterpriseServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	ENT_SERV_CLR_OBJECT_FACTORY

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ENT_SERV_ICLR_OBJECT_FACTORY

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.EnterpriseServices.Internal.ClrObjectFactory"
		end

feature -- Basic Operations

	frozen create_from_mailbox (mailbox: SYSTEM_STRING; mode: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL signature (System.String, System.String): System.Object use System.EnterpriseServices.Internal.ClrObjectFactory"
		alias
			"CreateFromMailbox"
		end

	frozen create_from_vroot (vroot_url: SYSTEM_STRING; mode: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL signature (System.String, System.String): System.Object use System.EnterpriseServices.Internal.ClrObjectFactory"
		alias
			"CreateFromVroot"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.EnterpriseServices.Internal.ClrObjectFactory"
		alias
			"GetHashCode"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.EnterpriseServices.Internal.ClrObjectFactory"
		alias
			"ToString"
		end

	frozen create_from_wsdl (wsdl_url: SYSTEM_STRING; mode: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL signature (System.String, System.String): System.Object use System.EnterpriseServices.Internal.ClrObjectFactory"
		alias
			"CreateFromWsdl"
		end

	frozen create_from_assembly (assembly_name: SYSTEM_STRING; type_name: SYSTEM_STRING; mode: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL signature (System.String, System.String, System.String): System.Object use System.EnterpriseServices.Internal.ClrObjectFactory"
		alias
			"CreateFromAssembly"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.EnterpriseServices.Internal.ClrObjectFactory"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.EnterpriseServices.Internal.ClrObjectFactory"
		alias
			"Finalize"
		end

end -- class ENT_SERV_CLR_OBJECT_FACTORY
