indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.Design.IExtenderListService"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_IEXTENDER_LIST_SERVICE

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	get_extender_providers: NATIVE_ARRAY [SYSTEM_DLL_IEXTENDER_PROVIDER] is
		external
			"IL deferred signature (): System.ComponentModel.IExtenderProvider[] use System.ComponentModel.Design.IExtenderListService"
		alias
			"GetExtenderProviders"
		end

end -- class SYSTEM_DLL_IEXTENDER_LIST_SERVICE
