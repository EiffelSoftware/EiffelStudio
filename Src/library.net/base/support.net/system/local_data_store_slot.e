indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.LocalDataStoreSlot"
	assembly: "mscorlib", "1.0.3300.0", "neutral", "b77a5c561934e089"

frozen external class
	LOCAL_DATA_STORE_SLOT

inherit
	SYSTEM_OBJECT
		redefine
			finalize
		end

create {NONE}

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.LocalDataStoreSlot"
		alias
			"Finalize"
		end

end -- class LOCAL_DATA_STORE_SLOT
