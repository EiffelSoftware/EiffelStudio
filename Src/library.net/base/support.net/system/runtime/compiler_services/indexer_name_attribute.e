indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Runtime.CompilerServices.IndexerNameAttribute"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	INDEXER_NAME_ATTRIBUTE

inherit
	ATTRIBUTE

create
	make_indexer_name_attribute

feature {NONE} -- Initialization

	frozen make_indexer_name_attribute (indexer_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Runtime.CompilerServices.IndexerNameAttribute"
		end

end -- class INDEXER_NAME_ATTRIBUTE
