indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "EIFFEL_ASSEMBLY_IMP"

deferred external class
	EIFFEL_ASSEMBLY_IMP

inherit
	GLOBAL_CONVERSATION_ANY
	SUPPORT_IMP

feature -- Basic Operations

	types: ARRAY_LIST is
		external
			"IL deferred signature (): System.Collections.ArrayList use EIFFEL_ASSEMBLY_IMP"
		alias
			"types"
		end

	types_retrieval_failed_message: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use EIFFEL_ASSEMBLY_IMP"
		alias
			"types_retrieval_failed_message"
		end

	eiffel_cluster_path: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use EIFFEL_ASSEMBLY_IMP"
		alias
			"eiffel_cluster_path"
		end

	assembly_descriptor: ASSEMBLY_DESCRIPTOR is
		external
			"IL deferred signature (): ASSEMBLY_DESCRIPTOR use EIFFEL_ASSEMBLY_IMP"
		alias
			"assembly_descriptor"
		end

	a_set_class_interface (class_interface2: EIFFEL_ASSEMBLY) is
		external
			"IL deferred signature (EIFFEL_ASSEMBLY): System.Void use EIFFEL_ASSEMBLY_IMP"
		alias
			"_set_class_interface"
		end

	make (a_descriptor: ASSEMBLY_DESCRIPTOR; a_path: SYSTEM_STRING; a_number: SYSTEM_STRING) is
		external
			"IL deferred signature (ASSEMBLY_DESCRIPTOR, System.String, System.String): System.Void use EIFFEL_ASSEMBLY_IMP"
		alias
			"make"
		end

	make_from_interface (a_interface: EIFFEL_ASSEMBLY) is
		external
			"IL deferred signature (EIFFEL_ASSEMBLY): System.Void use EIFFEL_ASSEMBLY_IMP"
		alias
			"make_from_interface"
		end

	emitter_version_number: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use EIFFEL_ASSEMBLY_IMP"
		alias
			"emitter_version_number"
		end

	types_retrieval_failed: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use EIFFEL_ASSEMBLY_IMP"
		alias
			"types_retrieval_failed"
		end

	class_interface: EIFFEL_ASSEMBLY is
		external
			"IL deferred signature (): EIFFEL_ASSEMBLY use EIFFEL_ASSEMBLY_IMP"
		alias
			"class_interface"
		end

end -- class EIFFEL_ASSEMBLY_IMP
