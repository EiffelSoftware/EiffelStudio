indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.UCOMIMoniker"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	UCOMIMONIKER

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	load (p_stm: UCOMISTREAM) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIStream): System.Void use System.Runtime.InteropServices.UCOMIMoniker"
		alias
			"Load"
		end

	reduce (pbc: UCOMIBIND_CTX; dw_reduce_how_far: INTEGER; ppmk_to_left: UCOMIMONIKER; ppmk_reduced: UCOMIMONIKER) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIBindCtx, System.Int32, System.Runtime.InteropServices.UCOMIMoniker&, System.Runtime.InteropServices.UCOMIMoniker&): System.Void use System.Runtime.InteropServices.UCOMIMoniker"
		alias
			"Reduce"
		end

	get_display_name (pbc: UCOMIBIND_CTX; pmk_to_left: UCOMIMONIKER; ppsz_display_name: SYSTEM_STRING) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIBindCtx, System.Runtime.InteropServices.UCOMIMoniker, System.String&): System.Void use System.Runtime.InteropServices.UCOMIMoniker"
		alias
			"GetDisplayName"
		end

	get_size_max (pcb_size: INTEGER_64) is
		external
			"IL deferred signature (System.Int64&): System.Void use System.Runtime.InteropServices.UCOMIMoniker"
		alias
			"GetSizeMax"
		end

	inverse (ppmk: UCOMIMONIKER) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIMoniker&): System.Void use System.Runtime.InteropServices.UCOMIMoniker"
		alias
			"Inverse"
		end

	is_equal_ (pmk_other_moniker: UCOMIMONIKER) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIMoniker): System.Void use System.Runtime.InteropServices.UCOMIMoniker"
		alias
			"IsEqual"
		end

	get_class_id (p_class_id: GUID) is
		external
			"IL deferred signature (System.Guid&): System.Void use System.Runtime.InteropServices.UCOMIMoniker"
		alias
			"GetClassID"
		end

	relative_path_to (pmk_other: UCOMIMONIKER; ppmk_rel_path: UCOMIMONIKER) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIMoniker, System.Runtime.InteropServices.UCOMIMoniker&): System.Void use System.Runtime.InteropServices.UCOMIMoniker"
		alias
			"RelativePathTo"
		end

	save (p_stm: UCOMISTREAM; f_clear_dirty: BOOLEAN) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIStream, System.Boolean): System.Void use System.Runtime.InteropServices.UCOMIMoniker"
		alias
			"Save"
		end

	enum (f_forward: BOOLEAN; ppenum_moniker: UCOMIENUM_MONIKER) is
		external
			"IL deferred signature (System.Boolean, System.Runtime.InteropServices.UCOMIEnumMoniker&): System.Void use System.Runtime.InteropServices.UCOMIMoniker"
		alias
			"Enum"
		end

	get_time_of_last_change (pbc: UCOMIBIND_CTX; pmk_to_left: UCOMIMONIKER; p_file_time: FILETIME) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIBindCtx, System.Runtime.InteropServices.UCOMIMoniker, System.Runtime.InteropServices.FILETIME&): System.Void use System.Runtime.InteropServices.UCOMIMoniker"
		alias
			"GetTimeOfLastChange"
		end

	is_running (pbc: UCOMIBIND_CTX; pmk_to_left: UCOMIMONIKER; pmk_newly_running: UCOMIMONIKER) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIBindCtx, System.Runtime.InteropServices.UCOMIMoniker, System.Runtime.InteropServices.UCOMIMoniker): System.Void use System.Runtime.InteropServices.UCOMIMoniker"
		alias
			"IsRunning"
		end

	hash (pdw_hash: INTEGER) is
		external
			"IL deferred signature (System.Int32&): System.Void use System.Runtime.InteropServices.UCOMIMoniker"
		alias
			"Hash"
		end

	is_system_moniker (pdw_mksys: INTEGER) is
		external
			"IL deferred signature (System.Int32&): System.Void use System.Runtime.InteropServices.UCOMIMoniker"
		alias
			"IsSystemMoniker"
		end

	common_prefix_with (pmk_other: UCOMIMONIKER; ppmk_prefix: UCOMIMONIKER) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIMoniker, System.Runtime.InteropServices.UCOMIMoniker&): System.Void use System.Runtime.InteropServices.UCOMIMoniker"
		alias
			"CommonPrefixWith"
		end

	is_dirty: INTEGER is
		external
			"IL deferred signature (): System.Int32 use System.Runtime.InteropServices.UCOMIMoniker"
		alias
			"IsDirty"
		end

	bind_to_object (pbc: UCOMIBIND_CTX; pmk_to_left: UCOMIMONIKER; riid_result: GUID; ppv_result: SYSTEM_OBJECT) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIBindCtx, System.Runtime.InteropServices.UCOMIMoniker, System.Guid&, System.Object&): System.Void use System.Runtime.InteropServices.UCOMIMoniker"
		alias
			"BindToObject"
		end

	parse_display_name (pbc: UCOMIBIND_CTX; pmk_to_left: UCOMIMONIKER; psz_display_name: SYSTEM_STRING; pch_eaten: INTEGER; ppmk_out: UCOMIMONIKER) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIBindCtx, System.Runtime.InteropServices.UCOMIMoniker, System.String, System.Int32&, System.Runtime.InteropServices.UCOMIMoniker&): System.Void use System.Runtime.InteropServices.UCOMIMoniker"
		alias
			"ParseDisplayName"
		end

	bind_to_storage (pbc: UCOMIBIND_CTX; pmk_to_left: UCOMIMONIKER; riid: GUID; ppv_obj: SYSTEM_OBJECT) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIBindCtx, System.Runtime.InteropServices.UCOMIMoniker, System.Guid&, System.Object&): System.Void use System.Runtime.InteropServices.UCOMIMoniker"
		alias
			"BindToStorage"
		end

	compose_with (pmk_right: UCOMIMONIKER; f_only_if_not_generic: BOOLEAN; ppmk_composite: UCOMIMONIKER) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIMoniker, System.Boolean, System.Runtime.InteropServices.UCOMIMoniker&): System.Void use System.Runtime.InteropServices.UCOMIMoniker"
		alias
			"ComposeWith"
		end

end -- class UCOMIMONIKER
