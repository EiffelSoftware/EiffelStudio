indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.InteropServices.FieldOffsetAttribute"

frozen external class
	SYSTEM_RUNTIME_INTEROPSERVICES_FIELDOFFSETATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

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

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_FIELDOFFSETATTRIBUTE
