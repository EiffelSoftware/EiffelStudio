indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.StringTrimming"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DRAWING_STRINGTRIMMING

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

	frozen character: SYSTEM_DRAWING_STRINGTRIMMING is
		external
			"IL enum signature :System.Drawing.StringTrimming use System.Drawing.StringTrimming"
		alias
			"1"
		end

	frozen ellipsis_word: SYSTEM_DRAWING_STRINGTRIMMING is
		external
			"IL enum signature :System.Drawing.StringTrimming use System.Drawing.StringTrimming"
		alias
			"4"
		end

	frozen word: SYSTEM_DRAWING_STRINGTRIMMING is
		external
			"IL enum signature :System.Drawing.StringTrimming use System.Drawing.StringTrimming"
		alias
			"2"
		end

	frozen ellipsis_path: SYSTEM_DRAWING_STRINGTRIMMING is
		external
			"IL enum signature :System.Drawing.StringTrimming use System.Drawing.StringTrimming"
		alias
			"5"
		end

	frozen none: SYSTEM_DRAWING_STRINGTRIMMING is
		external
			"IL enum signature :System.Drawing.StringTrimming use System.Drawing.StringTrimming"
		alias
			"0"
		end

	frozen ellipsis_character: SYSTEM_DRAWING_STRINGTRIMMING is
		external
			"IL enum signature :System.Drawing.StringTrimming use System.Drawing.StringTrimming"
		alias
			"3"
		end

end -- class SYSTEM_DRAWING_STRINGTRIMMING
