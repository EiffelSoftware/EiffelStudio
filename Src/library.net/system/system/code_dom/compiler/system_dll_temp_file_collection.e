indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.Compiler.TempFileCollection"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_TEMP_FILE_COLLECTION

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ICOLLECTION
		rename
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			get_sync_root as system_collections_icollection_get_sync_root,
			get_count as system_collections_icollection_get_count,
			copy_to as system_collections_icollection_copy_to,
			get_enumerator as system_collections_ienumerable_get_enumerator
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
	make_2,
	make,
	make_1

feature {NONE} -- Initialization

	frozen make_2 (temp_dir: SYSTEM_STRING; keep_files: BOOLEAN) is
		external
			"IL creator signature (System.String, System.Boolean) use System.CodeDom.Compiler.TempFileCollection"
		end

	frozen make is
		external
			"IL creator use System.CodeDom.Compiler.TempFileCollection"
		end

	frozen make_1 (temp_dir: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.CodeDom.Compiler.TempFileCollection"
		end

feature -- Access

	frozen get_temp_dir: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.CodeDom.Compiler.TempFileCollection"
		alias
			"get_TempDir"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.CodeDom.Compiler.TempFileCollection"
		alias
			"get_Count"
		end

	frozen get_keep_files: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.CodeDom.Compiler.TempFileCollection"
		alias
			"get_KeepFiles"
		end

	frozen get_base_path: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.CodeDom.Compiler.TempFileCollection"
		alias
			"get_BasePath"
		end

feature -- Element Change

	frozen set_keep_files (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.CodeDom.Compiler.TempFileCollection"
		alias
			"set_KeepFiles"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.CodeDom.Compiler.TempFileCollection"
		alias
			"ToString"
		end

	frozen add_extension (file_extension: SYSTEM_STRING): SYSTEM_STRING is
		external
			"IL signature (System.String): System.String use System.CodeDom.Compiler.TempFileCollection"
		alias
			"AddExtension"
		end

	frozen add_extension_string_boolean (file_extension: SYSTEM_STRING; keep_file: BOOLEAN): SYSTEM_STRING is
		external
			"IL signature (System.String, System.Boolean): System.String use System.CodeDom.Compiler.TempFileCollection"
		alias
			"AddExtension"
		end

	frozen add_file (file_name: SYSTEM_STRING; keep_file: BOOLEAN) is
		external
			"IL signature (System.String, System.Boolean): System.Void use System.CodeDom.Compiler.TempFileCollection"
		alias
			"AddFile"
		end

	frozen copy_to (file_names: NATIVE_ARRAY [SYSTEM_STRING]; start: INTEGER) is
		external
			"IL signature (System.String[], System.Int32): System.Void use System.CodeDom.Compiler.TempFileCollection"
		alias
			"CopyTo"
		end

	frozen get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.CodeDom.Compiler.TempFileCollection"
		alias
			"GetEnumerator"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.CodeDom.Compiler.TempFileCollection"
		alias
			"Equals"
		end

	frozen delete is
		external
			"IL signature (): System.Void use System.CodeDom.Compiler.TempFileCollection"
		alias
			"Delete"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.CodeDom.Compiler.TempFileCollection"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	frozen system_collections_icollection_get_sync_root: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.CodeDom.Compiler.TempFileCollection"
		alias
			"System.Collections.ICollection.get_SyncRoot"
		end

	frozen system_collections_icollection_copy_to (array: SYSTEM_ARRAY; start: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.CodeDom.Compiler.TempFileCollection"
		alias
			"System.Collections.ICollection.CopyTo"
		end

	dispose (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.CodeDom.Compiler.TempFileCollection"
		alias
			"Dispose"
		end

	frozen system_collections_ienumerable_get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.CodeDom.Compiler.TempFileCollection"
		alias
			"System.Collections.IEnumerable.GetEnumerator"
		end

	frozen system_collections_icollection_get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.CodeDom.Compiler.TempFileCollection"
		alias
			"System.Collections.ICollection.get_IsSynchronized"
		end

	frozen system_collections_icollection_get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.CodeDom.Compiler.TempFileCollection"
		alias
			"System.Collections.ICollection.get_Count"
		end

	frozen system_idisposable_dispose is
		external
			"IL signature (): System.Void use System.CodeDom.Compiler.TempFileCollection"
		alias
			"System.IDisposable.Dispose"
		end

	finalize is
		external
			"IL signature (): System.Void use System.CodeDom.Compiler.TempFileCollection"
		alias
			"Finalize"
		end

end -- class SYSTEM_DLL_TEMP_FILE_COLLECTION
