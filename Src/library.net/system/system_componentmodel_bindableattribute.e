indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.BindableAttribute"

frozen external class
	SYSTEM_COMPONENTMODEL_BINDABLEATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE
		redefine
			is_default_attribute,
			get_hash_code,
			is_equal
		end

create
	make_bindableattribute,
	make_bindableattribute_1

feature {NONE} -- Initialization

	frozen make_bindableattribute (bindable: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.ComponentModel.BindableAttribute"
		end

	frozen make_bindableattribute_1 (flags: SYSTEM_COMPONENTMODEL_BINDABLESUPPORT) is
		external
			"IL creator signature (System.ComponentModel.BindableSupport) use System.ComponentModel.BindableAttribute"
		end

feature -- Access

	frozen default: SYSTEM_COMPONENTMODEL_BINDABLEATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.BindableAttribute use System.ComponentModel.BindableAttribute"
		alias
			"Default"
		end

	frozen get_bindable: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.BindableAttribute"
		alias
			"get_Bindable"
		end

	frozen yes: SYSTEM_COMPONENTMODEL_BINDABLEATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.BindableAttribute use System.ComponentModel.BindableAttribute"
		alias
			"Yes"
		end

	frozen no: SYSTEM_COMPONENTMODEL_BINDABLEATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.BindableAttribute use System.ComponentModel.BindableAttribute"
		alias
			"No"
		end

feature -- Basic Operations

	is_default_attribute: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.BindableAttribute"
		alias
			"IsDefaultAttribute"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.BindableAttribute"
		alias
			"GetHashCode"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.BindableAttribute"
		alias
			"Equals"
		end

end -- class SYSTEM_COMPONENTMODEL_BINDABLEATTRIBUTE
