indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.InteropServices.UCOMIMoniker"

deferred external class
	SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIMONIKER

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	load (p_stm: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMISTREAM) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIStream): System.Void use System.Runtime.InteropServices.UCOMIMoniker"
		alias
			"Load"
		end

	reduce (pbc: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIBINDCTX; dw_reduce_how_far: INTEGER; ppmk_to_left: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIMONIKER; ppmk_reduced: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIMONIKER) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIBindCtx, System.Int32, System.Runtime.InteropServices.UCOMIMoniker&, System.Runtime.InteropServices.UCOMIMoniker&): System.Void use System.Runtime.InteropServices.UCOMIMoniker"
		alias
			"Reduce"
		end

	get_display_name (pbc: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIBINDCTX; pmk_to_left: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIMONIKER; ppsz_display_name: STRING) is
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

	inverse (ppmk: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIMONIKER) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIMoniker&): System.Void use System.Runtime.InteropServices.UCOMIMoniker"
		alias
			"Inverse"
		end

	get_class_id (p_class_id: SYSTEM_GUID) is
		external
			"IL deferred signature (System.Guid&): System.Void use System.Runtime.InteropServices.UCOMIMoniker"
		alias
			"GetClassID"
		end

	is_equal_to (pmk_other_moniker: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIMONIKER) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIMoniker): System.Void use System.Runtime.InteropServices.UCOMIMoniker"
		alias
			"IsEqual"
		end

	relative_path_to (pmk_other: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIMONIKER; ppmk_rel_path: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIMONIKER) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIMoniker, System.Runtime.InteropServices.UCOMIMoniker&): System.Void use System.Runtime.InteropServices.UCOMIMoniker"
		alias
			"RelativePathTo"
		end

	save (p_stm: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMISTREAM; f_clear_dirty: BOOLEAN) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIStream, System.Boolean): System.Void use System.Runtime.InteropServices.UCOMIMoniker"
		alias
			"Save"
		end

	enum (f_forward: BOOLEAN; ppenum_moniker: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIENUMMONIKER) is
		external
			"IL deferred signature (System.Boolean, System.Runtime.InteropServices.UCOMIEnumMoniker&): System.Void use System.Runtime.InteropServices.UCOMIMoniker"
		alias
			"Enum"
		end

	get_time_of_last_change (pbc: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIBINDCTX; pmk_to_left: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIMONIKER; p_file_time: SYSTEM_RUNTIME_INTEROPSERVICES_FILETIME) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIBindCtx, System.Runtime.InteropServices.UCOMIMoniker, System.Runtime.InteropServices.FILETIME&): System.Void use System.Runtime.InteropServices.UCOMIMoniker"
		alias
			"GetTimeOfLastChange"
		end

	is_running (pbc: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIBINDCTX; pmk_to_left: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIMONIKER; pmk_newly_running: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIMONIKER) is
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

	common_prefix_with (pmk_other: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIMONIKER; ppmk_prefix: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIMONIKER) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIMoniker, System.Runtime.InteropServices.UCOMIMoniker&): System.Void use System.Runtime.InteropServices.UCOMIMoniker"
		alias
			"CommonPrefixWith"
		end

	is_dirty is
		external
			"IL deferred signature (): System.Void use System.Runtime.InteropServices.UCOMIMoniker"
		alias
			"IsDirty"
		end

	bind_to_object (pbc: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIBINDCTX; pmk_to_left: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIMONIKER; riid_result: SYSTEM_GUID; ppv_result: ANY) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIBindCtx, System.Runtime.InteropServices.UCOMIMoniker, System.Guid&, System.Object&): System.Void use System.Runtime.InteropServices.UCOMIMoniker"
		alias
			"BindToObject"
		end

	parse_display_name (pbc: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIBINDCTX; pmk_to_left: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIMONIKER; psz_display_name: STRING; pch_eaten: INTEGER; ppmk_out: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIMONIKER) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIBindCtx, System.Runtime.InteropServices.UCOMIMoniker, System.String, System.Int32&, System.Runtime.InteropServices.UCOMIMoniker&): System.Void use System.Runtime.InteropServices.UCOMIMoniker"
		alias
			"ParseDisplayName"
		end

	bind_to_storage (pbc: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIBINDCTX; pmk_to_left: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIMONIKER; riid: SYSTEM_GUID; ppv_obj: ANY) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIBindCtx, System.Runtime.InteropServices.UCOMIMoniker, System.Guid&, System.Object&): System.Void use System.Runtime.InteropServices.UCOMIMoniker"
		alias
			"BindToStorage"
		end

	compose_with (pmk_right: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIMONIKER; f_only_if_not_generic: BOOLEAN; ppmk_composite: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIMONIKER) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIMoniker, System.Boolean, System.Runtime.InteropServices.UCOMIMoniker&): System.Void use System.Runtime.InteropServices.UCOMIMoniker"
		alias
			"ComposeWith"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIMONIKER
