indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.DescriptionAttribute"

external class
	SYSTEM_COMPONENTMODEL_DESCRIPTIONATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE
		redefine
			get_hash_code,
			equals_object
		end

create
	make_descriptionattribute,
	make_descriptionattribute_1

feature {NONE} -- Initialization

	frozen make_descriptionattribute is
		external
			"IL creator use System.ComponentModel.DescriptionAttribute"
		end

	frozen make_descriptionattribute_1 (description: STRING) is
		external
			"IL creator signature (System.String) use System.ComponentModel.DescriptionAttribute"
		end

feature -- Access

	get_description: STRING is
		external
			"IL signature (): System.String use System.ComponentModel.DescriptionAttribute"
		alias
			"get_Description"
		end

	frozen default: SYSTEM_COMPONENTMODEL_DESCRIPTIONATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.DescriptionAttribute use System.ComponentModel.DescriptionAttribute"
		alias
			"Default"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.DescriptionAttribute"
		alias
			"GetHashCode"
		end

	equals_object (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.DescriptionAttribute"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	frozen get_description_value: STRING is
		external
			"IL signature (): System.String use System.ComponentModel.DescriptionAttribute"
		alias
			"get_DescriptionValue"
		end

	frozen set_description_value (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.ComponentModel.DescriptionAttribute"
		alias
			"set_DescriptionValue"
		end

end -- class SYSTEM_COMPONENTMODEL_DESCRIPTIONATTRIBUTE
