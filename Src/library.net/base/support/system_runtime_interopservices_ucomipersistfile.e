indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.InteropServices.UCOMIPersistFile"

deferred external class
	SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIPERSISTFILE

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	load (pszFileName: STRING; dwMode: INTEGER) is
		external
			"IL deferred signature (System.String, System.Int32): System.Void use System.Runtime.InteropServices.UCOMIPersistFile"
		alias
			"Load"
		end

	get_class_id (pClassID: SYSTEM_GUID) is
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

	get_cur_file (ppszFileName: STRING) is
		external
			"IL deferred signature (System.String&): System.Void use System.Runtime.InteropServices.UCOMIPersistFile"
		alias
			"GetCurFile"
		end

	save_completed (pszFileName: STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Runtime.InteropServices.UCOMIPersistFile"
		alias
			"SaveCompleted"
		end

	save (pszFileName: STRING; fRemember: BOOLEAN) is
		external
			"IL deferred signature (System.String, System.Boolean): System.Void use System.Runtime.InteropServices.UCOMIPersistFile"
		alias
			"Save"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIPERSISTFILE
