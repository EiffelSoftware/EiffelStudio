indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Reflection.Emit.Label"

frozen expanded external class
	SYSTEM_REFLECTION_EMIT_LABEL

inherit
	VALUE_TYPE
		redefine
			get_hash_code,
			is_equal
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Reflection.Emit.Label"
		alias
			"GetHashCode"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Reflection.Emit.Label"
		alias
			"Equals"
		end

end -- class SYSTEM_REFLECTION_EMIT_LABEL
