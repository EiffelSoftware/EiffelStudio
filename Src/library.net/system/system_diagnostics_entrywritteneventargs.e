indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Diagnostics.EntryWrittenEventArgs"

external class
	SYSTEM_DIAGNOSTICS_ENTRYWRITTENEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_entrywritteneventargs_1,
	make_entrywritteneventargs

feature {NONE} -- Initialization

	frozen make_entrywritteneventargs_1 (entry: SYSTEM_DIAGNOSTICS_EVENTLOGENTRY) is
		external
			"IL creator signature (System.Diagnostics.EventLogEntry) use System.Diagnostics.EntryWrittenEventArgs"
		end

	frozen make_entrywritteneventargs is
		external
			"IL creator use System.Diagnostics.EntryWrittenEventArgs"
		end

feature -- Access

	frozen get_entry: SYSTEM_DIAGNOSTICS_EVENTLOGENTRY is
		external
			"IL signature (): System.Diagnostics.EventLogEntry use System.Diagnostics.EntryWrittenEventArgs"
		alias
			"get_Entry"
		end

end -- class SYSTEM_DIAGNOSTICS_ENTRYWRITTENEVENTARGS
