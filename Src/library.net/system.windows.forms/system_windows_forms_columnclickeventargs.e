indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.ColumnClickEventArgs"

external class
	SYSTEM_WINDOWS_FORMS_COLUMNCLICKEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_columnclickeventargs

feature {NONE} -- Initialization

	frozen make_columnclickeventargs (column: INTEGER) is
		external
			"IL creator signature (System.Int32) use System.Windows.Forms.ColumnClickEventArgs"
		end

feature -- Access

	frozen get_column: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.ColumnClickEventArgs"
		alias
			"get_Column"
		end

end -- class SYSTEM_WINDOWS_FORMS_COLUMNCLICKEVENTARGS
