indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Threading.CompressedStack"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	COMPRESSED_STACK

inherit
	SYSTEM_OBJECT
		redefine
			finalize
		end

create {NONE}

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Threading.CompressedStack"
		alias
			"Finalize"
		end

end -- class COMPRESSED_STACK
