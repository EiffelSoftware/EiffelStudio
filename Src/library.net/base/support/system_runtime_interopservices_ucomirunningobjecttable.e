indexing
	Generator: "Eiffel Emitter 2.5b2"
	external_name: "System.Runtime.InteropServices.UCOMIRunningObjectTable"

deferred external class
	SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIRUNNINGOBJECTTABLE

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	enum_running (ppenumMoniker: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIENUMMONIKER) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIEnumMoniker&): System.Void use System.Runtime.InteropServices.UCOMIRunningObjectTable"
		alias
			"EnumRunning"
		end

	revoke (dwRegister: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use System.Runtime.InteropServices.UCOMIRunningObjectTable"
		alias
			"Revoke"
		end

	note_change_time (dwRegister: INTEGER; pfiletime: SYSTEM_RUNTIME_INTEROPSERVICES_FILETIME) is
		external
			"IL deferred signature (System.Int32, System.Runtime.InteropServices.FILETIME&): System.Void use System.Runtime.InteropServices.UCOMIRunningObjectTable"
		alias
			"NoteChangeTime"
		end

	get_time_of_last_change (pmkObjectName: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIMONIKER; pfiletime: SYSTEM_RUNTIME_INTEROPSERVICES_FILETIME) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIMoniker, System.Runtime.InteropServices.FILETIME&): System.Void use System.Runtime.InteropServices.UCOMIRunningObjectTable"
		alias
			"GetTimeOfLastChange"
		end

	get_object (pmkObjectName: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIMONIKER; ppunkObject: ANY) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIMoniker, System.Object&): System.Void use System.Runtime.InteropServices.UCOMIRunningObjectTable"
		alias
			"GetObject"
		end

	is_running (pmkObjectName: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIMONIKER) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIMoniker): System.Void use System.Runtime.InteropServices.UCOMIRunningObjectTable"
		alias
			"IsRunning"
		end

	register (grfFlags: INTEGER; punkObject: ANY; pmkObjectName: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIMONIKER; pdwRegister: INTEGER) is
		external
			"IL deferred signature (System.Int32, System.Object, System.Runtime.InteropServices.UCOMIMoniker, System.Int32&): System.Void use System.Runtime.InteropServices.UCOMIRunningObjectTable"
		alias
			"Register"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIRUNNINGOBJECTTABLE
