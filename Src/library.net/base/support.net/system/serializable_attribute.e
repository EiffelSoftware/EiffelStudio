indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.SerializableAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	SERIALIZABLE_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_serializable_attribute

feature {NONE} -- Initialization

	frozen make_serializable_attribute is
		external
			"IL creator use System.SerializableAttribute"
		end

end -- class SERIALIZABLE_ATTRIBUTE
