indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.BrowsableAttribute"

frozen external class
	SYSTEM_COMPONENTMODEL_BROWSABLEATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE
		redefine
			is_default_attribute,
			get_hash_code,
			is_equal
		end

create
	make_browsableattribute

feature {NONE} -- Initialization

	frozen make_browsableattribute (browsable: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.ComponentModel.BrowsableAttribute"
		end

feature -- Access

	frozen default: SYSTEM_COMPONENTMODEL_BROWSABLEATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.BrowsableAttribute use System.ComponentModel.BrowsableAttribute"
		alias
			"Default"
		end

	frozen get_browsable: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.BrowsableAttribute"
		alias
			"get_Browsable"
		end

	frozen yes: SYSTEM_COMPONENTMODEL_BROWSABLEATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.BrowsableAttribute use System.ComponentModel.BrowsableAttribute"
		alias
			"Yes"
		end

	frozen no: SYSTEM_COMPONENTMODEL_BROWSABLEATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.BrowsableAttribute use System.ComponentModel.BrowsableAttribute"
		alias
			"No"
		end

feature -- Basic Operations

	is_default_attribute: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.BrowsableAttribute"
		alias
			"IsDefaultAttribute"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.BrowsableAttribute"
		alias
			"GetHashCode"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.BrowsableAttribute"
		alias
			"Equals"
		end

end -- class SYSTEM_COMPONENTMODEL_BROWSABLEATTRIBUTE
