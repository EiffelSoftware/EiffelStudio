indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.IExtenderProvider"

deferred external class
	SYSTEM_COMPONENTMODEL_IEXTENDERPROVIDER

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	can_extend (extendee: ANY): BOOLEAN is
		external
			"IL deferred signature (System.Object): System.Boolean use System.ComponentModel.IExtenderProvider"
		alias
			"CanExtend"
		end

end -- class SYSTEM_COMPONENTMODEL_IEXTENDERPROVIDER
