indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.DirectoryServices.DirectoryEntries"

external class
	SYSTEM_DIRECTORYSERVICES_DIRECTORYENTRIES

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_COLLECTIONS_IENUMERABLE

create {NONE}

feature -- Access

	frozen get_schema_filter: SYSTEM_DIRECTORYSERVICES_SCHEMANAMECOLLECTION is
		external
			"IL signature (): System.DirectoryServices.SchemaNameCollection use System.DirectoryServices.DirectoryEntries"
		alias
			"get_SchemaFilter"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.DirectoryServices.DirectoryEntries"
		alias
			"ToString"
		end

	frozen add (name: STRING; schema_class_name: STRING): SYSTEM_DIRECTORYSERVICES_DIRECTORYENTRY is
		external
			"IL signature (System.String, System.String): System.DirectoryServices.DirectoryEntry use System.DirectoryServices.DirectoryEntries"
		alias
			"Add"
		end

	frozen find_string_string (name: STRING; schema_class_name: STRING): SYSTEM_DIRECTORYSERVICES_DIRECTORYENTRY is
		external
			"IL signature (System.String, System.String): System.DirectoryServices.DirectoryEntry use System.DirectoryServices.DirectoryEntries"
		alias
			"Find"
		end

	frozen get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.DirectoryServices.DirectoryEntries"
		alias
			"GetEnumerator"
		end

	frozen find (name: STRING): SYSTEM_DIRECTORYSERVICES_DIRECTORYENTRY is
		external
			"IL signature (System.String): System.DirectoryServices.DirectoryEntry use System.DirectoryServices.DirectoryEntries"
		alias
			"Find"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.DirectoryServices.DirectoryEntries"
		alias
			"Equals"
		end

	frozen remove (entry: SYSTEM_DIRECTORYSERVICES_DIRECTORYENTRY) is
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

end -- class SYSTEM_DIRECTORYSERVICES_DIRECTORYENTRIES
