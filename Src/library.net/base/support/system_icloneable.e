indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.ICloneable"

deferred external class
	SYSTEM_ICLONEABLE

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	clone: ANY is
		external
			"IL deferred signature (): System.Object use System.ICloneable"
		alias
			"Clone"
		end

end -- class SYSTEM_ICLONEABLE
