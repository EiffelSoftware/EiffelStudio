indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.Design.Serialization.INameCreationService"

deferred external class
	SYSTEM_COMPONENTMODEL_DESIGN_SERIALIZATION_INAMECREATIONSERVICE

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	is_valid_name (name: STRING): BOOLEAN is
		external
			"IL deferred signature (System.String): System.Boolean use System.ComponentModel.Design.Serialization.INameCreationService"
		alias
			"IsValidName"
		end

	create_name (container: SYSTEM_COMPONENTMODEL_ICONTAINER; data_type: SYSTEM_TYPE): STRING is
		external
			"IL deferred signature (System.ComponentModel.IContainer, System.Type): System.String use System.ComponentModel.Design.Serialization.INameCreationService"
		alias
			"CreateName"
		end

	validate_name (name: STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.ComponentModel.Design.Serialization.INameCreationService"
		alias
			"ValidateName"
		end

end -- class SYSTEM_COMPONENTMODEL_DESIGN_SERIALIZATION_INAMECREATIONSERVICE
