indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.UpdateStatus"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"
	enum_type: "INTEGER"

frozen expanded external class
	DATA_UPDATE_STATUS

inherit
	ENUM
	ICOMPARABLE
	IFORMATTABLE

feature -- Access

	frozen skip_all_remaining_rows: DATA_UPDATE_STATUS is
		external
			"IL enum signature :System.Data.UpdateStatus use System.Data.UpdateStatus"
		alias
			"3"
		end

	frozen errors_occurred: DATA_UPDATE_STATUS is
		external
			"IL enum signature :System.Data.UpdateStatus use System.Data.UpdateStatus"
		alias
			"1"
		end

	frozen continue: DATA_UPDATE_STATUS is
		external
			"IL enum signature :System.Data.UpdateStatus use System.Data.UpdateStatus"
		alias
			"0"
		end

	frozen skip_current_row: DATA_UPDATE_STATUS is
		external
			"IL enum signature :System.Data.UpdateStatus use System.Data.UpdateStatus"
		alias
			"2"
		end

end -- class DATA_UPDATE_STATUS
