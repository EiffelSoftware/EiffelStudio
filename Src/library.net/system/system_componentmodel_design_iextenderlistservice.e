indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.Design.IExtenderListService"

deferred external class
	SYSTEM_COMPONENTMODEL_DESIGN_IEXTENDERLISTSERVICE

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	get_extender_providers: ARRAY [SYSTEM_COMPONENTMODEL_IEXTENDERPROVIDER] is
		external
			"IL deferred signature (): System.ComponentModel.IExtenderProvider[] use System.ComponentModel.Design.IExtenderListService"
		alias
			"GetExtenderProviders"
		end

end -- class SYSTEM_COMPONENTMODEL_DESIGN_IEXTENDERLISTSERVICE
