indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.EnterpriseServices.Internal.ServerWebConfig"

external class
	SYSTEM_ENTERPRISESERVICES_INTERNAL_SERVERWEBCONFIG

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_ENTERPRISESERVICES_INTERNAL_ISERVERWEBCONFIG

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.EnterpriseServices.Internal.ServerWebConfig"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.EnterpriseServices.Internal.ServerWebConfig"
		alias
			"GetHashCode"
		end

	frozen add_element (file_path: STRING; assembly_name: STRING; type_name: STRING; prog_id: STRING; wko_mode: STRING; error: STRING) is
		external
			"IL signature (System.String, System.String, System.String, System.String, System.String, System.String&): System.Void use System.EnterpriseServices.Internal.ServerWebConfig"
		alias
			"AddElement"
		end

	frozen Create_ (file_path: STRING; file_prefix: STRING; error: STRING) is
		external
			"IL signature (System.String, System.String, System.String&): System.Void use System.EnterpriseServices.Internal.ServerWebConfig"
		alias
			"Create"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.EnterpriseServices.Internal.ServerWebConfig"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.EnterpriseServices.Internal.ServerWebConfig"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.EnterpriseServices.Internal.ServerWebConfig"
		alias
			"Finalize"
		end

end -- class SYSTEM_ENTERPRISESERVICES_INTERNAL_SERVERWEBCONFIG
