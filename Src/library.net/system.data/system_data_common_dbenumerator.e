indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Data.Common.DbEnumerator"

external class
	SYSTEM_DATA_COMMON_DBENUMERATOR

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_COLLECTIONS_IENUMERATOR

create
	make

feature {NONE} -- Initialization

	frozen make (reader: SYSTEM_DATA_IDATAREADER) is
		external
			"IL creator signature (System.Data.IDataReader) use System.Data.Common.DbEnumerator"
		end

feature -- Access

	frozen get_current: ANY is
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

	to_string: STRING is
		external
			"IL signature (): System.String use System.Data.Common.DbEnumerator"
		alias
			"ToString"
		end

	is_equal (obj: ANY): BOOLEAN is
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

end -- class SYSTEM_DATA_COMMON_DBENUMERATOR
