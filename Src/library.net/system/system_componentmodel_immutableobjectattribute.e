indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.ImmutableObjectAttribute"

frozen external class
	SYSTEM_COMPONENTMODEL_IMMUTABLEOBJECTATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE
		redefine
			is_default_attribute,
			get_hash_code,
			is_equal
		end

create
	make_immutableobjectattribute

feature {NONE} -- Initialization

	frozen make_immutableobjectattribute (immutable: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.ComponentModel.ImmutableObjectAttribute"
		end

feature -- Access

	frozen default: SYSTEM_COMPONENTMODEL_IMMUTABLEOBJECTATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.ImmutableObjectAttribute use System.ComponentModel.ImmutableObjectAttribute"
		alias
			"Default"
		end

	frozen yes: SYSTEM_COMPONENTMODEL_IMMUTABLEOBJECTATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.ImmutableObjectAttribute use System.ComponentModel.ImmutableObjectAttribute"
		alias
			"Yes"
		end

	frozen no: SYSTEM_COMPONENTMODEL_IMMUTABLEOBJECTATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.ImmutableObjectAttribute use System.ComponentModel.ImmutableObjectAttribute"
		alias
			"No"
		end

	frozen get_immutable: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.ImmutableObjectAttribute"
		alias
			"get_Immutable"
		end

feature -- Basic Operations

	is_default_attribute: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.ComponentModel.ImmutableObjectAttribute"
		alias
			"IsDefaultAttribute"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.ImmutableObjectAttribute"
		alias
			"GetHashCode"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.ImmutableObjectAttribute"
		alias
			"Equals"
		end

end -- class SYSTEM_COMPONENTMODEL_IMMUTABLEOBJECTATTRIBUTE
