indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Runtime.InteropServices.UCOMIBindCtx"

deferred external class
	SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIBINDCTX

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	set_bind_options (pbindopts: SYSTEM_RUNTIME_INTEROPSERVICES_BIND_OPTS) is
		external
			"IL deferred signature (System.Runtime.InteropServices.BIND_OPTS&): System.Void use System.Runtime.InteropServices.UCOMIBindCtx"
		alias
			"SetBindOptions"
		end

	get_running_object_table (pprot: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIRUNNINGOBJECTTABLE) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIRunningObjectTable&): System.Void use System.Runtime.InteropServices.UCOMIBindCtx"
		alias
			"GetRunningObjectTable"
		end

	revoke_object_bound (punk: ANY) is
		external
			"IL deferred signature (System.Object): System.Void use System.Runtime.InteropServices.UCOMIBindCtx"
		alias
			"RevokeObjectBound"
		end

	enum_object_param (ppenum: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIENUMSTRING) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIEnumString&): System.Void use System.Runtime.InteropServices.UCOMIBindCtx"
		alias
			"EnumObjectParam"
		end

	get_object_param (psz_key: STRING; ppunk: ANY) is
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

	register_object_bound (punk: ANY) is
		external
			"IL deferred signature (System.Object): System.Void use System.Runtime.InteropServices.UCOMIBindCtx"
		alias
			"RegisterObjectBound"
		end

	revoke_object_param (psz_key: STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Runtime.InteropServices.UCOMIBindCtx"
		alias
			"RevokeObjectParam"
		end

	register_object_param (psz_key: STRING; punk: ANY) is
		external
			"IL deferred signature (System.String, System.Object): System.Void use System.Runtime.InteropServices.UCOMIBindCtx"
		alias
			"RegisterObjectParam"
		end

	get_bind_options (pbindopts: SYSTEM_RUNTIME_INTEROPSERVICES_BIND_OPTS) is
		external
			"IL deferred signature (System.Runtime.InteropServices.BIND_OPTS&): System.Void use System.Runtime.InteropServices.UCOMIBindCtx"
		alias
			"GetBindOptions"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIBINDCTX
