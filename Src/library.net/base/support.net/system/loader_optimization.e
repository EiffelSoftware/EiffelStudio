indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.LoaderOptimization"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	LOADER_OPTIMIZATION

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen multi_domain_host: LOADER_OPTIMIZATION is
		external
			"IL enum signature :System.LoaderOptimization use System.LoaderOptimization"
		alias
			"3"
		end

	frozen multi_domain: LOADER_OPTIMIZATION is
		external
			"IL enum signature :System.LoaderOptimization use System.LoaderOptimization"
		alias
			"2"
		end

	frozen not_specified: LOADER_OPTIMIZATION is
		external
			"IL enum signature :System.LoaderOptimization use System.LoaderOptimization"
		alias
			"0"
		end

	frozen single_domain: LOADER_OPTIMIZATION is
		external
			"IL enum signature :System.LoaderOptimization use System.LoaderOptimization"
		alias
			"1"
		end

end -- class LOADER_OPTIMIZATION
