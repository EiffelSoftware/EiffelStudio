indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.CoClassAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	CO_CLASS_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_co_class_attribute

feature {NONE} -- Initialization

	frozen make_co_class_attribute (co_class: TYPE) is
		external
			"IL creator signature (System.Type) use System.Runtime.InteropServices.CoClassAttribute"
		end

feature -- Access

	frozen get_co_class: TYPE is
		external
			"IL signature (): System.Type use System.Runtime.InteropServices.CoClassAttribute"
		alias
			"get_CoClass"
		end

end -- class CO_CLASS_ATTRIBUTE
