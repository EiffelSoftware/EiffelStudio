indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Data.Common.DbEnumerator"
	assembly: "System.Data", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	DATA_DB_ENUMERATOR

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	IENUMERATOR

create
	make,
	make_1

feature {NONE} -- Initialization

	frozen make (reader: DATA_IDATA_READER) is
		external
			"IL creator signature (System.Data.IDataReader) use System.Data.Common.DbEnumerator"
		end

	frozen make_1 (reader: DATA_IDATA_READER; close_reader: BOOLEAN) is
		external
			"IL creator signature (System.Data.IDataReader, System.Boolean) use System.Data.Common.DbEnumerator"
		end

feature -- Access

	frozen get_current: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Data.Common.DbEnumerator"
		alias
			"get_Current"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Data.Common.DbEnumerator"
		alias
			"GetHashCode"
		end

	frozen reset is
		external
			"IL signature (): System.Void use System.Data.Common.DbEnumerator"
		alias
			"Reset"
		end

	frozen move_next: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Data.Common.DbEnumerator"
		alias
			"MoveNext"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Data.Common.DbEnumerator"
		alias
			"ToString"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Data.Common.DbEnumerator"
		alias
			"Equals"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Data.Common.DbEnumerator"
		alias
			"Finalize"
		end

end -- class DATA_DB_ENUMERATOR
