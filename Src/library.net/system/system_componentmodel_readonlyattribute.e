indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.ReadOnlyAttribute"

frozen external class
	SYSTEM_COMPONENTMODEL_READONLYATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE
		redefine
			is_default_attribute,
			get_hash_code,
			is_equal
		end

create
	make_readonlyattribute

feature {NONE} -- Initialization

	frozen make_readonlyattribute (is_read_only: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.ComponentModel.ReadOnlyAttribute"
		end

feature -- Access

	frozen default: SYSTEM_COMPONENTMODEL_READONLYATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.ReadOnlyAttribute use System.ComponentModel.ReadOnlyAttribute"
		alias
			"Default"
		end

	frozen yes: SYSTEM_COMPONENTMODEL_READONLYATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.ReadOnlyAttribute use System.ComponentModel.ReadOnlyAttribute"
		alias
			"Yes"
		end

	frozen no: SYSTEM_COMPONENTMODEL_READONLYATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.ReadOnlyAttribute use System.ComponentModel.ReadOnlyAttribute"
		alias
			"No"
		end

	frozen get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.ReadOnlyAttribute"
		alias
			"get_IsReadOnly"
		end

feature -- Basic Operations

	is_default_attribute: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.ReadOnlyAttribute"
		alias
			"IsDefaultAttribute"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.ReadOnlyAttribute"
		alias
			"GetHashCode"
		end

	is_equal (value: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.ReadOnlyAttribute"
		alias
			"Equals"
		end

end -- class SYSTEM_COMPONENTMODEL_READONLYATTRIBUTE
