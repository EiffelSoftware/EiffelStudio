indexing
	Generator: "Eiffel Emitter 2.3b"
	external_name: "ISE.Reflection.EiffelAssembly"

external class
	ISE_REFLECTION_EIFFELASSEMBLY

create
	make1

feature {NONE} -- Initialization

	frozen make1 is
		external
			"IL creator use ISE.Reflection.EiffelAssembly"
		end

feature -- Access

	frozen EmitterVersionNumber: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelAssembly"
		alias
			"EmitterVersionNumber"
		end

	frozen AssemblyName: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelAssembly"
		alias
			"AssemblyName"
		end

	frozen AssemblyCulture: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelAssembly"
		alias
			"AssemblyCulture"
		end

	frozen AssemblyVersion: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelAssembly"
		alias
			"AssemblyVersion"
		end

	frozen Types: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL field signature :System.Collections.ArrayList use ISE.Reflection.EiffelAssembly"
		alias
			"Types"
		end

	frozen AssemblyPublicKey: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelAssembly"
		alias
			"AssemblyPublicKey"
		end

	frozen EiffelClusterPath: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelAssembly"
		alias
			"EiffelClusterPath"
		end

feature -- Basic Operations

	Make is
		external
			"IL signature (): System.Void use ISE.Reflection.EiffelAssembly"
		alias
			"Make"
		end

	a_invariant is
		external
			"IL signature (): System.Void use ISE.Reflection.EiffelAssembly"
		alias
			"_invariant"
		end

	SetAssemblyPublicKey (a_public_key: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelAssembly"
		alias
			"SetAssemblyPublicKey"
		end

	SetAssemblyName (a_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelAssembly"
		alias
			"SetAssemblyName"
		end

	SetEmitterVersionNumber (a_value: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelAssembly"
		alias
			"SetEmitterVersionNumber"
		end

	AddType (a_type: ISE_REFLECTION_EIFFELCLASS) is
		external
			"IL signature (ISE.Reflection.EiffelClass): System.Void use ISE.Reflection.EiffelAssembly"
		alias
			"AddType"
		end

	SetAssemblyVersion (a_version: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelAssembly"
		alias
			"SetAssemblyVersion"
		end

	SetAssemblyCulture (a_culture: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelAssembly"
		alias
			"SetAssemblyCulture"
		end

	SetEiffelClusterPath (a_path: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelAssembly"
		alias
			"SetEiffelClusterPath"
		end

end -- class ISE_REFLECTION_EIFFELASSEMBLY
