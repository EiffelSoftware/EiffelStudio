indexing
	Generator: "Eiffel Emitter 3.1rc1"
	external_name: "EiffelClassGenerator"

external class
	EIFFEL_CLASS_GENERATOR

inherit
	GLOBALS

create
	make_eiffel_class_generator

feature {NONE} -- Initialization

	frozen make_eiffel_class_generator is
		external
			"IL creator use EiffelClassGenerator"
		end

feature -- Basic Operations

	import_assembly_with_dependancies (assembly: ASSEMBLY; path_name: SYSTEM_STRING; eiffel_formatting: BOOLEAN) is
		external
			"IL signature (System.Reflection.Assembly, System.String, System.Boolean): System.Void use EiffelClassGenerator"
		alias
			"ImportAssemblyWithDependancies"
		end

	generate_eiffel_classes_from_xml (assembly: ASSEMBLY; path_name: SYSTEM_STRING) is
		external
			"IL signature (System.Reflection.Assembly, System.String): System.Void use EiffelClassGenerator"
		alias
			"GenerateEiffelClassesFromXml"
		end

	is_assembly_imported (assembly: ASSEMBLY): BOOLEAN is
		external
			"IL signature (System.Reflection.Assembly): System.Boolean use EiffelClassGenerator"
		alias
			"IsAssemblyImported"
		end

feature {NONE} -- Implementation

	generated_class (class_factory: EIFFEL_CLASS_FACTORY): EIFFEL_CLASS is
		external
			"IL signature (EiffelClassFactory): EIFFEL_CLASS use EiffelClassGenerator"
		alias
			"GeneratedClass"
		end

	generated_feature (class_factory: EIFFEL_CLASS_FACTORY; feature_name: SYSTEM_STRING; feature_table: HASHTABLE): EIFFEL_FEATURE is
		external
			"IL signature (EiffelClassFactory, System.String, System.Collections.Hashtable): EIFFEL_FEATURE use EiffelClassGenerator"
		alias
			"GeneratedFeature"
		end

	emit_eiffel_classes (assembly: ASSEMBLY; path_name: SYSTEM_STRING) is
		external
			"IL signature (System.Reflection.Assembly, System.String): System.Void use EiffelClassGenerator"
		alias
			"EmitEiffelClasses"
		end

	emit_from_assembly (assembly: ASSEMBLY; path_name: SYSTEM_STRING; is_imported: BOOLEAN; is_dependency: BOOLEAN) is
		external
			"IL signature (System.Reflection.Assembly, System.String, System.Boolean, System.Boolean): System.Void use EiffelClassGenerator"
		alias
			"EmitFromAssembly"
		end

	is_signed (assembly: ASSEMBLY): BOOLEAN is
		external
			"IL signature (System.Reflection.Assembly): System.Boolean use EiffelClassGenerator"
		alias
			"IsSigned"
		end

	emit_eiffel_classes_from_xml (assembly: ASSEMBLY; path_name: SYSTEM_STRING) is
		external
			"IL signature (System.Reflection.Assembly, System.String): System.Void use EiffelClassGenerator"
		alias
			"EmitEiffelClassesFromXml"
		end

	import_assembly_dependencies (assembly: ASSEMBLY; path_name: SYSTEM_STRING; eiffel_formatting: BOOLEAN) is
		external
			"IL signature (System.Reflection.Assembly, System.String, System.Boolean): System.Void use EiffelClassGenerator"
		alias
			"ImportAssemblyDependencies"
		end

	eiffel_path (assembly: ASSEMBLY; path_name: SYSTEM_STRING): SYSTEM_STRING is
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

	load_external_assemblies (assembly: ASSEMBLY): ARRAY_LIST is
		external
			"IL signature (System.Reflection.Assembly): System.Collections.ArrayList use EiffelClassGenerator"
		alias
			"LoadExternalAssemblies"
		end

	generated_assembly_factory (assembly_type: TYPE; eiffel_cluster_path: SYSTEM_STRING): EIFFEL_ASSEMBLY is
		external
			"IL signature (System.Type, System.String): EIFFEL_ASSEMBLY use EiffelClassGenerator"
		alias
			"GeneratedAssemblyFactory"
		end

	import_assembly_without_dependancies (assembly: ASSEMBLY; path_name: SYSTEM_STRING; eiffel_formatting: BOOLEAN; xml_generation: BOOLEAN; is_dependency: BOOLEAN) is
		external
			"IL signature (System.Reflection.Assembly, System.String, System.Boolean, System.Boolean, System.Boolean): System.Void use EiffelClassGenerator"
		alias
			"ImportAssemblyWithoutDependancies"
		end

	emit_xml_files (assembly: ASSEMBLY; path_name: SYSTEM_STRING) is
		external
			"IL signature (System.Reflection.Assembly, System.String): System.Void use EiffelClassGenerator"
		alias
			"EmitXmlFiles"
		end

	emit_xml_and_eiffel_files (assembly: ASSEMBLY; path_name: SYSTEM_STRING) is
		external
			"IL signature (System.Reflection.Assembly, System.String): System.Void use EiffelClassGenerator"
		alias
			"EmitXmlAndEiffelFiles"
		end

end -- class EIFFEL_CLASS_GENERATOR
