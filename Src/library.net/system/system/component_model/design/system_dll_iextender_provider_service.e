indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.ComponentModel.Design.IExtenderProviderService"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	SYSTEM_DLL_IEXTENDER_PROVIDER_SERVICE

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Basic Operations

	add_extender_provider (provider: SYSTEM_DLL_IEXTENDER_PROVIDER) is
		external
			"IL deferred signature (System.ComponentModel.IExtenderProvider): System.Void use System.ComponentModel.Design.IExtenderProviderService"
		alias
			"AddExtenderProvider"
		end

	remove_extender_provider (provider: SYSTEM_DLL_IEXTENDER_PROVIDER) is
		external
			"IL deferred signature (System.ComponentModel.IExtenderProvider): System.Void use System.ComponentModel.Design.IExtenderProviderService"
		alias
			"RemoveExtenderProvider"
		end

end -- class SYSTEM_DLL_IEXTENDER_PROVIDER_SERVICE
