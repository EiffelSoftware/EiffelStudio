indexing
	Generator: "Eiffel Emitter 2.7b2"
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

	note_change_time (dw_register: INTEGER; pfiletime: SYSTEM_RUNTIME_INTEROPSERVICES_FILETIME) is
		external
			"IL deferred signature (System.Int32, System.Runtime.InteropServices.FILETIME&): System.Void use System.Runtime.InteropServices.UCOMIRunningObjectTable"
		alias
			"NoteChangeTime"
		end

	enum_running (ppenum_moniker: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIENUMMONIKER) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIEnumMoniker&): System.Void use System.Runtime.InteropServices.UCOMIRunningObjectTable"
		alias
			"EnumRunning"
		end

	revoke (dw_register: INTEGER) is
		external
			"IL deferred signature (System.Int32): System.Void use System.Runtime.InteropServices.UCOMIRunningObjectTable"
		alias
			"Revoke"
		end

	register (grf_flags: INTEGER; punk_object: ANY; pmk_object_name: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIMONIKER; pdw_register: INTEGER) is
		external
			"IL deferred signature (System.Int32, System.Object, System.Runtime.InteropServices.UCOMIMoniker, System.Int32&): System.Void use System.Runtime.InteropServices.UCOMIRunningObjectTable"
		alias
			"Register"
		end

	is_running (pmk_object_name: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIMONIKER) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIMoniker): System.Void use System.Runtime.InteropServices.UCOMIRunningObjectTable"
		alias
			"IsRunning"
		end

	get_time_of_last_change (pmk_object_name: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIMONIKER; pfiletime: SYSTEM_RUNTIME_INTEROPSERVICES_FILETIME) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIMoniker, System.Runtime.InteropServices.FILETIME&): System.Void use System.Runtime.InteropServices.UCOMIRunningObjectTable"
		alias
			"GetTimeOfLastChange"
		end

	get_object (pmk_object_name: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIMONIKER; ppunk_object: ANY) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIMoniker, System.Object&): System.Void use System.Runtime.InteropServices.UCOMIRunningObjectTable"
		alias
			"GetObject"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIRUNNINGOBJECTTABLE
