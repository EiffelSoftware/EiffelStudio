indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.SqlTypes.SqlCompareOptions"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DATA_SQLTYPES_SQLCOMPAREOPTIONS

inherit
	ENUM
		rename
			is_equal as equals_object
		end
	SYSTEM_IFORMATTABLE
		rename
			is_equal as equals_object
		end
	SYSTEM_ICOMPARABLE
		rename
			is_equal as equals_object
		end

feature -- Access

	frozen binary_sort: SYSTEM_DATA_SQLTYPES_SQLCOMPAREOPTIONS is
		external
			"IL enum signature :System.Data.SqlTypes.SqlCompareOptions use System.Data.SqlTypes.SqlCompareOptions"
		alias
			"32768"
		end

	frozen ignore_non_space: SYSTEM_DATA_SQLTYPES_SQLCOMPAREOPTIONS is
		external
			"IL enum signature :System.Data.SqlTypes.SqlCompareOptions use System.Data.SqlTypes.SqlCompareOptions"
		alias
			"2"
		end

	frozen ignore_case: SYSTEM_DATA_SQLTYPES_SQLCOMPAREOPTIONS is
		external
			"IL enum signature :System.Data.SqlTypes.SqlCompareOptions use System.Data.SqlTypes.SqlCompareOptions"
		alias
			"1"
		end

	frozen none: SYSTEM_DATA_SQLTYPES_SQLCOMPAREOPTIONS is
		external
			"IL enum signature :System.Data.SqlTypes.SqlCompareOptions use System.Data.SqlTypes.SqlCompareOptions"
		alias
			"0"
		end

	frozen ignore_width: SYSTEM_DATA_SQLTYPES_SQLCOMPAREOPTIONS is
		external
			"IL enum signature :System.Data.SqlTypes.SqlCompareOptions use System.Data.SqlTypes.SqlCompareOptions"
		alias
			"16"
		end

	frozen ignore_kana_type: SYSTEM_DATA_SQLTYPES_SQLCOMPAREOPTIONS is
		external
			"IL enum signature :System.Data.SqlTypes.SqlCompareOptions use System.Data.SqlTypes.SqlCompareOptions"
		alias
			"8"
		end

feature -- Basic Operations

	infix "|" (infix_arg: like Current): like Current is
		do
			--Built-in
		end

end -- class SYSTEM_DATA_SQLTYPES_SQLCOMPAREOPTIONS
