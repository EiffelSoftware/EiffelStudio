indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.Design.IReferenceService"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_IREFERENCE_SERVICE

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	get_component (reference: SYSTEM_OBJECT): SYSTEM_DLL_ICOMPONENT is
		external
			"IL deferred signature (System.Object): System.ComponentModel.IComponent use System.ComponentModel.Design.IReferenceService"
		alias
			"GetComponent"
		end

	get_reference (name: SYSTEM_STRING): SYSTEM_OBJECT is
		external
			"IL deferred signature (System.String): System.Object use System.ComponentModel.Design.IReferenceService"
		alias
			"GetReference"
		end

	get_references_type (base_type: TYPE): NATIVE_ARRAY [SYSTEM_OBJECT] is
		external
			"IL deferred signature (System.Type): System.Object[] use System.ComponentModel.Design.IReferenceService"
		alias
			"GetReferences"
		end

	get_name (reference: SYSTEM_OBJECT): SYSTEM_STRING is
		external
			"IL deferred signature (System.Object): System.String use System.ComponentModel.Design.IReferenceService"
		alias
			"GetName"
		end

	get_references: NATIVE_ARRAY [SYSTEM_OBJECT] is
		external
			"IL deferred signature (): System.Object[] use System.ComponentModel.Design.IReferenceService"
		alias
			"GetReferences"
		end

end -- class SYSTEM_DLL_IREFERENCE_SERVICE
