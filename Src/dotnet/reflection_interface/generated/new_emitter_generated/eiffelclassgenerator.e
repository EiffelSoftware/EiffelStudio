indexing
	generator: "Eiffel Emitter 2.8b2"
	external_name: "EiffelClassGenerator"
	assembly: "ISE.Reflection.Emitter", "1.0.0.62252", "neutral", "20ff36d6debc9ba6"

external class
	EIFFELCLASSGENERATOR

inherit
	GLOBALS

create
	make_eiffelclassgenerator

feature {NONE} -- Initialization

	frozen make_eiffelclassgenerator is
		external
			"IL creator use EiffelClassGenerator"
		end

feature -- Basic Operations

	import_assembly_with_dependancies (assembly: SYSTEM_REFLECTION_ASSEMBLY; path_name: STRING; eiffel_formatting: BOOLEAN) is
		external
			"IL signature (System.Reflection.Assembly, System.String, System.Boolean): System.Void use EiffelClassGenerator"
		alias
			"ImportAssemblyWithDependancies"
		end

	generate_eiffel_classes_from_xml (assembly: SYSTEM_REFLECTION_ASSEMBLY; path_name: STRING) is
		external
			"IL signature (System.Reflection.Assembly, System.String): System.Void use EiffelClassGenerator"
		alias
			"GenerateEiffelClassesFromXml"
		end

	is_assembly_imported (assembly: SYSTEM_REFLECTION_ASSEMBLY): BOOLEAN is
		external
			"IL signature (System.Reflection.Assembly): System.Boolean use EiffelClassGenerator"
		alias
			"IsAssemblyImported"
		end

feature {NONE} -- Implementation

	generated_class (class_factory: EIFFELCLASSFACTORY): ISE_REFLECTION_EIFFELCLASS is
		external
			"IL signature (EiffelClassFactory): ISE.Reflection.EiffelClass use EiffelClassGenerator"
		alias
			"GeneratedClass"
		end

	generated_feature (class_factory: EIFFELCLASSFACTORY; feature_name: STRING; feature_table: SYSTEM_COLLECTIONS_HASHTABLE): ISE_REFLECTION_EIFFELFEATURE is
		external
			"IL signature (EiffelClassFactory, System.String, System.Collections.Hashtable): ISE.Reflection.EiffelFeature use EiffelClassGenerator"
		alias
			"GeneratedFeature"
		end

	emit_eiffel_classes (assembly: SYSTEM_REFLECTION_ASSEMBLY; path_name: STRING) is
		external
			"IL signature (System.Reflection.Assembly, System.String): System.Void use EiffelClassGenerator"
		alias
			"EmitEiffelClasses"
		end

	emit_from_assembly (assembly: SYSTEM_REFLECTION_ASSEMBLY; path_name: STRING; is_imported: BOOLEAN; is_dependency: BOOLEAN) is
		external
			"IL signature (System.Reflection.Assembly, System.String, System.Boolean, System.Boolean): System.Void use EiffelClassGenerator"
		alias
			"EmitFromAssembly"
		end

	is_signed (assembly: SYSTEM_REFLECTION_ASSEMBLY): BOOLEAN is
		external
			"IL signature (System.Reflection.Assembly): System.Boolean use EiffelClassGenerator"
		alias
			"IsSigned"
		end

	emit_eiffel_classes_from_xml (assembly: SYSTEM_REFLECTION_ASSEMBLY; path_name: STRING) is
		external
			"IL signature (System.Reflection.Assembly, System.String): System.Void use EiffelClassGenerator"
		alias
			"EmitEiffelClassesFromXml"
		end

	import_assembly_dependencies (assembly: SYSTEM_REFLECTION_ASSEMBLY; path_name: STRING; eiffel_formatting: BOOLEAN) is
		external
			"IL signature (System.Reflection.Assembly, System.String, System.Boolean): System.Void use EiffelClassGenerator"
		alias
			"ImportAssemblyDependencies"
		end

	eiffel_path (assembly: SYSTEM_REFLECTION_ASSEMBLY; path_name: STRING): STRING is
		external
			"IL signature (System.Reflection.Assembly, System.String): System.String use EiffelClassGenerator"
		alias
			"EiffelPath"
		end

	is_eiffel_path_valid: BOOLEAN is
		external
			"IL signature (): System.Boolean use EiffelClassGenerator"
		alias
			"IsEiffelPathValid"
		end

	load_external_assemblies (assembly: SYSTEM_REFLECTION_ASSEMBLY): SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL signature (System.Reflection.Assembly): System.Collections.ArrayList use EiffelClassGenerator"
		alias
			"LoadExternalAssemblies"
		end

	generated_assembly_factory (assembly_type: SYSTEM_TYPE; eiffel_cluster_path: STRING): ISE_REFLECTION_EIFFELASSEMBLY is
		external
			"IL signature (System.Type, System.String): ISE.Reflection.EiffelAssembly use EiffelClassGenerator"
		alias
			"GeneratedAssemblyFactory"
		end

	import_assembly_without_dependancies (assembly: SYSTEM_REFLECTION_ASSEMBLY; path_name: STRING; eiffel_formatting: BOOLEAN; xml_generation: BOOLEAN; is_dependency: BOOLEAN) is
		external
			"IL signature (System.Reflection.Assembly, System.String, System.Boolean, System.Boolean, System.Boolean): System.Void use EiffelClassGenerator"
		alias
			"ImportAssemblyWithoutDependancies"
		end

	emit_xml_files (assembly: SYSTEM_REFLECTION_ASSEMBLY; path_name: STRING) is
		external
			"IL signature (System.Reflection.Assembly, System.String): System.Void use EiffelClassGenerator"
		alias
			"EmitXmlFiles"
		end

	emit_xml_and_eiffel_files (assembly: SYSTEM_REFLECTION_ASSEMBLY; path_name: STRING) is
		external
			"IL signature (System.Reflection.Assembly, System.String): System.Void use EiffelClassGenerator"
		alias
			"EmitXmlAndEiffelFiles"
		end

end -- class EIFFELCLASSGENERATOR
