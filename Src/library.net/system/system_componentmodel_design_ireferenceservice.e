indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.Design.IReferenceService"

deferred external class
	SYSTEM_COMPONENTMODEL_DESIGN_IREFERENCESERVICE

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	get_component (reference: ANY): SYSTEM_COMPONENTMODEL_ICOMPONENT is
		external
			"IL deferred signature (System.Object): System.ComponentModel.IComponent use System.ComponentModel.Design.IReferenceService"
		alias
			"GetComponent"
		end

	get_reference (name: STRING): ANY is
		external
			"IL deferred signature (System.String): System.Object use System.ComponentModel.Design.IReferenceService"
		alias
			"GetReference"
		end

	get_references_type (base_type: SYSTEM_TYPE): ARRAY [ANY] is
		external
			"IL deferred signature (System.Type): System.Object[] use System.ComponentModel.Design.IReferenceService"
		alias
			"GetReferences"
		end

	get_name (reference: ANY): STRING is
		external
			"IL deferred signature (System.Object): System.String use System.ComponentModel.Design.IReferenceService"
		alias
			"GetName"
		end

	get_references: ARRAY [ANY] is
		external
			"IL deferred signature (): System.Object[] use System.ComponentModel.Design.IReferenceService"
		alias
			"GetReferences"
		end

end -- class SYSTEM_COMPONENTMODEL_DESIGN_IREFERENCESERVICE
