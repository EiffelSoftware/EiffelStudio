indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.DesignOnlyAttribute"

frozen external class
	SYSTEM_COMPONENTMODEL_DESIGNONLYATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE
		redefine
			is_default_attribute,
			get_hash_code,
			is_equal
		end

create
	make_designonlyattribute

feature {NONE} -- Initialization

	frozen make_designonlyattribute (is_design_only: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.ComponentModel.DesignOnlyAttribute"
		end

feature -- Access

	frozen get_is_design_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.DesignOnlyAttribute"
		alias
			"get_IsDesignOnly"
		end

	frozen default: SYSTEM_COMPONENTMODEL_DESIGNONLYATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.DesignOnlyAttribute use System.ComponentModel.DesignOnlyAttribute"
		alias
			"Default"
		end

	frozen yes: SYSTEM_COMPONENTMODEL_DESIGNONLYATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.DesignOnlyAttribute use System.ComponentModel.DesignOnlyAttribute"
		alias
			"Yes"
		end

	frozen no: SYSTEM_COMPONENTMODEL_DESIGNONLYATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.DesignOnlyAttribute use System.ComponentModel.DesignOnlyAttribute"
		alias
			"No"
		end

feature -- Basic Operations

	is_default_attribute: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.DesignOnlyAttribute"
		alias
			"IsDefaultAttribute"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.DesignOnlyAttribute"
		alias
			"GetHashCode"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.DesignOnlyAttribute"
		alias
			"Equals"
		end

end -- class SYSTEM_COMPONENTMODEL_DESIGNONLYATTRIBUTE
