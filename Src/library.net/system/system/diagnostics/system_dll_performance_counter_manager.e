indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Diagnostics.PerformanceCounterManager"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_PERFORMANCE_COUNTER_MANAGER

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	SYSTEM_DLL_ICOLLECT_DATA
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

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Diagnostics.PerformanceCounterManager"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
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

end -- class SYSTEM_DLL_PERFORMANCE_COUNTER_MANAGER
