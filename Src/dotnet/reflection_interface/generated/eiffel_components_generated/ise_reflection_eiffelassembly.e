indexing
	Generator: "Eiffel Emitter beta 2"
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

	frozen assemblyculture: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelAssembly"
		alias
			"AssemblyCulture"
		end

	frozen types: SYSTEM_COLLECTIONS_ARRAYLIST is
		external
			"IL field signature :System.Collections.ArrayList use ISE.Reflection.EiffelAssembly"
		alias
			"Types"
		end

	frozen emitterversionnumber: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelAssembly"
		alias
			"EmitterVersionNumber"
		end

	frozen assemblyname: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelAssembly"
		alias
			"AssemblyName"
		end

	frozen assemblyversion: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelAssembly"
		alias
			"AssemblyVersion"
		end

	frozen eiffelclusterpath: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelAssembly"
		alias
			"EiffelClusterPath"
		end

	frozen assemblypublickey: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.EiffelAssembly"
		alias
			"AssemblyPublicKey"
		end

feature -- Basic Operations

	setassemblyversion (a_version: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelAssembly"
		alias
			"SetAssemblyVersion"
		end

	addtype (a_type: ISE_REFLECTION_EIFFELCLASS) is
		external
			"IL signature (ISE.Reflection.EiffelClass): System.Void use ISE.Reflection.EiffelAssembly"
		alias
			"AddType"
		end

	make is
		external
			"IL signature (): System.Void use ISE.Reflection.EiffelAssembly"
		alias
			"Make"
		end

	seteiffelclusterpath (a_path: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelAssembly"
		alias
			"SetEiffelClusterPath"
		end

	setassemblyculture (a_culture: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelAssembly"
		alias
			"SetAssemblyCulture"
		end

	setemitterversionnumber (a_value: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelAssembly"
		alias
			"SetEmitterVersionNumber"
		end

	setassemblyname (a_name: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelAssembly"
		alias
			"SetAssemblyName"
		end

	a_invariant is
		external
			"IL signature (): System.Void use ISE.Reflection.EiffelAssembly"
		alias
			"_invariant"
		end

	setassemblypublickey (a_public_key: STRING) is
		external
			"IL signature (System.String): System.Void use ISE.Reflection.EiffelAssembly"
		alias
			"SetAssemblyPublicKey"
		end

end -- class ISE_REFLECTION_EIFFELASSEMBLY
