indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.InteropServices.ICustomMarshaler"

deferred external class
	SYSTEM_RUNTIME_INTEROPSERVICES_ICUSTOMMARSHALER

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	marshal_native_to_managed (pNativeData: POINTER): ANY is
		external
			"IL deferred signature (System.IntPtr): System.Object use System.Runtime.InteropServices.ICustomMarshaler"
		alias
			"MarshalNativeToManaged"
		end

	marshal_managed_to_native (ManagedObj: ANY): POINTER is
		external
			"IL deferred signature (System.Object): System.IntPtr use System.Runtime.InteropServices.ICustomMarshaler"
		alias
			"MarshalManagedToNative"
		end

	clean_up_native_data (pNativeData: POINTER) is
		external
			"IL deferred signature (System.IntPtr): System.Void use System.Runtime.InteropServices.ICustomMarshaler"
		alias
			"CleanUpNativeData"
		end

	get_native_data_size: INTEGER is
		external
			"IL deferred signature (): System.Int32 use System.Runtime.InteropServices.ICustomMarshaler"
		alias
			"GetNativeDataSize"
		end

	clean_up_managed_data (ManagedObj: ANY) is
		external
			"IL deferred signature (System.Object): System.Void use System.Runtime.InteropServices.ICustomMarshaler"
		alias
			"CleanUpManagedData"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_ICUSTOMMARSHALER
