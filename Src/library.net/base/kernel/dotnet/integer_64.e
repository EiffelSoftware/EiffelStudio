indexing
	generator: "Eiffel Emitter 2.8b2"
	external_name: "System.Int64"
	assembly: "mscorlib", "1.0.2411.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	INTEGER_64

inherit
	INTEGER_64_REF

create
	default_create,
	make_from_reference

convert
	make_from_reference ({reference INTEGER_64}),
	to_reference: {reference INTEGER_64},
	to_real: {REAL},
	to_double: {DOUBLE}

feature {NONE} -- Initialization

	make_from_reference (v: reference INTEGER_64) is
			-- Initialize `Current' with `v.item'.
		require
			v_not_void: v /= Void
		do
			item := v.item
		ensure
			item_set: item = v.item	
		end

feature -- Conversion

	to_reference: reference INTEGER_64 is
			-- Associated reference of Current
		do
			create Result
			Result.set_item (item)
		ensure
			to_reference_not_void: Result /= Void
		end

end -- class INTEGER_64
