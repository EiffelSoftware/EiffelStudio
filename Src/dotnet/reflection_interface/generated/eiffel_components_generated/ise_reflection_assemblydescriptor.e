indexing
	generator: "Eiffel Emitter 2.8b2"
	external_name: "ISE.Reflection.AssemblyDescriptor"
	assembly: "ISE.Reflection.EiffelComponents", "0.0.0.0", "neutral", "e0f9d13739fa815f"

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

	get_culture: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.AssemblyDescriptor"
		alias
			"get_Culture"
		end

	get_name: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.AssemblyDescriptor"
		alias
			"get_Name"
		end

	frozen a_internal_name: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.AssemblyDescriptor"
		alias
			"_internal_Name"
		end

	get_public_key: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.AssemblyDescriptor"
		alias
			"get_PublicKey"
		end

	frozen a_internal_culture: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.AssemblyDescriptor"
		alias
			"_internal_Culture"
		end

	frozen a_internal_public_key: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.AssemblyDescriptor"
		alias
			"_internal_PublicKey"
		end

	frozen a_internal_version: STRING is
		external
			"IL field signature :System.String use ISE.Reflection.AssemblyDescriptor"
		alias
			"_internal_Version"
		end

	get_version: STRING is
		external
			"IL signature (): System.String use ISE.Reflection.AssemblyDescriptor"
		alias
			"get_Version"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use ISE.Reflection.AssemblyDescriptor"
		alias
			"GetHashCode"
		end

	frozen a_invariant (current_object: ISE_REFLECTION_ASSEMBLYDESCRIPTOR) is
		external
			"IL static signature (ISE.Reflection.AssemblyDescriptor): System.Void use ISE.Reflection.AssemblyDescriptor"
		alias
			"_invariant"
		end

	make (a_name: STRING; a_version: STRING; a_culture: STRING; a_public_key: STRING) is
		external
			"IL signature (System.String, System.String, System.String, System.String): System.Void use ISE.Reflection.AssemblyDescriptor"
		alias
			"Make"
		end

	make_from_assembly (a_dot_net_assembly: SYSTEM_REFLECTION_ASSEMBLY) is
		external
			"IL signature (System.Reflection.Assembly): System.Void use ISE.Reflection.AssemblyDescriptor"
		alias
			"MakeFromAssembly"
		end

end -- class ISE_REFLECTION_ASSEMBLYDESCRIPTOR
