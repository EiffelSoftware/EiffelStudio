indexing
	Generator: "Eiffel Emitter beta 2"
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

	frozen version: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.AssemblyDescriptor"
		alias
			"Version"
		end

	frozen publickey: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.AssemblyDescriptor"
		alias
			"PublicKey"
		end

	frozen culture: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.AssemblyDescriptor"
		alias
			"Culture"
		end

	frozen name: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.AssemblyDescriptor"
		alias
			"Name"
		end

feature -- Basic Operations

	a_invariant is
		external
			"IL signature (): System.Void use ISE.Reflection.AssemblyDescriptor"
		alias
			"_invariant"
		end

	make (a_name: STRING; a_version: STRING; a_culture: STRING; a_public_key: STRING) is
		external
			"IL signature (System.String, System.String, System.String, System.String): System.Void use ISE.Reflection.AssemblyDescriptor"
		alias
			"Make"
		end

end -- class ISE_REFLECTION_ASSEMBLYDESCRIPTOR
