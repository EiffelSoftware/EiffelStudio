indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.ICustomMarshaler"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	ICUSTOM_MARSHALER

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	marshal_managed_to_native (managed_obj: SYSTEM_OBJECT): POINTER is
		external
			"IL deferred signature (System.Object): System.IntPtr use System.Runtime.InteropServices.ICustomMarshaler"
		alias
			"MarshalManagedToNative"
		end

	marshal_native_to_managed (p_native_data: POINTER): SYSTEM_OBJECT is
		external
			"IL deferred signature (System.IntPtr): System.Object use System.Runtime.InteropServices.ICustomMarshaler"
		alias
			"MarshalNativeToManaged"
		end

	get_native_data_size: INTEGER is
		external
			"IL deferred signature (): System.Int32 use System.Runtime.InteropServices.ICustomMarshaler"
		alias
			"GetNativeDataSize"
		end

	clean_up_managed_data (managed_obj: SYSTEM_OBJECT) is
		external
			"IL deferred signature (System.Object): System.Void use System.Runtime.InteropServices.ICustomMarshaler"
		alias
			"CleanUpManagedData"
		end

	clean_up_native_data (p_native_data: POINTER) is
		external
			"IL deferred signature (System.IntPtr): System.Void use System.Runtime.InteropServices.ICustomMarshaler"
		alias
			"CleanUpNativeData"
		end

end -- class ICUSTOM_MARSHALER
