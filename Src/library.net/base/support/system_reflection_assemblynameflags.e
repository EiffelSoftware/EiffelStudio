indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Reflection.AssemblyNameFlags"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_REFLECTION_ASSEMBLYNAMEFLAGS

inherit
	ENUM
	SYSTEM_ICOMPARABLE
	SYSTEM_IFORMATTABLE

feature -- Access

	frozen none: SYSTEM_REFLECTION_ASSEMBLYNAMEFLAGS is
		external
			"IL enum signature :System.Reflection.AssemblyNameFlags use System.Reflection.AssemblyNameFlags"
		alias
			"0"
		end

	frozen public_key: SYSTEM_REFLECTION_ASSEMBLYNAMEFLAGS is
		external
			"IL enum signature :System.Reflection.AssemblyNameFlags use System.Reflection.AssemblyNameFlags"
		alias
			"1"
		end

feature -- Basic Operations

	infix "|" (o: like Current): like Current is
		do
			--Built-in
		end

end -- class SYSTEM_REFLECTION_ASSEMBLYNAMEFLAGS
