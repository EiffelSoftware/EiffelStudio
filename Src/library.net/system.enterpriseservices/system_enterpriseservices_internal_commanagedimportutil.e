indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.EnterpriseServices.Internal.ComManagedImportUtil"

external class
	SYSTEM_ENTERPRISESERVICES_INTERNAL_COMMANAGEDIMPORTUTIL

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_ENTERPRISESERVICES_INTERNAL_ICOMMANAGEDIMPORTUTIL

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.EnterpriseServices.Internal.ComManagedImportUtil"
		end

feature -- Basic Operations

	frozen get_component_info (assembly_path: STRING; num_components: STRING; component_info: STRING) is
		external
			"IL signature (System.String, System.String&, System.String&): System.Void use System.EnterpriseServices.Internal.ComManagedImportUtil"
		alias
			"GetComponentInfo"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.EnterpriseServices.Internal.ComManagedImportUtil"
		alias
			"GetHashCode"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.EnterpriseServices.Internal.ComManagedImportUtil"
		alias
			"ToString"
		end

	equals (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.EnterpriseServices.Internal.ComManagedImportUtil"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.EnterpriseServices.Internal.ComManagedImportUtil"
		alias
			"Finalize"
		end

end -- class SYSTEM_ENTERPRISESERVICES_INTERNAL_COMMANAGEDIMPORTUTIL
