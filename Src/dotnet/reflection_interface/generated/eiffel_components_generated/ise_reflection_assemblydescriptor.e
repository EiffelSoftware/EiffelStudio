indexing
	Generator: "Eiffel Emitter 2.6b2"
	external_name: "ISE.Reflection.AssemblyDescriptor"
external class
	ISE_REFLECTION_ASSEMBLYDESCRIPTOR

inherit
	ANY
		redefine
			get_hash_code
		end

create
	make1

feature {NONE} -- Initialization

	frozen make1 is
		external
			"IL creator use ISE.Reflection.AssemblyDescriptor"
		end

feature -- Access

	frozen version: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.AssemblyDescriptor"
		alias
			"Version"
		end

	frozen name: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.AssemblyDescriptor"
		alias
			"Name"
		end

	frozen culture: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.AssemblyDescriptor"
		alias
			"Culture"
		end

	frozen public_key: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.AssemblyDescriptor"
		alias
			"PublicKey"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use ISE.Reflection.AssemblyDescriptor"
		alias
			"GetHashCode"
		end

	a_invariant is
		external
			"IL signature (): System.Void use ISE.Reflection.AssemblyDescriptor"
		alias
			"_invariant"
		end

	make_from_assembly (a_dot_net_assembly: SYSTEM_REFLECTION_ASSEMBLY) is
		external
			"IL signature (System.Reflection.Assembly): System.Void use ISE.Reflection.AssemblyDescriptor"
		alias
			"MakeFromAssembly"
		end

	make (a_name: STRING; a_version: STRING; a_culture: STRING; a_public_key: STRING) is
		external
			"IL signature (System.String, System.String, System.String, System.String): System.Void use ISE.Reflection.AssemblyDescriptor"
		alias
			"Make"
		end

end -- class ISE_REFLECTION_ASSEMBLYDESCRIPTOR
