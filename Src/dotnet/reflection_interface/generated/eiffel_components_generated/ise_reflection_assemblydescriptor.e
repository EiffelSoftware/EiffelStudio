indexing
	Generator: "Eiffel Emitter 2.4b2"
	external_name: "ISE.Reflection.AssemblyDescriptor"

external class
	ISE_REFLECTION_ASSEMBLYDESCRIPTOR

create
	make1

feature {NONE} -- Initialization

	frozen make1 is
		external
			"IL creator use ISE.Reflection.AssemblyDescriptor"
		end

feature -- Access

	frozen Culture: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.AssemblyDescriptor"
		alias
			"Culture"
		end

	frozen Version: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.AssemblyDescriptor"
		alias
			"Version"
		end

	frozen PublicKey: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.AssemblyDescriptor"
		alias
			"PublicKey"
		end

	frozen Name: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.AssemblyDescriptor"
		alias
			"Name"
		end

feature -- Basic Operations

	Make (a_name: STRING; a_version: STRING; a_culture: STRING; a_public_key: STRING) is
		external
			"IL signature (System.String, System.String, System.String, System.String): System.Void use ISE.Reflection.AssemblyDescriptor"
		alias
			"Make"
		end

	a_invariant is
		external
			"IL signature (): System.Void use ISE.Reflection.AssemblyDescriptor"
		alias
			"_invariant"
		end

	MakeFromAssembly (a_dot_net_assembly: SYSTEM_REFLECTION_ASSEMBLY) is
		external
			"IL signature (System.Reflection.Assembly): System.Void use ISE.Reflection.AssemblyDescriptor"
		alias
			"MakeFromAssembly"
		end

end -- class ISE_REFLECTION_ASSEMBLYDESCRIPTOR
