indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.LoaderOptimizationAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	LOADER_OPTIMIZATION_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_loader_optimization_attribute,
	make_loader_optimization_attribute_1

feature {NONE} -- Initialization

	frozen make_loader_optimization_attribute (value: INTEGER_8) is
		external
			"IL creator signature (System.Byte) use System.LoaderOptimizationAttribute"
		end

	frozen make_loader_optimization_attribute_1 (value: LOADER_OPTIMIZATION) is
		external
			"IL creator signature (System.LoaderOptimization) use System.LoaderOptimizationAttribute"
		end

feature -- Access

	frozen get_value: LOADER_OPTIMIZATION is
		external
			"IL signature (): System.LoaderOptimization use System.LoaderOptimizationAttribute"
		alias
			"get_Value"
		end

end -- class LOADER_OPTIMIZATION_ATTRIBUTE
