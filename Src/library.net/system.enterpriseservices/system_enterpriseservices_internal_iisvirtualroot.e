indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.EnterpriseServices.Internal.IISVirtualRoot"

external class
	SYSTEM_ENTERPRISESERVICES_INTERNAL_IISVIRTUALROOT

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_ENTERPRISESERVICES_INTERNAL_ICOMSOAPIISVROOT

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

	frozen Create_ (root_web: STRING; physical_directory: STRING; virtual_directory: STRING; error: STRING) is
		external
			"IL signature (System.String, System.String, System.String, System.String&): System.Void use System.EnterpriseServices.Internal.IISVirtualRoot"
		alias
			"Create"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.EnterpriseServices.Internal.IISVirtualRoot"
		alias
			"ToString"
		end

	frozen delete (root_web: STRING; physical_directory: STRING; virtual_directory: STRING; error: STRING) is
		external
			"IL signature (System.String, System.String, System.String, System.String&): System.Void use System.EnterpriseServices.Internal.IISVirtualRoot"
		alias
			"Delete"
		end

	is_equal (obj: ANY): BOOLEAN is
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

end -- class SYSTEM_ENTERPRISESERVICES_INTERNAL_IISVIRTUALROOT
