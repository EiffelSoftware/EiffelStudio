indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.NonSerializedAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	NON_SERIALIZED_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_non_serialized_attribute

feature {NONE} -- Initialization

	frozen make_non_serialized_attribute is
		external
			"IL creator use System.NonSerializedAttribute"
		end

end -- class NON_SERIALIZED_ATTRIBUTE
