indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.AssemblyRegistrationFlags"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	ASSEMBLY_REGISTRATION_FLAGS

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen set_code_base: ASSEMBLY_REGISTRATION_FLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.AssemblyRegistrationFlags use System.Runtime.InteropServices.AssemblyRegistrationFlags"
		alias
			"1"
		end

	frozen none: ASSEMBLY_REGISTRATION_FLAGS is
		external
			"IL enum signature :System.Runtime.InteropServices.AssemblyRegistrationFlags use System.Runtime.InteropServices.AssemblyRegistrationFlags"
		alias
			"0"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class ASSEMBLY_REGISTRATION_FLAGS
