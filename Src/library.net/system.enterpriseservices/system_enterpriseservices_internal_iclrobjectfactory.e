indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.EnterpriseServices.Internal.IClrObjectFactory"

deferred external class
	SYSTEM_ENTERPRISESERVICES_INTERNAL_ICLROBJECTFACTORY

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	create_from_mailbox (mailbox: STRING; mode: STRING): ANY is
		external
			"IL deferred signature (System.String, System.String): System.Object use System.EnterpriseServices.Internal.IClrObjectFactory"
		alias
			"CreateFromMailbox"
		end

	create_from_vroot (vroot_url: STRING; mode: STRING): ANY is
		external
			"IL deferred signature (System.String, System.String): System.Object use System.EnterpriseServices.Internal.IClrObjectFactory"
		alias
			"CreateFromVroot"
		end

	create_from_wsdl (wsdl_url: STRING; mode: STRING): ANY is
		external
			"IL deferred signature (System.String, System.String): System.Object use System.EnterpriseServices.Internal.IClrObjectFactory"
		alias
			"CreateFromWsdl"
		end

	create_from_assembly (assembly: STRING; type: STRING; mode: STRING): ANY is
		external
			"IL deferred signature (System.String, System.String, System.String): System.Object use System.EnterpriseServices.Internal.IClrObjectFactory"
		alias
			"CreateFromAssembly"
		end

end -- class SYSTEM_ENTERPRISESERVICES_INTERNAL_ICLROBJECTFACTORY
