indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.EnterpriseServices.Internal.IComSoapIISVRoot"

deferred external class
	SYSTEM_ENTERPRISESERVICES_INTERNAL_ICOMSOAPIISVROOT

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	Create_ (root_web: STRING; physical_directory: STRING; virtual_directory: STRING; error: STRING) is
		external
			"IL deferred signature (System.String, System.String, System.String, System.String&): System.Void use System.EnterpriseServices.Internal.IComSoapIISVRoot"
		alias
			"Create"
		end

	delete (root_web: STRING; physical_directory: STRING; virtual_directory: STRING; error: STRING) is
		external
			"IL deferred signature (System.String, System.String, System.String, System.String&): System.Void use System.EnterpriseServices.Internal.IComSoapIISVRoot"
		alias
			"Delete"
		end

end -- class SYSTEM_ENTERPRISESERVICES_INTERNAL_ICOMSOAPIISVROOT
