indexing
	Generator: "Eiffel Emitter 2.5b2"
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

	register_object_param (pszKey: STRING; punk: ANY) is
		external
			"IL deferred signature (System.String, System.Object): System.Void use System.Runtime.InteropServices.UCOMIBindCtx"
		alias
			"RegisterObjectParam"
		end

	get_running_object_table (pprot: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIRUNNINGOBJECTTABLE) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIRunningObjectTable&): System.Void use System.Runtime.InteropServices.UCOMIBindCtx"
		alias
			"GetRunningObjectTable"
		end

	enum_object_param (ppenum: SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIENUMSTRING) is
		external
			"IL deferred signature (System.Runtime.InteropServices.UCOMIEnumString&): System.Void use System.Runtime.InteropServices.UCOMIBindCtx"
		alias
			"EnumObjectParam"
		end

	get_object_param (pszKey: STRING; ppunk: ANY) is
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

	set_bind_options (pbindopts: SYSTEM_RUNTIME_INTEROPSERVICES_BIND_OPTS) is
		external
			"IL deferred signature (System.Runtime.InteropServices.BIND_OPTS&): System.Void use System.Runtime.InteropServices.UCOMIBindCtx"
		alias
			"SetBindOptions"
		end

	revoke_object_param (pszKey: STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Runtime.InteropServices.UCOMIBindCtx"
		alias
			"RevokeObjectParam"
		end

	get_bind_options (pbindopts: SYSTEM_RUNTIME_INTEROPSERVICES_BIND_OPTS) is
		external
			"IL deferred signature (System.Runtime.InteropServices.BIND_OPTS&): System.Void use System.Runtime.InteropServices.UCOMIBindCtx"
		alias
			"GetBindOptions"
		end

	revoke_object_bound (punk: ANY) is
		external
			"IL deferred signature (System.Object): System.Void use System.Runtime.InteropServices.UCOMIBindCtx"
		alias
			"RevokeObjectBound"
		end

end -- class SYSTEM_RUNTIME_INTEROPSERVICES_UCOMIBINDCTX
