indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.UCOMIPersistFile"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	UCOMIPERSIST_FILE

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	save_completed (psz_file_name: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Runtime.InteropServices.UCOMIPersistFile"
		alias
			"SaveCompleted"
		end

	get_class_id (p_class_id: GUID) is
		external
			"IL deferred signature (System.Guid&): System.Void use System.Runtime.InteropServices.UCOMIPersistFile"
		alias
			"GetClassID"
		end

	is_dirty: INTEGER is
		external
			"IL deferred signature (): System.Int32 use System.Runtime.InteropServices.UCOMIPersistFile"
		alias
			"IsDirty"
		end

	load (psz_file_name: SYSTEM_STRING; dw_mode: INTEGER) is
		external
			"IL deferred signature (System.String, System.Int32): System.Void use System.Runtime.InteropServices.UCOMIPersistFile"
		alias
			"Load"
		end

	get_cur_file (ppsz_file_name: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String&): System.Void use System.Runtime.InteropServices.UCOMIPersistFile"
		alias
			"GetCurFile"
		end

	save (psz_file_name: SYSTEM_STRING; f_remember: BOOLEAN) is
		external
			"IL deferred signature (System.String, System.Boolean): System.Void use System.Runtime.InteropServices.UCOMIPersistFile"
		alias
			"Save"
		end

end -- class UCOMIPERSIST_FILE
