indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.FillErrorEventArgs"

external class
	SYSTEM_DATA_FILLERROREVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_fillerroreventargs

feature {NONE} -- Initialization

	frozen make_fillerroreventargs (data_table: SYSTEM_DATA_DATATABLE; values: ARRAY [ANY]) is
		external
			"IL creator signature (System.Data.DataTable, System.Object[]) use System.Data.FillErrorEventArgs"
		end

feature -- Access

	frozen get_errors: SYSTEM_EXCEPTION is
		external
			"IL signature (): System.Exception use System.Data.FillErrorEventArgs"
		alias
			"get_Errors"
		end

	frozen get_values: ARRAY [ANY] is
		external
			"IL signature (): System.Object[] use System.Data.FillErrorEventArgs"
		alias
			"get_Values"
		end

	frozen get_data_table: SYSTEM_DATA_DATATABLE is
		external
			"IL signature (): System.Data.DataTable use System.Data.FillErrorEventArgs"
		alias
			"get_DataTable"
		end

	frozen get_continue: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.FillErrorEventArgs"
		alias
			"get_Continue"
		end

feature -- Element Change

	frozen set_continue (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Data.FillErrorEventArgs"
		alias
			"set_Continue"
		end

	frozen set_errors (value: SYSTEM_EXCEPTION) is
		external
			"IL signature (System.Exception): System.Void use System.Data.FillErrorEventArgs"
		alias
			"set_Errors"
		end

end -- class SYSTEM_DATA_FILLERROREVENTARGS
