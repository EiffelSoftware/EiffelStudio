indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Diagnostics.EventLogEntryType"
	enum_type: "INTEGER"

frozen expanded external class
	SYSTEM_DIAGNOSTICS_EVENTLOGENTRYTYPE

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

	frozen success_audit: SYSTEM_DIAGNOSTICS_EVENTLOGENTRYTYPE is
		external
			"IL enum signature :System.Diagnostics.EventLogEntryType use System.Diagnostics.EventLogEntryType"
		alias
			"8"
		end

	frozen information: SYSTEM_DIAGNOSTICS_EVENTLOGENTRYTYPE is
		external
			"IL enum signature :System.Diagnostics.EventLogEntryType use System.Diagnostics.EventLogEntryType"
		alias
			"4"
		end

	frozen error: SYSTEM_DIAGNOSTICS_EVENTLOGENTRYTYPE is
		external
			"IL enum signature :System.Diagnostics.EventLogEntryType use System.Diagnostics.EventLogEntryType"
		alias
			"1"
		end

	frozen warning: SYSTEM_DIAGNOSTICS_EVENTLOGENTRYTYPE is
		external
			"IL enum signature :System.Diagnostics.EventLogEntryType use System.Diagnostics.EventLogEntryType"
		alias
			"2"
		end

	frozen failure_audit: SYSTEM_DIAGNOSTICS_EVENTLOGENTRYTYPE is
		external
			"IL enum signature :System.Diagnostics.EventLogEntryType use System.Diagnostics.EventLogEntryType"
		alias
			"16"
		end

end -- class SYSTEM_DIAGNOSTICS_EVENTLOGENTRYTYPE
