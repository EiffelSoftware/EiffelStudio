indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.ColumnHeaderStyle"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	WINFORMS_COLUMN_HEADER_STYLE

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen nonclickable: WINFORMS_COLUMN_HEADER_STYLE is
		external
			"IL enum signature :System.Windows.Forms.ColumnHeaderStyle use System.Windows.Forms.ColumnHeaderStyle"
		alias
			"1"
		end

	frozen clickable: WINFORMS_COLUMN_HEADER_STYLE is
		external
			"IL enum signature :System.Windows.Forms.ColumnHeaderStyle use System.Windows.Forms.ColumnHeaderStyle"
		alias
			"2"
		end

	frozen none: WINFORMS_COLUMN_HEADER_STYLE is
		external
			"IL enum signature :System.Windows.Forms.ColumnHeaderStyle use System.Windows.Forms.ColumnHeaderStyle"
		alias
			"0"
		end

end -- class WINFORMS_COLUMN_HEADER_STYLE
