indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Collections.Specialized.CollectionsUtil"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_COLLECTIONS_UTIL

inherit
	SYSTEM_OBJECT

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Collections.Specialized.CollectionsUtil"
		end

feature -- Basic Operations

	frozen create_case_insensitive_hashtable_int32 (capacity: INTEGER): HASHTABLE is
		external
			"IL static signature (System.Int32): System.Collections.Hashtable use System.Collections.Specialized.CollectionsUtil"
		alias
			"CreateCaseInsensitiveHashtable"
		end

	frozen create_case_insensitive_sorted_list: SYSTEM_SORTED_LIST is
		external
			"IL static signature (): System.Collections.SortedList use System.Collections.Specialized.CollectionsUtil"
		alias
			"CreateCaseInsensitiveSortedList"
		end

	frozen create_case_insensitive_hashtable_idictionary (d: IDICTIONARY): HASHTABLE is
		external
			"IL static signature (System.Collections.IDictionary): System.Collections.Hashtable use System.Collections.Specialized.CollectionsUtil"
		alias
			"CreateCaseInsensitiveHashtable"
		end

	frozen create_case_insensitive_hashtable: HASHTABLE is
		external
			"IL static signature (): System.Collections.Hashtable use System.Collections.Specialized.CollectionsUtil"
		alias
			"CreateCaseInsensitiveHashtable"
		end

end -- class SYSTEM_DLL_COLLECTIONS_UTIL
