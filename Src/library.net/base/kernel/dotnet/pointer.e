indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.IntPtr"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	POINTER

inherit
	POINTER_REF

create
	default_create,
	make_from_reference

convert
	make_from_reference ({POINTER_REF}),
	to_reference: {POINTER_REF, HASHABLE, ANY}

end -- class POINTER
