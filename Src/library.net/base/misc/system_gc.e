indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.GC"

frozen external class
	SYSTEM_GC

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

	frozen re_register_for_finalize (obj: ANY) is
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

	frozen keep_alive (obj: ANY) is
		external
			"IL static signature (System.Object): System.Void use System.GC"
		alias
			"KeepAlive"
		end

	frozen get_generation_object (obj: ANY): INTEGER is
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

	frozen suppress_finalize (obj: ANY) is
		external
			"IL static signature (System.Object): System.Void use System.GC"
		alias
			"SuppressFinalize"
		end

	frozen get_generation (wo: SYSTEM_WEAKREFERENCE): INTEGER is
		external
			"IL static signature (System.WeakReference): System.Int32 use System.GC"
		alias
			"GetGeneration"
		end

end -- class SYSTEM_GC
