indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.CompilerServices.DiscardableAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	DISCARDABLE_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_discardable_attribute

feature {NONE} -- Initialization

	frozen make_discardable_attribute is
		external
			"IL creator use System.Runtime.CompilerServices.DiscardableAttribute"
		end

end -- class DISCARDABLE_ATTRIBUTE
