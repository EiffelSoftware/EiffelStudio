indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.AmbientValueAttribute"

frozen external class
	SYSTEM_COMPONENTMODEL_AMBIENTVALUEATTRIBUTE

inherit
	SYSTEM_ATTRIBUTE
		redefine
			get_hash_code,
			is_equal
		end

create
	make_ambientvalueattribute_1,
	make_ambientvalueattribute_10,
	make_ambientvalueattribute_7,
	make_ambientvalueattribute_8,
	make_ambientvalueattribute_9,
	make_ambientvalueattribute,
	make_ambientvalueattribute_6,
	make_ambientvalueattribute_5,
	make_ambientvalueattribute_4,
	make_ambientvalueattribute_3,
	make_ambientvalueattribute_2

feature {NONE} -- Initialization

	frozen make_ambientvalueattribute_1 (value: CHARACTER) is
		external
			"IL creator signature (System.Char) use System.ComponentModel.AmbientValueAttribute"
		end

	frozen make_ambientvalueattribute_10 (value: ANY) is
		external
			"IL creator signature (System.Object) use System.ComponentModel.AmbientValueAttribute"
		end

	frozen make_ambientvalueattribute_7 (value: DOUBLE) is
		external
			"IL creator signature (System.Double) use System.ComponentModel.AmbientValueAttribute"
		end

	frozen make_ambientvalueattribute_8 (value: BOOLEAN) is
		external
			"IL creator signature (System.Boolean) use System.ComponentModel.AmbientValueAttribute"
		end

	frozen make_ambientvalueattribute_9 (value: STRING) is
		external
			"IL creator signature (System.String) use System.ComponentModel.AmbientValueAttribute"
		end

	frozen make_ambientvalueattribute (type: SYSTEM_TYPE; value: STRING) is
		external
			"IL creator signature (System.Type, System.String) use System.ComponentModel.AmbientValueAttribute"
		end

	frozen make_ambientvalueattribute_6 (value: REAL) is
		external
			"IL creator signature (System.Single) use System.ComponentModel.AmbientValueAttribute"
		end

	frozen make_ambientvalueattribute_5 (value: INTEGER_64) is
		external
			"IL creator signature (System.Int64) use System.ComponentModel.AmbientValueAttribute"
		end

	frozen make_ambientvalueattribute_4 (value: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.ComponentModel.AmbientValueAttribute"
		end

	frozen make_ambientvalueattribute_3 (value: INTEGER_16) is
		external
			"IL creator signature (System.Int16) use System.ComponentModel.AmbientValueAttribute"
		end

	frozen make_ambientvalueattribute_2 (value: INTEGER_8) is
		external
			"IL creator signature (System.Byte) use System.ComponentModel.AmbientValueAttribute"
		end

feature -- Access

	frozen get_value: ANY is
		external
			"IL signature (): System.Object use System.ComponentModel.AmbientValueAttribute"
		alias
			"get_Value"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.ComponentModel.AmbientValueAttribute"
		alias
			"GetHashCode"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.ComponentModel.AmbientValueAttribute"
		alias
			"Equals"
		end

end -- class SYSTEM_COMPONENTMODEL_AMBIENTVALUEATTRIBUTE
