indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Reflection.ResourceLocation"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	RESOURCE_LOCATION

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen contained_in_manifest_file: RESOURCE_LOCATION is
		external
			"IL enum signature :System.Reflection.ResourceLocation use System.Reflection.ResourceLocation"
		alias
			"4"
		end

	frozen embedded: RESOURCE_LOCATION is
		external
			"IL enum signature :System.Reflection.ResourceLocation use System.Reflection.ResourceLocation"
		alias
			"1"
		end

	frozen contained_in_another_assembly: RESOURCE_LOCATION is
		external
			"IL enum signature :System.Reflection.ResourceLocation use System.Reflection.ResourceLocation"
		alias
			"2"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class RESOURCE_LOCATION
