indexing
	generator: "Eiffel Emitter 2.8b2"
	external_name: "System.Int32"
	assembly: "mscorlib", "1.0.2411.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	INTEGER

inherit
	INTEGER_REF

create
	default_create,
	make_from_reference

convert
	make_from_reference ({reference INTEGER}),
	to_reference: {reference INTEGER},
	to_real: {REAL},
	to_double: {DOUBLE},
	to_integer_64: {INTEGER_64}

feature {NONE} -- Initialization

	make_from_reference (v: reference INTEGER) is
			-- Initialize `Current' with `v.item'.
		require
			v_not_void: v /= Void
		do
			item := v.item
		ensure
			item_set: item = v.item	
		end

feature -- Conversion

	to_reference: reference INTEGER is
			-- Associated reference of Current
		do
			create Result
			Result.set_item (item)
		ensure
			to_reference_not_void: Result /= Void
		end

end -- class INTEGER
