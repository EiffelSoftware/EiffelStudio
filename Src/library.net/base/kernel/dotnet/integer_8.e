indexing
	generator: "Eiffel Emitter 2.8b2"
	external_name: "System.Byte"
	assembly: "mscorlib", "1.0.2411.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	INTEGER_8

inherit
	INTEGER_8_REF

create
	default_create,
	make_from_reference

convert
	make_from_reference ({reference INTEGER_8}),
	to_reference: {reference INTEGER_8},
	to_real: {REAL},
	to_double: {DOUBLE},
	to_integer_16: {INTEGER_16},
	to_integer_32: {INTEGER},
	to_integer_64: {INTEGER_64}

feature {NONE} -- Initialization

	make_from_reference (v: reference INTEGER_8) is
			-- Initialize `Current' with `v.item'.
		require
			v_not_void: V /= Void
		do
			item := v.item
		ensure
			item_set: item = v.item	
		end

feature -- Conversion

	to_reference: reference INTEGER_8 is
			-- Associated reference of Current
		do
			create Result
			Result.set_item (item)
		ensure
			to_reference_not_void: Result /= Void
		end

end -- class INTEGER_8
