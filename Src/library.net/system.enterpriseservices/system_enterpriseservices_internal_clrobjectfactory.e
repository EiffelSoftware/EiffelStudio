indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.EnterpriseServices.Internal.ClrObjectFactory"

external class
	SYSTEM_ENTERPRISESERVICES_INTERNAL_CLROBJECTFACTORY

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_ENTERPRISESERVICES_INTERNAL_ICLROBJECTFACTORY

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.EnterpriseServices.Internal.ClrObjectFactory"
		end

feature -- Basic Operations

	frozen create_from_mailbox (mailbox: STRING; mode: STRING): ANY is
		external
			"IL signature (System.String, System.String): System.Object use System.EnterpriseServices.Internal.ClrObjectFactory"
		alias
			"CreateFromMailbox"
		end

	frozen create_from_vroot (vroot_url: STRING; mode: STRING): ANY is
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

	to_string: STRING is
		external
			"IL signature (): System.String use System.EnterpriseServices.Internal.ClrObjectFactory"
		alias
			"ToString"
		end

	frozen create_from_wsdl (wsdl_url: STRING; mode: STRING): ANY is
		external
			"IL signature (System.String, System.String): System.Object use System.EnterpriseServices.Internal.ClrObjectFactory"
		alias
			"CreateFromWsdl"
		end

	frozen create_from_assembly (assembly_name: STRING; type_name: STRING; mode: STRING): ANY is
		external
			"IL signature (System.String, System.String, System.String): System.Object use System.EnterpriseServices.Internal.ClrObjectFactory"
		alias
			"CreateFromAssembly"
		end

	is_equal (obj: ANY): BOOLEAN is
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

end -- class SYSTEM_ENTERPRISESERVICES_INTERNAL_CLROBJECTFACTORY
