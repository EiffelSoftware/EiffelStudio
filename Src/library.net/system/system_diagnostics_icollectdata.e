indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Diagnostics.ICollectData"

deferred external class
	SYSTEM_DIAGNOSTICS_ICOLLECTDATA

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
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

end -- class SYSTEM_DIAGNOSTICS_ICOLLECTDATA
