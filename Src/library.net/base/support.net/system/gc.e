indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.GC"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	GC

inherit
	SYSTEM_OBJECT

create {NONE}

feature -- Access

	frozen get_max_generation: INTEGER is
		external
			"IL static signature (): System.Int32 use System.GC"
		alias
			"get_MaxGeneration"
		end

feature -- Basic Operations

	frozen get_total_memory (force_full_collection: BOOLEAN): INTEGER_64 is
		external
			"IL static signature (System.Boolean): System.Int64 use System.GC"
		alias
			"GetTotalMemory"
		end

	frozen re_register_for_finalize (obj: SYSTEM_OBJECT) is
		external
			"IL static signature (System.Object): System.Void use System.GC"
		alias
			"ReRegisterForFinalize"
		end

	frozen wait_for_pending_finalizers is
		external
			"IL static signature (): System.Void use System.GC"
		alias
			"WaitForPendingFinalizers"
		end

	frozen keep_alive (obj: SYSTEM_OBJECT) is
		external
			"IL static signature (System.Object): System.Void use System.GC"
		alias
			"KeepAlive"
		end

	frozen get_generation_object (obj: SYSTEM_OBJECT): INTEGER is
		external
			"IL static signature (System.Object): System.Int32 use System.GC"
		alias
			"GetGeneration"
		end

	frozen collect is
		external
			"IL static signature (): System.Void use System.GC"
		alias
			"Collect"
		end

	frozen collect_int32 (generation: INTEGER) is
		external
			"IL static signature (System.Int32): System.Void use System.GC"
		alias
			"Collect"
		end

	frozen suppress_finalize (obj: SYSTEM_OBJECT) is
		external
			"IL static signature (System.Object): System.Void use System.GC"
		alias
			"SuppressFinalize"
		end

	frozen get_generation (wo: WEAK_REFERENCE): INTEGER is
		external
			"IL static signature (System.WeakReference): System.Int32 use System.GC"
		alias
			"GetGeneration"
		end

end -- class GC
