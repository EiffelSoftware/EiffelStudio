indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Collections.Specialized.CollectionsUtil"

external class
	SYSTEM_COLLECTIONS_SPECIALIZED_COLLECTIONSUTIL

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Collections.Specialized.CollectionsUtil"
		end

feature -- Basic Operations

	frozen create_case_insensitive_hashtable_int32 (capacity: INTEGER): SYSTEM_COLLECTIONS_HASHTABLE is
		external
			"IL static signature (System.Int32): System.Collections.Hashtable use System.Collections.Specialized.CollectionsUtil"
		alias
			"CreateCaseInsensitiveHashtable"
		end

	frozen create_case_insensitive_sorted_list: SYSTEM_COLLECTIONS_SORTEDLIST is
		external
			"IL static signature (): System.Collections.SortedList use System.Collections.Specialized.CollectionsUtil"
		alias
			"CreateCaseInsensitiveSortedList"
		end

	frozen create_case_insensitive_hashtable_idictionary (d: SYSTEM_COLLECTIONS_IDICTIONARY): SYSTEM_COLLECTIONS_HASHTABLE is
		external
			"IL static signature (System.Collections.IDictionary): System.Collections.Hashtable use System.Collections.Specialized.CollectionsUtil"
		alias
			"CreateCaseInsensitiveHashtable"
		end

	frozen create_case_insensitive_hashtable: SYSTEM_COLLECTIONS_HASHTABLE is
		external
			"IL static signature (): System.Collections.Hashtable use System.Collections.Specialized.CollectionsUtil"
		alias
			"CreateCaseInsensitiveHashtable"
		end

end -- class SYSTEM_COLLECTIONS_SPECIALIZED_COLLECTIONSUTIL
