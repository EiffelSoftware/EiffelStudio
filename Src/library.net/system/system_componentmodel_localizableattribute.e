indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.LocalizableAttribute"

frozen external class
	SYSTEM_COMPONENTMODEL_LOCALIZABLEATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE
		redefine
			is_default_attribute,
			get_hash_code,
			equals_object
		end

create
	make_localizableattribute

feature {NONE} -- Initialization

	frozen make_localizableattribute (is_localizable: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.ComponentModel.LocalizableAttribute"
		end

feature -- Access

	frozen default: SYSTEM_COMPONENTMODEL_LOCALIZABLEATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.LocalizableAttribute use System.ComponentModel.LocalizableAttribute"
		alias
			"Default"
		end

	frozen get_is_localizable: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.LocalizableAttribute"
		alias
			"get_IsLocalizable"
		end

	frozen yes: SYSTEM_COMPONENTMODEL_LOCALIZABLEATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.LocalizableAttribute use System.ComponentModel.LocalizableAttribute"
		alias
			"Yes"
		end

	frozen no: SYSTEM_COMPONENTMODEL_LOCALIZABLEATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.LocalizableAttribute use System.ComponentModel.LocalizableAttribute"
		alias
			"No"
		end

feature -- Basic Operations

	is_default_attribute: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.LocalizableAttribute"
		alias
			"IsDefaultAttribute"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.LocalizableAttribute"
		alias
			"GetHashCode"
		end

	equals_object (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.LocalizableAttribute"
		alias
			"Equals"
		end

end -- class SYSTEM_COMPONENTMODEL_LOCALIZABLEATTRIBUTE
