indexing
	Generator: "Eiffel Emitter 2.3b"
	external_name: "ISE.Reflection.EiffelAssemblyFactory"

external class
	ISE_REFLECTION_EIFFELASSEMBLYFACTORY

create
	make1

feature {NONE} -- Initialization

	frozen make1 is
		external
			"IL creator use ISE.Reflection.EiffelAssemblyFactory"
		end

feature -- Access

	frozen AssemblyName: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelAssemblyFactory"
		alias
			"AssemblyName"
		end

	frozen AssemblyCulture: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelAssemblyFactory"
		alias
			"AssemblyCulture"
		end

	frozen AssemblyVersion: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelAssemblyFactory"
		alias
			"AssemblyVersion"
		end

	frozen EiffelClusterPath: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelAssemblyFactory"
		alias
			"EiffelClusterPath"
		end

	frozen AssemblyPublicKey: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelAssemblyFactory"
		alias
			"AssemblyPublicKey"
		end

	frozen EmitterVersionNumber: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelAssemblyFactory"
		alias
			"EmitterVersionNumber"
		end

	frozen Types: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL field signature :System.Collections.ArrayList use ISE.Reflection.EiffelAssemblyFactory"
		alias
			"Types"
		end

feature -- Basic Operations

	Make is
		external
			"IL signature (): System.Void use ISE.Reflection.EiffelAssemblyFactory"
		alias
			"Make"
		end

	SetAssemblyCulture (a_culture: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelAssemblyFactory"
		alias
			"SetAssemblyCulture"
		end

	SetAssemblyPublicKey (a_public_key: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelAssemblyFactory"
		alias
			"SetAssemblyPublicKey"
		end

	SetAssemblyName (a_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelAssemblyFactory"
		alias
			"SetAssemblyName"
		end

	SetEmitterVersionNumber (a_value: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelAssemblyFactory"
		alias
			"SetEmitterVersionNumber"
		end

	AddType (a_type: ISE_REFLECTION_EIFFELCLASS) is
		external
			"IL signature (ISE.Reflection.EiffelClass): System.Void use ISE.Reflection.EiffelAssemblyFactory"
		alias
			"AddType"
		end

	SetAssemblyVersion (a_version: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelAssemblyFactory"
		alias
			"SetAssemblyVersion"
		end

	a_invariant is
		external
			"IL signature (): System.Void use ISE.Reflection.EiffelAssemblyFactory"
		alias
			"_invariant"
		end

	SetEiffelClusterPath (a_path: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelAssemblyFactory"
		alias
			"SetEiffelClusterPath"
		end

end -- class ISE_REFLECTION_EIFFELASSEMBLYFACTORY
