indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.LoaderOptimizationAttribute"

external class
	SYSTEM_LOADEROPTIMIZATIONATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE

create
	make_loaderoptimizationattribute_1,
	make_loaderoptimizationattribute

feature {NONE} -- Initialization

	frozen make_loaderoptimizationattribute_1 (value: INTEGER) is
			-- Valid values for `value' are:
			-- NotSpecified = 0
			-- SingleDomain = 1
			-- MultiDomain = 2
			-- MultiDomainHost = 3
		require
			valid_loader_optimization: value = 0 or value = 1 or value = 2 or value = 3
		external
			"IL creator signature (enum System.LoaderOptimization) use System.LoaderOptimizationAttribute"
		end

	frozen make_loaderoptimizationattribute (value: INTEGER_8) is
		external
			"IL creator signature (System.Byte) use System.LoaderOptimizationAttribute"
		end

feature -- Access

	get_value: INTEGER is
		external
			"IL signature (): enum System.LoaderOptimization use System.LoaderOptimizationAttribute"
		alias
			"get_Value"
		ensure
			valid_loader_optimization: Result = 0 or Result = 1 or Result = 2 or Result = 3
		end

end -- class SYSTEM_LOADEROPTIMIZATIONATTRIBUTE
