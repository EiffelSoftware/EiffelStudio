indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.Design.IDesignerOptionService"

deferred external class
	SYSTEM_COMPONENTMODEL_DESIGN_IDESIGNEROPTIONSERVICE

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Basic Operations

	get_option_value (page_name: STRING; value_name: STRING): ANY is
		external
			"IL deferred signature (System.String, System.String): System.Object use System.ComponentModel.Design.IDesignerOptionService"
		alias
			"GetOptionValue"
		end

	set_option_value (page_name: STRING; value_name: STRING; value: ANY) is
		external
			"IL deferred signature (System.String, System.String, System.Object): System.Void use System.ComponentModel.Design.IDesignerOptionService"
		alias
			"SetOptionValue"
		end

end -- class SYSTEM_COMPONENTMODEL_DESIGN_IDESIGNEROPTIONSERVICE
