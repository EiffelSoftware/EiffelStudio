indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Diagnostics.PerformanceCounterManager"

external class
	SYSTEM_DIAGNOSTICS_PERFORMANCECOUNTERMANAGER

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_DIAGNOSTICS_ICOLLECTDATA
		rename
			close_data as system_diagnostics_icollect_data_close_data,
			collect_data as system_diagnostics_icollect_data_collect_data
		end

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Diagnostics.PerformanceCounterManager"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Diagnostics.PerformanceCounterManager"
		alias
			"GetHashCode"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Diagnostics.PerformanceCounterManager"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Diagnostics.PerformanceCounterManager"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	frozen system_diagnostics_icollect_data_collect_data (call_idx: INTEGER; value_name_ptr: POINTER; data_ptr: POINTER; total_bytes: INTEGER; res: POINTER) is
		external
			"IL signature (System.Int32, System.IntPtr, System.IntPtr, System.Int32, System.IntPtr&): System.Void use System.Diagnostics.PerformanceCounterManager"
		alias
			"System.Diagnostics.ICollectData.CollectData"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Diagnostics.PerformanceCounterManager"
		alias
			"Finalize"
		end

	frozen system_diagnostics_icollect_data_close_data is
		external
			"IL signature (): System.Void use System.Diagnostics.PerformanceCounterManager"
		alias
			"System.Diagnostics.ICollectData.CloseData"
		end

end -- class SYSTEM_DIAGNOSTICS_PERFORMANCECOUNTERMANAGER
