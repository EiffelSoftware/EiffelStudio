indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.LoaderOptimizationAttribute"

external class
	SYSTEM_LOADEROPTIMIZATIONATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_loaderoptimizationattribute_1,
	make_loaderoptimizationattribute

feature {NONE} -- Initialization

	frozen make_loaderoptimizationattribute_1 (value: SYSTEM_LOADEROPTIMIZATION) is
		external
			"IL creator signature (System.LoaderOptimization) use System.LoaderOptimizationAttribute"
		end

	frozen make_loaderoptimizationattribute (value: INTEGER_8) is
		external
			"IL creator signature (System.Byte) use System.LoaderOptimizationAttribute"
		end

feature -- Access

	get_value: SYSTEM_LOADEROPTIMIZATION is
		external
			"IL signature (): System.LoaderOptimization use System.LoaderOptimizationAttribute"
		alias
			"get_Value"
		end

end -- class SYSTEM_LOADEROPTIMIZATIONATTRIBUTE
