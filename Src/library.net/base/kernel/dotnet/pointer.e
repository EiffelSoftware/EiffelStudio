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
	make_from_reference ({reference POINTER}),
	to_reference: {reference POINTER}

feature {NONE} -- Initialization

	make_from_reference (v: reference POINTER) is
			-- Initialize `Current' with `v.item'.
		require
			v_not_void: v /= Void
		do
			item := v.item
		ensure
			item_set: item = v.item	
		end

feature -- Conversion

	to_reference: reference POINTER is
			-- Associated reference of Current
		do
			create Result
			Result.set_item (item)
		ensure
			to_reference_not_void: Result /= Void
		end

end -- class POINTER
