indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.DefaultEventAttribute"

frozen external class
	SYSTEM_COMPONENTMODEL_DEFAULTEVENTATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE
		redefine
			get_hash_code,
			equals_object
		end

create
	make_defaulteventattribute

feature {NONE} -- Initialization

	frozen make_defaulteventattribute (name: STRING) is
		external
			"IL creator signature (System.String) use System.ComponentModel.DefaultEventAttribute"
		end

feature -- Access

	frozen default: SYSTEM_COMPONENTMODEL_DEFAULTEVENTATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.DefaultEventAttribute use System.ComponentModel.DefaultEventAttribute"
		alias
			"Default"
		end

	frozen get_name: STRING is
		external
			"IL signature (): System.String use System.ComponentModel.DefaultEventAttribute"
		alias
			"get_Name"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.DefaultEventAttribute"
		alias
			"GetHashCode"
		end

	equals_object (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.DefaultEventAttribute"
		alias
			"Equals"
		end

end -- class SYSTEM_COMPONENTMODEL_DEFAULTEVENTATTRIBUTE
