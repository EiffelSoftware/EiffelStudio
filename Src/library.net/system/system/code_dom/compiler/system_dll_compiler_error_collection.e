indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.CodeDom.Compiler.CompilerErrorCollection"
	assembly: "System", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	SYSTEM_DLL_COMPILER_ERROR_COLLECTION

inherit
	COLLECTION_BASE
	ILIST
		rename
			insert as system_collections_ilist_insert,
			index_of as system_collections_ilist_index_of,
			remove as system_collections_ilist_remove,
			add as system_collections_ilist_add,
			contains as system_collections_ilist_contains,
			set_item as system_collections_ilist_set_item,
			get_item as system_collections_ilist_get_item,
			copy_to as system_collections_icollection_copy_to,
			get_sync_root as system_collections_icollection_get_sync_root,
			get_is_synchronized as system_collections_icollection_get_is_synchronized,
			get_is_fixed_size as system_collections_ilist_get_is_fixed_size,
			get_is_read_only as system_collections_ilist_get_is_read_only
		end
	ICOLLECTION
		rename
			copy_to as system_collections_icollection_copy_to,
			get_sync_root as system_collections_icollection_get_sync_root,
			get_is_synchronized as system_collections_icollection_get_is_synchronized
		end
	IENUMERABLE

create
	make_system_dll_compiler_error_collection,
	make_system_dll_compiler_error_collection_1,
	make_system_dll_compiler_error_collection_2

feature {NONE} -- Initialization

	frozen make_system_dll_compiler_error_collection is
		external
			"IL creator use System.CodeDom.Compiler.CompilerErrorCollection"
		end

	frozen make_system_dll_compiler_error_collection_1 (value: SYSTEM_DLL_COMPILER_ERROR_COLLECTION) is
		external
			"IL creator signature (System.CodeDom.Compiler.CompilerErrorCollection) use System.CodeDom.Compiler.CompilerErrorCollection"
		end

	frozen make_system_dll_compiler_error_collection_2 (value: NATIVE_ARRAY [SYSTEM_DLL_COMPILER_ERROR]) is
		external
			"IL creator signature (System.CodeDom.Compiler.CompilerError[]) use System.CodeDom.Compiler.CompilerErrorCollection"
		end

feature -- Access

	frozen get_item (index: INTEGER): SYSTEM_DLL_COMPILER_ERROR is
		external
			"IL signature (System.Int32): System.CodeDom.Compiler.CompilerError use System.CodeDom.Compiler.CompilerErrorCollection"
		alias
			"get_Item"
		end

	frozen get_has_errors: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.CodeDom.Compiler.CompilerErrorCollection"
		alias
			"get_HasErrors"
		end

	frozen get_has_warnings: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.CodeDom.Compiler.CompilerErrorCollection"
		alias
			"get_HasWarnings"
		end

feature -- Element Change

	frozen set_item (index: INTEGER; value: SYSTEM_DLL_COMPILER_ERROR) is
		external
			"IL signature (System.Int32, System.CodeDom.Compiler.CompilerError): System.Void use System.CodeDom.Compiler.CompilerErrorCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	frozen insert (index: INTEGER; value: SYSTEM_DLL_COMPILER_ERROR) is
		external
			"IL signature (System.Int32, System.CodeDom.Compiler.CompilerError): System.Void use System.CodeDom.Compiler.CompilerErrorCollection"
		alias
			"Insert"
		end

	frozen copy_to (array: NATIVE_ARRAY [SYSTEM_DLL_COMPILER_ERROR]; index: INTEGER) is
		external
			"IL signature (System.CodeDom.Compiler.CompilerError[], System.Int32): System.Void use System.CodeDom.Compiler.CompilerErrorCollection"
		alias
			"CopyTo"
		end

	frozen index_of (value: SYSTEM_DLL_COMPILER_ERROR): INTEGER is
		external
			"IL signature (System.CodeDom.Compiler.CompilerError): System.Int32 use System.CodeDom.Compiler.CompilerErrorCollection"
		alias
			"IndexOf"
		end

	frozen remove (value: SYSTEM_DLL_COMPILER_ERROR) is
		external
			"IL signature (System.CodeDom.Compiler.CompilerError): System.Void use System.CodeDom.Compiler.CompilerErrorCollection"
		alias
			"Remove"
		end

	frozen contains (value: SYSTEM_DLL_COMPILER_ERROR): BOOLEAN is
		external
			"IL signature (System.CodeDom.Compiler.CompilerError): System.Boolean use System.CodeDom.Compiler.CompilerErrorCollection"
		alias
			"Contains"
		end

	frozen add_range (value: SYSTEM_DLL_COMPILER_ERROR_COLLECTION) is
		external
			"IL signature (System.CodeDom.Compiler.CompilerErrorCollection): System.Void use System.CodeDom.Compiler.CompilerErrorCollection"
		alias
			"AddRange"
		end

	frozen add (value: SYSTEM_DLL_COMPILER_ERROR): INTEGER is
		external
			"IL signature (System.CodeDom.Compiler.CompilerError): System.Int32 use System.CodeDom.Compiler.CompilerErrorCollection"
		alias
			"Add"
		end

	frozen add_range_array_compiler_error (value: NATIVE_ARRAY [SYSTEM_DLL_COMPILER_ERROR]) is
		external
			"IL signature (System.CodeDom.Compiler.CompilerError[]): System.Void use System.CodeDom.Compiler.CompilerErrorCollection"
		alias
			"AddRange"
		end

end -- class SYSTEM_DLL_COMPILER_ERROR_COLLECTION
