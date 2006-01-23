indexing
	generator: "Eiffel Emitter 2.8b2"
	external_name: "System.Boolean"
	assembly: "mscorlib", "1.0.2411.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	BOOLEAN

inherit
	BOOLEAN_REF
	
create
	default_create,
	make_from_reference

convert
	make_from_reference ({BOOLEAN_REF}),
	to_reference: {BOOLEAN_REF, HASHABLE, ANY}

indexing
	library:	"EiffelBase: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"



end -- class BOOLEAN
