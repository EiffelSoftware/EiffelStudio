indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Diagnostics.ICollectData"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_ICOLLECT_DATA

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	collect_data (id: INTEGER; value_name: POINTER; data: POINTER; total_bytes: INTEGER; res: POINTER) is
		external
			"IL deferred signature (System.Int32, System.IntPtr, System.IntPtr, System.Int32, System.IntPtr&): System.Void use System.Diagnostics.ICollectData"
		alias
			"CollectData"
		end

	close_data is
		external
			"IL deferred signature (): System.Void use System.Diagnostics.ICollectData"
		alias
			"CloseData"
		end

end -- class SYSTEM_DLL_ICOLLECT_DATA
