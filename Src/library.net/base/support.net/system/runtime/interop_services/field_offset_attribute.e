indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.FieldOffsetAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	FIELD_OFFSET_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_field_offset_attribute

feature {NONE} -- Initialization

	frozen make_field_offset_attribute (offset: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Runtime.InteropServices.FieldOffsetAttribute"
		end

feature -- Access

	frozen get_value: INTEGER is
		external
			"IL signature (): System.Int32 use System.Runtime.InteropServices.FieldOffsetAttribute"
		alias
			"get_Value"
		end

end -- class FIELD_OFFSET_ATTRIBUTE
