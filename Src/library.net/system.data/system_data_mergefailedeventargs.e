indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.MergeFailedEventArgs"

external class
	SYSTEM_DATA_MERGEFAILEDEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_mergefailedeventargs

feature {NONE} -- Initialization

	frozen make_mergefailedeventargs (table: SYSTEM_DATA_DATATABLE; conflict: STRING) is
		external
			"IL creator signature (System.Data.DataTable, System.String) use System.Data.MergeFailedEventArgs"
		end

feature -- Access

	frozen get_table: SYSTEM_DATA_DATATABLE is
		external
			"IL signature (): System.Data.DataTable use System.Data.MergeFailedEventArgs"
		alias
			"get_Table"
		end

	frozen get_conflict: STRING is
		external
			"IL signature (): System.String use System.Data.MergeFailedEventArgs"
		alias
			"get_Conflict"
		end

end -- class SYSTEM_DATA_MERGEFAILEDEVENTARGS
