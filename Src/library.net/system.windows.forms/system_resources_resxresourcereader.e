indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Resources.ResXResourceReader"

external class
	SYSTEM_RESOURCES_RESXRESOURCEREADER

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end
	SYSTEM_RESOURCES_IRESOURCEREADER
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator,
			dispose as system_idisposable_dispose
		end
	SYSTEM_IDISPOSABLE
		rename
			dispose as system_idisposable_dispose
		end
	SYSTEM_COLLECTIONS_IENUMERABLE
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator
		end

create
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_2 (reader: SYSTEM_IO_TEXTREADER) is
		external
			"IL creator signature (System.IO.TextReader) use System.Resources.ResXResourceReader"
		end

	frozen make (file_name: STRING) is
		external
			"IL creator signature (System.String) use System.Resources.ResXResourceReader"
		end

	frozen make_1 (stream: SYSTEM_IO_STREAM) is
		external
			"IL creator signature (System.IO.Stream) use System.Resources.ResXResourceReader"
		end

feature -- Basic Operations

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Resources.ResXResourceReader"
		alias
			"GetHashCode"
		end

	frozen get_dictionary_enumerator: SYSTEM_COLLECTIONS_IDICTIONARYENUMERATOR is
		external
			"IL signature (): System.Collections.IDictionaryEnumerator use System.Resources.ResXResourceReader"
		alias
			"GetEnumerator"
		end

	to_string: STRING is
		external
			"IL signature (): System.String use System.Resources.ResXResourceReader"
		alias
			"ToString"
		end

	frozen from_file_contents (file_contents: STRING): SYSTEM_RESOURCES_RESXRESOURCEREADER is
		external
			"IL static signature (System.String): System.Resources.ResXResourceReader use System.Resources.ResXResourceReader"
		alias
			"FromFileContents"
		end

	is_equal (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Resources.ResXResourceReader"
		alias
			"Equals"
		end

	frozen close is
		external
			"IL signature (): System.Void use System.Resources.ResXResourceReader"
		alias
			"Close"
		end

feature {NONE} -- Implementation

	dispose (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Resources.ResXResourceReader"
		alias
			"Dispose"
		end

	finalize is
		external
			"IL signature (): System.Void use System.Resources.ResXResourceReader"
		alias
			"Finalize"
		end

	frozen system_idisposable_dispose is
		external
			"IL signature (): System.Void use System.Resources.ResXResourceReader"
		alias
			"System.IDisposable.Dispose"
		end

	frozen system_collections_ienumerable_get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Resources.ResXResourceReader"
		alias
			"System.Collections.IEnumerable.GetEnumerator"
		end

end -- class SYSTEM_RESOURCES_RESXRESOURCEREADER
