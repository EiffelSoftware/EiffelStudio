indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Double"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	DOUBLE

inherit
	DOUBLE_REF

create
	default_create,
	make_from_reference

convert
	make_from_reference ({reference DOUBLE}),
	to_reference: {reference DOUBLE},
	truncated_to_real: {REAL}

feature {NONE} -- Initialization

	make_from_reference (v: reference DOUBLE) is
			-- Initialize `Current' with `v.item'.
		require
			v_not_void: v /= Void
		do
			item := v.item
		ensure
			item_set: item = v.item	
		end

feature -- Conversion

	to_reference: reference DOUBLE is
			-- Associated reference of Current
		do
			create Result
			Result.set_item (item)
		ensure
			to_reference_not_void: Result /= Void
		end

feature -- Access

	frozen min_value: DOUBLE is -1.79769313486232E+308

	frozen max_value: DOUBLE is 1.79769313486232E+308

	frozen epsilon: DOUBLE is 4.94065645841247E-324

end -- class DOUBLE
