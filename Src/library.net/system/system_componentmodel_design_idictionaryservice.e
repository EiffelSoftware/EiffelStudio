indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.Design.IDictionaryService"

deferred external class
	SYSTEM_COMPONENTMODEL_DESIGN_IDICTIONARYSERVICE

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	get_key (value: ANY): ANY is
		external
			"IL deferred signature (System.Object): System.Object use System.ComponentModel.Design.IDictionaryService"
		alias
			"GetKey"
		end

	set_value (key: ANY; value: ANY) is
		external
			"IL deferred signature (System.Object, System.Object): System.Void use System.ComponentModel.Design.IDictionaryService"
		alias
			"SetValue"
		end

	get_value (key: ANY): ANY is
		external
			"IL deferred signature (System.Object): System.Object use System.ComponentModel.Design.IDictionaryService"
		alias
			"GetValue"
		end

end -- class SYSTEM_COMPONENTMODEL_DESIGN_IDICTIONARYSERVICE
