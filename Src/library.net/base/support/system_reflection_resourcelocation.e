indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Reflection.ResourceLocation"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_REFLECTION_RESOURCELOCATION

inherit
	ENUM
	SYSTEM_ICOMPARABLE
	SYSTEM_IFORMATTABLE

feature -- Access

	frozen contained_in_manifest_file: SYSTEM_REFLECTION_RESOURCELOCATION is
		external
			"IL enum signature :System.Reflection.ResourceLocation use System.Reflection.ResourceLocation"
		alias
			"4"
		end

	frozen embedded: SYSTEM_REFLECTION_RESOURCELOCATION is
		external
			"IL enum signature :System.Reflection.ResourceLocation use System.Reflection.ResourceLocation"
		alias
			"1"
		end

	frozen contained_in_another_assembly: SYSTEM_REFLECTION_RESOURCELOCATION is
		external
			"IL enum signature :System.Reflection.ResourceLocation use System.Reflection.ResourceLocation"
		alias
			"2"
		end

feature -- Basic Operations

	infix "|" (o: like Current): like Current is
		do
			--Built-in
		end

end -- class SYSTEM_REFLECTION_RESOURCELOCATION
