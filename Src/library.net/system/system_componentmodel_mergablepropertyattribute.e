indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.MergablePropertyAttribute"

frozen external class
	SYSTEM_COMPONENTMODEL_MERGABLEPROPERTYATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE
		redefine
			is_default_attribute,
			get_hash_code,
			is_equal
		end

create
	make_mergablepropertyattribute

feature {NONE} -- Initialization

	frozen make_mergablepropertyattribute (allow_merge: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.ComponentModel.MergablePropertyAttribute"
		end

feature -- Access

	frozen default: SYSTEM_COMPONENTMODEL_MERGABLEPROPERTYATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.MergablePropertyAttribute use System.ComponentModel.MergablePropertyAttribute"
		alias
			"Default"
		end

	frozen get_allow_merge: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.MergablePropertyAttribute"
		alias
			"get_AllowMerge"
		end

	frozen yes: SYSTEM_COMPONENTMODEL_MERGABLEPROPERTYATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.MergablePropertyAttribute use System.ComponentModel.MergablePropertyAttribute"
		alias
			"Yes"
		end

	frozen no: SYSTEM_COMPONENTMODEL_MERGABLEPROPERTYATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.MergablePropertyAttribute use System.ComponentModel.MergablePropertyAttribute"
		alias
			"No"
		end

feature -- Basic Operations

	is_default_attribute: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.MergablePropertyAttribute"
		alias
			"IsDefaultAttribute"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.MergablePropertyAttribute"
		alias
			"GetHashCode"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.MergablePropertyAttribute"
		alias
			"Equals"
		end

end -- class SYSTEM_COMPONENTMODEL_MERGABLEPROPERTYATTRIBUTE
