indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.DefaultValueAttribute"

frozen external class
	SYSTEM_COMPONENTMODEL_DEFAULTVALUEATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE
		redefine
			get_hash_code,
			is_equal
		end

create
	make_defaultvalueattribute_3,
	make_defaultvalueattribute_8,
	make_defaultvalueattribute_9,
	make_defaultvalueattribute,
	make_defaultvalueattribute_10,
	make_defaultvalueattribute_4,
	make_defaultvalueattribute_5,
	make_defaultvalueattribute_6,
	make_defaultvalueattribute_7,
	make_defaultvalueattribute_1,
	make_defaultvalueattribute_2

feature {NONE} -- Initialization

	frozen make_defaultvalueattribute_3 (value: INTEGER_16) is
		external
			"IL creator signature (System.Int16) use System.ComponentModel.DefaultValueAttribute"
		end

	frozen make_defaultvalueattribute_8 (value: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.ComponentModel.DefaultValueAttribute"
		end

	frozen make_defaultvalueattribute_9 (value: STRING) is
		external
			"IL creator signature (System.String) use System.ComponentModel.DefaultValueAttribute"
		end

	frozen make_defaultvalueattribute (type: SYSTEM_TYPE; value: STRING) is
		external
			"IL creator signature (System.Type, System.String) use System.ComponentModel.DefaultValueAttribute"
		end

	frozen make_defaultvalueattribute_10 (value: ANY) is
		external
			"IL creator signature (System.Object) use System.ComponentModel.DefaultValueAttribute"
		end

	frozen make_defaultvalueattribute_4 (value: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.ComponentModel.DefaultValueAttribute"
		end

	frozen make_defaultvalueattribute_5 (value: INTEGER_64) is
		external
			"IL creator signature (System.Int64) use System.ComponentModel.DefaultValueAttribute"
		end

	frozen make_defaultvalueattribute_6 (value: REAL) is
		external
			"IL creator signature (System.Single) use System.ComponentModel.DefaultValueAttribute"
		end

	frozen make_defaultvalueattribute_7 (value: DOUBLE) is
		external
			"IL creator signature (System.Double) use System.ComponentModel.DefaultValueAttribute"
		end

	frozen make_defaultvalueattribute_1 (value: CHARACTER) is
		external
			"IL creator signature (System.Char) use System.ComponentModel.DefaultValueAttribute"
		end

	frozen make_defaultvalueattribute_2 (value: INTEGER_8) is
		external
			"IL creator signature (System.Byte) use System.ComponentModel.DefaultValueAttribute"
		end

feature -- Access

	frozen get_value: ANY is
		external
			"IL signature (): System.Object use System.ComponentModel.DefaultValueAttribute"
		alias
			"get_Value"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.DefaultValueAttribute"
		alias
			"GetHashCode"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.DefaultValueAttribute"
		alias
			"Equals"
		end

end -- class SYSTEM_COMPONENTMODEL_DEFAULTVALUEATTRIBUTE
