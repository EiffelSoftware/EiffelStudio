indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ParamArrayAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	PARAM_ARRAY_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_param_array_attribute

feature {NONE} -- Initialization

	frozen make_param_array_attribute is
		external
			"IL creator use System.ParamArrayAttribute"
		end

end -- class PARAM_ARRAY_ATTRIBUTE
