indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.DefaultPropertyAttribute"

frozen external class
	SYSTEM_COMPONENTMODEL_DEFAULTPROPERTYATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE
		redefine
			get_hash_code,
			equals_object
		end

create
	make_defaultpropertyattribute

feature {NONE} -- Initialization

	frozen make_defaultpropertyattribute (name: STRING) is
		external
			"IL creator signature (System.String) use System.ComponentModel.DefaultPropertyAttribute"
		end

feature -- Access

	frozen default: SYSTEM_COMPONENTMODEL_DEFAULTPROPERTYATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.DefaultPropertyAttribute use System.ComponentModel.DefaultPropertyAttribute"
		alias
			"Default"
		end

	frozen get_name: STRING is
		external
			"IL signature (): System.String use System.ComponentModel.DefaultPropertyAttribute"
		alias
			"get_Name"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.DefaultPropertyAttribute"
		alias
			"GetHashCode"
		end

	equals_object (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.DefaultPropertyAttribute"
		alias
			"Equals"
		end

end -- class SYSTEM_COMPONENTMODEL_DEFAULTPROPERTYATTRIBUTE
