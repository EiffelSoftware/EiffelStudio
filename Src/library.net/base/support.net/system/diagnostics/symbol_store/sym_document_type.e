indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Diagnostics.SymbolStore.SymDocumentType"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYM_DOCUMENT_TYPE

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Diagnostics.SymbolStore.SymDocumentType"
		end

feature -- Access

	frozen text: GUID is
		external
			"IL static_field signature :System.Guid use System.Diagnostics.SymbolStore.SymDocumentType"
		alias
			"Text"
		end

end -- class SYM_DOCUMENT_TYPE
