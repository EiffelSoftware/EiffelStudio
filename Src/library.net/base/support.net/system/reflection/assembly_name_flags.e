indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.AssemblyNameFlags"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	ASSEMBLY_NAME_FLAGS

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen none: ASSEMBLY_NAME_FLAGS is
		external
			"IL enum signature :System.Reflection.AssemblyNameFlags use System.Reflection.AssemblyNameFlags"
		alias
			"0"
		end

	frozen public_key: ASSEMBLY_NAME_FLAGS is
		external
			"IL enum signature :System.Reflection.AssemblyNameFlags use System.Reflection.AssemblyNameFlags"
		alias
			"1"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class ASSEMBLY_NAME_FLAGS
