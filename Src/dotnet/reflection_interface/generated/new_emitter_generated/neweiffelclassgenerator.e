indexing
	Generator: "Eiffel Emitter 2.3b"
	external_name: "NewEiffelClassGenerator"

external class
	NEWEIFFELCLASSGENERATOR

inherit
	NEWGLOBALS

create
	make_neweiffelclassgenerator

feature {NONE} -- Initialization

	frozen make_neweiffelclassgenerator is
		external
			"IL creator use NewEiffelClassGenerator"
		end

feature -- Basic Operations

	ImportAssemblyWithoutDependancies (assembly: SYSTEM_REFLECTION_ASSEMBLY; PathName: STRING) is
		external
			"IL signature (System.Reflection.Assembly, System.String): System.Void use NewEiffelClassGenerator"
		alias
			"ImportAssemblyWithoutDependancies"
		end

	ImportAssemblyWithDependancies (assembly: SYSTEM_REFLECTION_ASSEMBLY; PathName: STRING) is
		external
			"IL signature (System.Reflection.Assembly, System.String): System.Void use NewEiffelClassGenerator"
		alias
			"ImportAssemblyWithDependancies"
		end

	GenerateEiffelClassesFromXml (assembly: SYSTEM_REFLECTION_ASSEMBLY) is
		external
			"IL signature (System.Reflection.Assembly): System.Void use NewEiffelClassGenerator"
		alias
			"GenerateEiffelClassesFromXml"
		end

	IsAssemblyImported (assembly: SYSTEM_REFLECTION_ASSEMBLY): BOOLEAN is
		external
			"IL signature (System.Reflection.Assembly): System.Boolean use NewEiffelClassGenerator"
		alias
			"IsAssemblyImported"
		end

feature {NONE} -- Implementation

	GeneratedFeature (ClassFactory: NEWEIFFELCLASSFACTORY; FeatureName: STRING; FeatureTable: SYSTEM_COLLECTIONS_HASHTABLE): ISE_REFLECTION_EIFFELFEATURE is
		external
			"IL signature (NewEiffelClassFactory, System.String, System.Collections.Hashtable): ISE.Reflection.EiffelFeature use NewEiffelClassGenerator"
		alias
			"GeneratedFeature"
		end

	PrepareEiffelCodeGeneration (PathName: STRING) is
		external
			"IL signature (System.String): System.Void use NewEiffelClassGenerator"
		alias
			"PrepareEiffelCodeGeneration"
		end

	EmitEiffelClassesFromXml is
		external
			"IL signature (): System.Void use NewEiffelClassGenerator"
		alias
			"EmitEiffelClassesFromXml"
		end

	EmitFromAssembly (assembly: SYSTEM_REFLECTION_ASSEMBLY; PathName: STRING; importDependancies: BOOLEAN) is
		external
			"IL signature (System.Reflection.Assembly, System.String, System.Boolean): System.Void use NewEiffelClassGenerator"
		alias
			"EmitFromAssembly"
		end

	GeneratedClass (ClassFactory: NEWEIFFELCLASSFACTORY): ISE_REFLECTION_EIFFELCLASS is
		external
			"IL signature (NewEiffelClassFactory): ISE.Reflection.EiffelClass use NewEiffelClassGenerator"
		alias
			"GeneratedClass"
		end

	IsEiffelPathValid: BOOLEAN is
		external
			"IL signature (): System.Boolean use NewEiffelClassGenerator"
		alias
			"IsEiffelPathValid"
		end

	EmitEiffelClasses (PathName: STRING) is
		external
			"IL signature (System.String): System.Void use NewEiffelClassGenerator"
		alias
			"EmitEiffelClasses"
		end

	EmitXmlFiles (PathName: STRING) is
		external
			"IL signature (System.String): System.Void use NewEiffelClassGenerator"
		alias
			"EmitXmlFiles"
		end

	GeneratedAssemblyFactory (AssemblyType: SYSTEM_TYPE): ISE_REFLECTION_EIFFELASSEMBLYFACTORY is
		external
			"IL signature (System.Type): ISE.Reflection.EiffelAssemblyFactory use NewEiffelClassGenerator"
		alias
			"GeneratedAssemblyFactory"
		end

end -- class NEWEIFFELCLASSGENERATOR
