indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.DesignTimeVisibleAttribute"

frozen external class
	SYSTEM_COMPONENTMODEL_DESIGNTIMEVISIBLEATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE
		redefine
			is_default_attribute,
			get_hash_code,
			equals_object
		end

create
	make_designtimevisibleattribute_1,
	make_designtimevisibleattribute

feature {NONE} -- Initialization

	frozen make_designtimevisibleattribute_1 is
		external
			"IL creator use System.ComponentModel.DesignTimeVisibleAttribute"
		end

	frozen make_designtimevisibleattribute (visible: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.ComponentModel.DesignTimeVisibleAttribute"
		end

feature -- Access

	frozen default: SYSTEM_COMPONENTMODEL_DESIGNTIMEVISIBLEATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.DesignTimeVisibleAttribute use System.ComponentModel.DesignTimeVisibleAttribute"
		alias
			"Default"
		end

	frozen yes: SYSTEM_COMPONENTMODEL_DESIGNTIMEVISIBLEATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.DesignTimeVisibleAttribute use System.ComponentModel.DesignTimeVisibleAttribute"
		alias
			"Yes"
		end

	frozen no: SYSTEM_COMPONENTMODEL_DESIGNTIMEVISIBLEATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.DesignTimeVisibleAttribute use System.ComponentModel.DesignTimeVisibleAttribute"
		alias
			"No"
		end

	frozen get_visible: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.DesignTimeVisibleAttribute"
		alias
			"get_Visible"
		end

feature -- Basic Operations

	is_default_attribute: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.DesignTimeVisibleAttribute"
		alias
			"IsDefaultAttribute"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.DesignTimeVisibleAttribute"
		alias
			"GetHashCode"
		end

	equals_object (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.DesignTimeVisibleAttribute"
		alias
			"Equals"
		end

end -- class SYSTEM_COMPONENTMODEL_DESIGNTIMEVISIBLEATTRIBUTE
