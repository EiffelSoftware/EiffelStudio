indexing
	Generator: "Eiffel Emitter 2.5b2"
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

	compose_with (pmkRight: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIMONIKER; fOnlyIfNotGeneric: BOOLEAN; ppmkComposite: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIMONIKER) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIMoniker, System.Boolean, System.Runtime.InteropServices.UCOMIMoniker&): System.Void use System.Runtime.InteropServices.UCOMIMoniker"
		alias
			"ComposeWith"
		end

	relative_path_to (pmkOther: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIMONIKER; ppmkRelPath: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIMONIKER) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIMoniker, System.Runtime.InteropServices.UCOMIMoniker&): System.Void use System.Runtime.InteropServices.UCOMIMoniker"
		alias
			"RelativePathTo"
		end

	get_size_max (pcbSize: INTEGER_64) is
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

	common_prefix_with (pmkOther: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIMONIKER; ppmkPrefix: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIMONIKER) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIMoniker, System.Runtime.InteropServices.UCOMIMoniker&): System.Void use System.Runtime.InteropServices.UCOMIMoniker"
		alias
			"CommonPrefixWith"
		end

	get_class_id (pClassID: SYSTEM_GUID) is
		external
			"IL deferred signature (System.Guid&): System.Void use System.Runtime.InteropServices.UCOMIMoniker"
		alias
			"GetClassID"
		end

	hash (pdwHash: INTEGER) is
		external
			"IL deferred signature (System.Int32&): System.Void use System.Runtime.InteropServices.UCOMIMoniker"
		alias
			"Hash"
		end

	get_display_name (pbc: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIBINDCTX; pmkToLeft: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIMONIKER; ppszDisplayName: STRING) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIBindCtx, System.Runtime.InteropServices.UCOMIMoniker, System.String&): System.Void use System.Runtime.InteropServices.UCOMIMoniker"
		alias
			"GetDisplayName"
		end

	bind_to_storage (pbc: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIBINDCTX; pmkToLeft: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIMONIKER; riid: SYSTEM_GUID; ppvObj: ANY) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIBindCtx, System.Runtime.InteropServices.UCOMIMoniker, System.Guid&, System.Object&): System.Void use System.Runtime.InteropServices.UCOMIMoniker"
		alias
			"BindToStorage"
		end

	reduce (pbc: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIBINDCTX; dwReduceHowFar: INTEGER; ppmkToLeft: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIMONIKER; ppmkReduced: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIMONIKER) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIBindCtx, System.Int32, System.Runtime.InteropServices.UCOMIMoniker&, System.Runtime.InteropServices.UCOMIMoniker&): System.Void use System.Runtime.InteropServices.UCOMIMoniker"
		alias
			"Reduce"
		end

	is_system_moniker (pdwMksys: INTEGER) is
		external
			"IL deferred signature (System.Int32&): System.Void use System.Runtime.InteropServices.UCOMIMoniker"
		alias
			"IsSystemMoniker"
		end

	enum (fForward: BOOLEAN; ppenumMoniker: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIENUMMONIKER) is
		external
			"IL deferred signature (System.Boolean, System.Runtime.InteropServices.UCOMIEnumMoniker&): System.Void use System.Runtime.InteropServices.UCOMIMoniker"
		alias
			"Enum"
		end

	parse_display_name (pbc: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIBINDCTX; pmkToLeft: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIMONIKER; pszDisplayName: STRING; pchEaten: INTEGER; ppmkOut: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIMONIKER) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIBindCtx, System.Runtime.InteropServices.UCOMIMoniker, System.String, System.Int32&, System.Runtime.InteropServices.UCOMIMoniker&): System.Void use System.Runtime.InteropServices.UCOMIMoniker"
		alias
			"ParseDisplayName"
		end

	is_running (pbc: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIBINDCTX; pmkToLeft: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIMONIKER; pmkNewlyRunning: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIMONIKER) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIBindCtx, System.Runtime.InteropServices.UCOMIMoniker, System.Runtime.InteropServices.UCOMIMoniker): System.Void use System.Runtime.InteropServices.UCOMIMoniker"
		alias
			"IsRunning"
		end

	get_time_of_last_change (pbc: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIBINDCTX; pmkToLeft: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIMONIKER; pFileTime: SYSTEM_RUNTIME_INTEROPSERVICES_FILETIME) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIBindCtx, System.Runtime.InteropServices.UCOMIMoniker, System.Runtime.InteropServices.FILETIME&): System.Void use System.Runtime.InteropServices.UCOMIMoniker"
		alias
			"GetTimeOfLastChange"
		end

	is_dirty is
		external
			"IL deferred signature (): System.Void use System.Runtime.InteropServices.UCOMIMoniker"
		alias
			"IsDirty"
		end

	bind_to_object (pbc: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIBINDCTX; pmkToLeft: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIMONIKER; riidResult: SYSTEM_GUID; ppvResult: ANY) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIBindCtx, System.Runtime.InteropServices.UCOMIMoniker, System.Guid&, System.Object&): System.Void use System.Runtime.InteropServices.UCOMIMoniker"
		alias
			"BindToObject"
		end

	is_equal_ucomimoniker (pmkOtherMoniker: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIMONIKER) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIMoniker): System.Void use System.Runtime.InteropServices.UCOMIMoniker"
		alias
			"IsEqual"
		end

	save (pStm: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMISTREAM; fClearDirty: BOOLEAN) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIStream, System.Boolean): System.Void use System.Runtime.InteropServices.UCOMIMoniker"
		alias
			"Save"
		end

	load (pStm: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMISTREAM) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIStream): System.Void use System.Runtime.InteropServices.UCOMIMoniker"
		alias
			"Load"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIMONIKER
