indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.Design.IExtenderProviderService"

deferred external class
	SYSTEM_COMPONENTMODEL_DESIGN_IEXTENDERPROVIDERSERVICE

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	add_extender_provider (provider: SYSTEM_COMPONENTMODEL_IEXTENDERPROVIDER) is
		external
			"IL deferred signature (System.ComponentModel.IExtenderProvider): System.Void use System.ComponentModel.Design.IExtenderProviderService"
		alias
			"AddExtenderProvider"
		end

	remove_extender_provider (provider: SYSTEM_COMPONENTMODEL_IEXTENDERPROVIDER) is
		external
			"IL deferred signature (System.ComponentModel.IExtenderProvider): System.Void use System.ComponentModel.Design.IExtenderProviderService"
		alias
			"RemoveExtenderProvider"
		end

end -- class SYSTEM_COMPONENTMODEL_DESIGN_IEXTENDERPROVIDERSERVICE
