indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.EnterpriseServices.Internal.IComManagedImportUtil"

deferred external class
	SYSTEM_ENTERPRISESERVICES_INTERNAL_ICOMMANAGEDIMPORTUTIL

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	get_component_info (assembly_path: STRING; num_components: STRING; component_info: STRING) is
		external
			"IL deferred signature (System.String, System.String&, System.String&): System.Void use System.EnterpriseServices.Internal.IComManagedImportUtil"
		alias
			"GetComponentInfo"
		end

end -- class SYSTEM_ENTERPRISESERVICES_INTERNAL_ICOMMANAGEDIMPORTUTIL
