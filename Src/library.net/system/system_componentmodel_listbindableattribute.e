indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.ListBindableAttribute"

frozen external class
	SYSTEM_COMPONENTMODEL_LISTBINDABLEATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE
		redefine
			is_default_attribute,
			get_hash_code,
			is_equal
		end

create
	make_listbindableattribute_1,
	make_listbindableattribute

feature {NONE} -- Initialization

	frozen make_listbindableattribute_1 (flags: SYSTEM_COMPONENTMODEL_BINDABLESUPPORT) is
		external
			"IL creator signature (System.ComponentModel.BindableSupport) use System.ComponentModel.ListBindableAttribute"
		end

	frozen make_listbindableattribute (list_bindable: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.ComponentModel.ListBindableAttribute"
		end

feature -- Access

	frozen default: SYSTEM_COMPONENTMODEL_LISTBINDABLEATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.ListBindableAttribute use System.ComponentModel.ListBindableAttribute"
		alias
			"Default"
		end

	frozen get_list_bindable: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.ListBindableAttribute"
		alias
			"get_ListBindable"
		end

	frozen yes: SYSTEM_COMPONENTMODEL_LISTBINDABLEATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.ListBindableAttribute use System.ComponentModel.ListBindableAttribute"
		alias
			"Yes"
		end

	frozen no: SYSTEM_COMPONENTMODEL_LISTBINDABLEATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.ListBindableAttribute use System.ComponentModel.ListBindableAttribute"
		alias
			"No"
		end

feature -- Basic Operations

	is_default_attribute: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.ListBindableAttribute"
		alias
			"IsDefaultAttribute"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.ListBindableAttribute"
		alias
			"GetHashCode"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.ListBindableAttribute"
		alias
			"Equals"
		end

end -- class SYSTEM_COMPONENTMODEL_LISTBINDABLEATTRIBUTE
