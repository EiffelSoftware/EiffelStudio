indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ICloneable"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ICLONEABLE

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	clone_: SYSTEM_OBJECT is
		external
			"IL deferred signature (): System.Object use System.ICloneable"
		alias
			"Clone"
		end

end -- class ICLONEABLE
