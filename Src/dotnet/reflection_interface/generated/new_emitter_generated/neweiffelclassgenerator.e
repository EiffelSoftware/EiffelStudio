indexing
	Generator: "Eiffel Emitter 2.3b"
	external_name: "EiffelClassGenerator"

external class
	NEWEIFFELCLASSGENERATOR

inherit
	GLOBALS

create
	make_neweiffelclassgenerator

feature {NONE} -- Initialization

	frozen make_neweiffelclassgenerator is
		external
			"IL creator use EiffelClassGenerator"
		end

feature -- Basic Operations

	ImportAssemblyWithoutDependancies (assembly: SYSTEM_REFLECTION_ASSEMBLY; PathName: STRING; Formatting: BOOLEAN) is
		external
			"IL signature (System.Reflection.Assembly, System.String, System.Boolean): System.Void use EiffelClassGenerator"
		alias
			"ImportAssemblyWithoutDependancies"
		end

	GenerateEiffelClassesFromXmlAndPathName (assembly: SYSTEM_REFLECTION_ASSEMBLY; PathName: STRING) is
		external
			"IL signature (System.Reflection.Assembly, System.String): System.Void use EiffelClassGenerator"
		alias
			"GenerateEiffelClassesFromXmlAndPathName"
		end

	ImportAssemblyWithDependancies (assembly: SYSTEM_REFLECTION_ASSEMBLY; PathName: STRING; Formatting: BOOLEAN) is
		external
			"IL signature (System.Reflection.Assembly, System.String, System.Boolean): System.Void use EiffelClassGenerator"
		alias
			"ImportAssemblyWithDependancies"
		end

	GenerateEiffelClassesFromXml (assembly: SYSTEM_REFLECTION_ASSEMBLY) is
		external
			"IL signature (System.Reflection.Assembly): System.Void use EiffelClassGenerator"
		alias
			"GenerateEiffelClassesFromXml"
		end

	IsAssemblyImported (assembly: SYSTEM_REFLECTION_ASSEMBLY): BOOLEAN is
		external
			"IL signature (System.Reflection.Assembly): System.Boolean use EiffelClassGenerator"
		alias
			"IsAssemblyImported"
		end

feature {NONE} -- Implementation

	GeneratedFeature (ClassFactory: EIFFELCLASSFACTORY; FeatureName: STRING; FeatureTable: SYSTEM_COLLECTIONS_HASHTABLE): ISE_REFLECTION_EIFFELFEATURE is
		external
			"IL signature (EiffelClassFactory, System.String, System.Collections.Hashtable): ISE.Reflection.EiffelFeature use EiffelClassGenerator"
		alias
			"GeneratedFeature"
		end

	PrepareEiffelCodeGeneration (PathName: STRING) is
		external
			"IL signature (System.String): System.Void use EiffelClassGenerator"
		alias
			"PrepareEiffelCodeGeneration"
		end

	EmitEiffelClassesFromXml (PathName: STRING) is
		external
			"IL signature (System.String): System.Void use EiffelClassGenerator"
		alias
			"EmitEiffelClassesFromXml"
		end

	EmitFromAssembly (assembly: SYSTEM_REFLECTION_ASSEMBLY; PathName: STRING; importDependancies: BOOLEAN) is
		external
			"IL signature (System.Reflection.Assembly, System.String, System.Boolean): System.Void use EiffelClassGenerator"
		alias
			"EmitFromAssembly"
		end

	GeneratedClass (ClassFactory: EIFFELCLASSFACTORY): ISE_REFLECTION_EIFFELCLASS is
		external
			"IL signature (EiffelClassFactory): ISE.Reflection.EiffelClass use EiffelClassGenerator"
		alias
			"GeneratedClass"
		end

	IsEiffelPathValid: BOOLEAN is
		external
			"IL signature (): System.Boolean use EiffelClassGenerator"
		alias
			"IsEiffelPathValid"
		end

	EmitEiffelClasses (PathName: STRING) is
		external
			"IL signature (System.String): System.Void use EiffelClassGenerator"
		alias
			"EmitEiffelClasses"
		end

	EmitXmlFiles (PathName: STRING) is
		external
			"IL signature (System.String): System.Void use EiffelClassGenerator"
		alias
			"EmitXmlFiles"
		end

	GeneratedAssemblyFactory (AssemblyType: SYSTEM_TYPE): ISE_REFLECTION_EIFFELASSEMBLYFACTORY is
		external
			"IL signature (System.Type): ISE.Reflection.EiffelAssemblyFactory use EiffelClassGenerator"
		alias
			"GeneratedAssemblyFactory"
		end

end -- class NEWEIFFELCLASSGENERATOR
