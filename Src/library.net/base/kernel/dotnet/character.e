indexing
	generator: "Eiffel Emitter 2.8b2"
	external_name: "System.Char"
	assembly: "mscorlib", "1.0.2411.0", "neutral", "b77a5c561934e089"

frozen expanded external class
	CHARACTER

inherit
	CHARACTER_REF

create
	default_create,
	make_from_reference

convert
	make_from_reference ({reference CHARACTER}),
	to_reference: {reference CHARACTER}

feature {NONE} -- Initialization

	make_from_reference (v: reference CHARACTER) is
			-- Initialize `Current' with `v.item'.
		require
			v_not_void: V /= Void
		do
			item := v.item
		ensure
			item_set: item = v.item	
		end

feature -- Conversion

	to_reference: reference CHARACTER is
			-- Associated reference of Current
		do
			create Result
			Result.set_item (item)
		ensure
			to_reference_not_void: Result /= Void
		end

end -- class CHARACTER
