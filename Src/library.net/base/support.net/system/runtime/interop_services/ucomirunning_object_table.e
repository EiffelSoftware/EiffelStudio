indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.UCOMIRunningObjectTable"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	UCOMIRUNNING_OBJECT_TABLE

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	note_change_time (dw_register: INTEGER; pfiletime: FILETIME) is
		external
			"IL deferred signature (System.Int32, System.Runtime.InteropServices.FILETIME&): System.Void use System.Runtime.InteropServices.UCOMIRunningObjectTable"
		alias
			"NoteChangeTime"
		end

	enum_running (ppenum_moniker: UCOMIENUM_MONIKER) is
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

	register (grf_flags: INTEGER; punk_object: SYSTEM_OBJECT; pmk_object_name: UCOMIMONIKER; pdw_register: INTEGER) is
		external
			"IL deferred signature (System.Int32, System.Object, System.Runtime.InteropServices.UCOMIMoniker, System.Int32&): System.Void use System.Runtime.InteropServices.UCOMIRunningObjectTable"
		alias
			"Register"
		end

	is_running (pmk_object_name: UCOMIMONIKER) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIMoniker): System.Void use System.Runtime.InteropServices.UCOMIRunningObjectTable"
		alias
			"IsRunning"
		end

	get_time_of_last_change (pmk_object_name: UCOMIMONIKER; pfiletime: FILETIME) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIMoniker, System.Runtime.InteropServices.FILETIME&): System.Void use System.Runtime.InteropServices.UCOMIRunningObjectTable"
		alias
			"GetTimeOfLastChange"
		end

	get_object (pmk_object_name: UCOMIMONIKER; ppunk_object: SYSTEM_OBJECT) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIMoniker, System.Object&): System.Void use System.Runtime.InteropServices.UCOMIRunningObjectTable"
		alias
			"GetObject"
		end

end -- class UCOMIRUNNING_OBJECT_TABLE
