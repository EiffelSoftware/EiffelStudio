indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.TypeConverterAttribute"

frozen external class
	SYSTEM_COMPONENTMODEL_TYPECONVERTERATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE
		redefine
			get_hash_code,
			is_equal
		end

create
	make_typeconverterattribute,
	make_typeconverterattribute_1,
	make_typeconverterattribute_2

feature {NONE} -- Initialization

	frozen make_typeconverterattribute is
		external
			"IL creator use System.ComponentModel.TypeConverterAttribute"
		end

	frozen make_typeconverterattribute_1 (type: SYSTEM_TYPE) is
		external
			"IL creator signature (System.Type) use System.ComponentModel.TypeConverterAttribute"
		end

	frozen make_typeconverterattribute_2 (type_name: STRING) is
		external
			"IL creator signature (System.String) use System.ComponentModel.TypeConverterAttribute"
		end

feature -- Access

	frozen default: SYSTEM_COMPONENTMODEL_TYPECONVERTERATTRIBUTE is
		external
			"IL static_field signature :System.ComponentModel.TypeConverterAttribute use System.ComponentModel.TypeConverterAttribute"
		alias
			"Default"
		end

	frozen get_converter_type_name: STRING is
		external
			"IL signature (): System.String use System.ComponentModel.TypeConverterAttribute"
		alias
			"get_ConverterTypeName"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.TypeConverterAttribute"
		alias
			"GetHashCode"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.TypeConverterAttribute"
		alias
			"Equals"
		end

end -- class SYSTEM_COMPONENTMODEL_TYPECONVERTERATTRIBUTE
