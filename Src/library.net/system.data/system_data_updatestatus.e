indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.UpdateStatus"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DATA_UPDATESTATUS

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

	frozen skip_all_remaining_rows: SYSTEM_DATA_UPDATESTATUS is
		external
			"IL enum signature :System.Data.UpdateStatus use System.Data.UpdateStatus"
		alias
			"3"
		end

	frozen errors_occurred: SYSTEM_DATA_UPDATESTATUS is
		external
			"IL enum signature :System.Data.UpdateStatus use System.Data.UpdateStatus"
		alias
			"1"
		end

	frozen continue: SYSTEM_DATA_UPDATESTATUS is
		external
			"IL enum signature :System.Data.UpdateStatus use System.Data.UpdateStatus"
		alias
			"0"
		end

	frozen skip_current_row: SYSTEM_DATA_UPDATESTATUS is
		external
			"IL enum signature :System.Data.UpdateStatus use System.Data.UpdateStatus"
		alias
			"2"
		end

end -- class SYSTEM_DATA_UPDATESTATUS
