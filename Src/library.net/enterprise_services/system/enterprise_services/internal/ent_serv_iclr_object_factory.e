indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.EnterpriseServices.Internal.IClrObjectFactory"
	assembly: "System.EnterpriseServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

deferred external class
	ENT_SERV_ICLR_OBJECT_FACTORY

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	create_from_mailbox (mailbox: SYSTEM_STRING; mode: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL deferred signature (System.String, System.String): System.Object use System.EnterpriseServices.Internal.IClrObjectFactory"
		alias
			"CreateFromMailbox"
		end

	create_from_vroot (vroot_url: SYSTEM_STRING; mode: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL deferred signature (System.String, System.String): System.Object use System.EnterpriseServices.Internal.IClrObjectFactory"
		alias
			"CreateFromVroot"
		end

	create_from_wsdl (wsdl_url: SYSTEM_STRING; mode: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL deferred signature (System.String, System.String): System.Object use System.EnterpriseServices.Internal.IClrObjectFactory"
		alias
			"CreateFromWsdl"
		end

	create_from_assembly (assembly: SYSTEM_STRING; type: SYSTEM_STRING; mode: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL deferred signature (System.String, System.String, System.String): System.Object use System.EnterpriseServices.Internal.IClrObjectFactory"
		alias
			"CreateFromAssembly"
		end

end -- class ENT_SERV_ICLR_OBJECT_FACTORY
