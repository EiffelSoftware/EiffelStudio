indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.DirectoryServices.DirectoryEntries"
	assembly: "System.DirectoryServices", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

external class
	DIR_SERV_DIRECTORY_ENTRIES

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	IENUMERABLE

create {NONE}

feature -- Access

	frozen get_schema_filter: DIR_SERV_SCHEMA_NAME_COLLECTION is
		external
			"IL signature (): System.DirectoryServices.SchemaNameCollection use System.DirectoryServices.DirectoryEntries"
		alias
			"get_SchemaFilter"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.DirectoryServices.DirectoryEntries"
		alias
			"ToString"
		end

	frozen add (name: SYSTEM_STRING; schema_class_name: SYSTEM_STRING): DIR_SERV_DIRECTORY_ENTRY is
		external
			"IL signature (System.String, System.String): System.DirectoryServices.DirectoryEntry use System.DirectoryServices.DirectoryEntries"
		alias
			"Add"
		end

	frozen find_string_string (name: SYSTEM_STRING; schema_class_name: SYSTEM_STRING): DIR_SERV_DIRECTORY_ENTRY is
		external
			"IL signature (System.String, System.String): System.DirectoryServices.DirectoryEntry use System.DirectoryServices.DirectoryEntries"
		alias
			"Find"
		end

	frozen get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.DirectoryServices.DirectoryEntries"
		alias
			"GetEnumerator"
		end

	frozen find (name: SYSTEM_STRING): DIR_SERV_DIRECTORY_ENTRY is
		external
			"IL signature (System.String): System.DirectoryServices.DirectoryEntry use System.DirectoryServices.DirectoryEntries"
		alias
			"Find"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.DirectoryServices.DirectoryEntries"
		alias
			"Equals"
		end

	frozen remove (entry: DIR_SERV_DIRECTORY_ENTRY) is
		external
			"IL signature (System.DirectoryServices.DirectoryEntry): System.Void use System.DirectoryServices.DirectoryEntries"
		alias
			"Remove"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.DirectoryServices.DirectoryEntries"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.DirectoryServices.DirectoryEntries"
		alias
			"Finalize"
		end

end -- class DIR_SERV_DIRECTORY_ENTRIES
