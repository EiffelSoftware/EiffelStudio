indexing
	generator: "Eiffel Emitter 2.8b2"
	external_name: "System.Single"
	assembly: "mscorlib", "1.0.2411.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	REAL

inherit
	REAL_REF

create
	default_create,
	make_from_reference

convert
	make_from_reference ({reference REAL}),
	to_reference: {reference REAL},
	to_double: {DOUBLE}

feature {NONE} -- Initialization

	make_from_reference (v: reference REAL) is
			-- Initialize `Current' with `v.item'.
		require
			v_not_void: v /= Void
		do
			item := v.item
		ensure
			item_set: item = v.item	
		end

feature -- Conversion

	to_reference: reference REAL is
			-- Associated reference of Current
		do
			create Result
			Result.set_item (item)
		ensure
			to_reference_not_void: Result /= Void
		end

feature -- Access

	frozen min_value: REAL is -3.402823E+38

	frozen epsilon: REAL is 1.401298E-45

	frozen max_value: REAL is 3.402823E+38

end -- class REAL
