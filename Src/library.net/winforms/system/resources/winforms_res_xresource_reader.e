indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Resources.ResXResourceReader"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_RES_XRESOURCE_READER

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	IRESOURCE_READER
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator,
			dispose as system_idisposable_dispose
		end
	IENUMERABLE
		rename
			get_enumerator as system_collections_ienumerable_get_enumerator
		end
	IDISPOSABLE
		rename
			dispose as system_idisposable_dispose
		end

create
	make_5,
	make_4,
	make_3,
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_5 (reader: TEXT_READER; type_resolver: SYSTEM_DLL_ITYPE_RESOLUTION_SERVICE) is
		external
			"IL creator signature (System.IO.TextReader, System.ComponentModel.Design.ITypeResolutionService) use System.Resources.ResXResourceReader"
		end

	frozen make_4 (stream: SYSTEM_STREAM; type_resolver: SYSTEM_DLL_ITYPE_RESOLUTION_SERVICE) is
		external
			"IL creator signature (System.IO.Stream, System.ComponentModel.Design.ITypeResolutionService) use System.Resources.ResXResourceReader"
		end

	frozen make_3 (file_name: SYSTEM_STRING; type_resolver: SYSTEM_DLL_ITYPE_RESOLUTION_SERVICE) is
		external
			"IL creator signature (System.String, System.ComponentModel.Design.ITypeResolutionService) use System.Resources.ResXResourceReader"
		end

	frozen make_2 (reader: TEXT_READER) is
		external
			"IL creator signature (System.IO.TextReader) use System.Resources.ResXResourceReader"
		end

	frozen make (file_name: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Resources.ResXResourceReader"
		end

	frozen make_1 (stream: SYSTEM_STREAM) is
		external
			"IL creator signature (System.IO.Stream) use System.Resources.ResXResourceReader"
		end

feature -- Basic Operations

	frozen from_file_contents_string_itype_resolution_service (file_contents: SYSTEM_STRING; type_resolver: SYSTEM_DLL_ITYPE_RESOLUTION_SERVICE): WINFORMS_RES_XRESOURCE_READER is
		external
			"IL static signature (System.String, System.ComponentModel.Design.ITypeResolutionService): System.Resources.ResXResourceReader use System.Resources.ResXResourceReader"
		alias
			"FromFileContents"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Resources.ResXResourceReader"
		alias
			"GetHashCode"
		end

	frozen get_enumerator_idictionary_enumerator: IDICTIONARY_ENUMERATOR is
		external
			"IL signature (): System.Collections.IDictionaryEnumerator use System.Resources.ResXResourceReader"
		alias
			"GetEnumerator"
		end

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Resources.ResXResourceReader"
		alias
			"ToString"
		end

	frozen from_file_contents (file_contents: SYSTEM_STRING): WINFORMS_RES_XRESOURCE_READER is
		external
			"IL static signature (System.String): System.Resources.ResXResourceReader use System.Resources.ResXResourceReader"
		alias
			"FromFileContents"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
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

	frozen system_collections_ienumerable_get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Resources.ResXResourceReader"
		alias
			"System.Collections.IEnumerable.GetEnumerator"
		end

end -- class WINFORMS_RES_XRESOURCE_READER
