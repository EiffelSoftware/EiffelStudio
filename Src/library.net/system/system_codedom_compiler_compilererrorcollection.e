indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.CodeDom.Compiler.CompilerErrorCollection"

external class
	SYSTEM_CODEDOM_COMPILER_COMPILERERRORCOLLECTION

inherit
	SYSTEM_COLLECTIONS_ILIST
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
	SYSTEM_COLLECTIONS_COLLECTIONBASE
	SYSTEM_COLLECTIONS_IENUMERABLE
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			copy_to as system_collections_icollection_copy_to,
			get_sync_root as system_collections_icollection_get_sync_root,
			get_is_synchronized as system_collections_icollection_get_is_synchronized
		end

create
	make_compilererrorcollection,
	make_compilererrorcollection_1,
	make_compilererrorcollection_2

feature {NONE} -- Initialization

	frozen make_compilererrorcollection is
		external
			"IL creator use System.CodeDom.Compiler.CompilerErrorCollection"
		end

	frozen make_compilererrorcollection_1 (value: SYSTEM_CODEDOM_COMPILER_COMPILERERRORCOLLECTION) is
		external
			"IL creator signature (System.CodeDom.Compiler.CompilerErrorCollection) use System.CodeDom.Compiler.CompilerErrorCollection"
		end

	frozen make_compilererrorcollection_2 (value: ARRAY [SYSTEM_CODEDOM_COMPILER_COMPILERERROR]) is
		external
			"IL creator signature (System.CodeDom.Compiler.CompilerError[]) use System.CodeDom.Compiler.CompilerErrorCollection"
		end

feature -- Access

	frozen get_item (index: INTEGER): SYSTEM_CODEDOM_COMPILER_COMPILERERROR is
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

	frozen set_item (index: INTEGER; value: SYSTEM_CODEDOM_COMPILER_COMPILERERROR) is
		external
			"IL signature (System.Int32, System.CodeDom.Compiler.CompilerError): System.Void use System.CodeDom.Compiler.CompilerErrorCollection"
		alias
			"set_Item"
		end

feature -- Basic Operations

	frozen insert (index: INTEGER; value: SYSTEM_CODEDOM_COMPILER_COMPILERERROR) is
		external
			"IL signature (System.Int32, System.CodeDom.Compiler.CompilerError): System.Void use System.CodeDom.Compiler.CompilerErrorCollection"
		alias
			"Insert"
		end

	frozen copy_to (array: ARRAY [SYSTEM_CODEDOM_COMPILER_COMPILERERROR]; index: INTEGER) is
		external
			"IL signature (System.CodeDom.Compiler.CompilerError[], System.Int32): System.Void use System.CodeDom.Compiler.CompilerErrorCollection"
		alias
			"CopyTo"
		end

	frozen index_of (value: SYSTEM_CODEDOM_COMPILER_COMPILERERROR): INTEGER is
		external
			"IL signature (System.CodeDom.Compiler.CompilerError): System.Int32 use System.CodeDom.Compiler.CompilerErrorCollection"
		alias
			"IndexOf"
		end

	frozen remove (value: SYSTEM_CODEDOM_COMPILER_COMPILERERROR) is
		external
			"IL signature (System.CodeDom.Compiler.CompilerError): System.Void use System.CodeDom.Compiler.CompilerErrorCollection"
		alias
			"Remove"
		end

	frozen contains (value: SYSTEM_CODEDOM_COMPILER_COMPILERERROR): BOOLEAN is
		external
			"IL signature (System.CodeDom.Compiler.CompilerError): System.Boolean use System.CodeDom.Compiler.CompilerErrorCollection"
		alias
			"Contains"
		end

	frozen add_range (value: SYSTEM_CODEDOM_COMPILER_COMPILERERRORCOLLECTION) is
		external
			"IL signature (System.CodeDom.Compiler.CompilerErrorCollection): System.Void use System.CodeDom.Compiler.CompilerErrorCollection"
		alias
			"AddRange"
		end

	frozen add (value: SYSTEM_CODEDOM_COMPILER_COMPILERERROR): INTEGER is
		external
			"IL signature (System.CodeDom.Compiler.CompilerError): System.Int32 use System.CodeDom.Compiler.CompilerErrorCollection"
		alias
			"Add"
		end

	frozen add_range_array_compiler_error (value: ARRAY [SYSTEM_CODEDOM_COMPILER_COMPILERERROR]) is
		external
			"IL signature (System.CodeDom.Compiler.CompilerError[]): System.Void use System.CodeDom.Compiler.CompilerErrorCollection"
		alias
			"AddRange"
		end

end -- class SYSTEM_CODEDOM_COMPILER_COMPILERERRORCOLLECTION
