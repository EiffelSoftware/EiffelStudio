indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.InteropServices.UCOMIBindCtx"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	UCOMIBIND_CTX

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	set_bind_options (pbindopts: BIND_OPTS) is
		external
			"IL deferred signature (System.Runtime.InteropServices.BIND_OPTS&): System.Void use System.Runtime.InteropServices.UCOMIBindCtx"
		alias
			"SetBindOptions"
		end

	get_running_object_table (pprot: UCOMIRUNNING_OBJECT_TABLE) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIRunningObjectTable&): System.Void use System.Runtime.InteropServices.UCOMIBindCtx"
		alias
			"GetRunningObjectTable"
		end

	revoke_object_bound (punk: SYSTEM_OBJECT) is
		external
			"IL deferred signature (System.Object): System.Void use System.Runtime.InteropServices.UCOMIBindCtx"
		alias
			"RevokeObjectBound"
		end

	enum_object_param (ppenum: UCOMIENUM_STRING) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIEnumString&): System.Void use System.Runtime.InteropServices.UCOMIBindCtx"
		alias
			"EnumObjectParam"
		end

	get_object_param (psz_key: SYSTEM_STRING; ppunk: SYSTEM_OBJECT) is
		external
			"IL deferred signature (System.String, System.Object&): System.Void use System.Runtime.InteropServices.UCOMIBindCtx"
		alias
			"GetObjectParam"
		end

	release_bound_objects is
		external
			"IL deferred signature (): System.Void use System.Runtime.InteropServices.UCOMIBindCtx"
		alias
			"ReleaseBoundObjects"
		end

	register_object_bound (punk: SYSTEM_OBJECT) is
		external
			"IL deferred signature (System.Object): System.Void use System.Runtime.InteropServices.UCOMIBindCtx"
		alias
			"RegisterObjectBound"
		end

	revoke_object_param (psz_key: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Runtime.InteropServices.UCOMIBindCtx"
		alias
			"RevokeObjectParam"
		end

	register_object_param (psz_key: SYSTEM_STRING; punk: SYSTEM_OBJECT) is
		external
			"IL deferred signature (System.String, System.Object): System.Void use System.Runtime.InteropServices.UCOMIBindCtx"
		alias
			"RegisterObjectParam"
		end

	get_bind_options (pbindopts: BIND_OPTS) is
		external
			"IL deferred signature (System.Runtime.InteropServices.BIND_OPTS&): System.Void use System.Runtime.InteropServices.UCOMIBindCtx"
		alias
			"GetBindOptions"
		end

end -- class UCOMIBIND_CTX
