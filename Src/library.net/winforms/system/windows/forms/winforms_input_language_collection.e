indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.InputLanguageCollection"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_INPUT_LANGUAGE_COLLECTION

inherit
	READ_ONLY_COLLECTION_BASE
	ICOLLECTION
		rename
			copy_to as system_collections_icollection_copy_to,
			get_sync_root as system_collections_icollection_get_sync_root,
			get_is_synchronized as system_collections_icollection_get_is_synchronized
		end
	IENUMERABLE

create {NONE}

feature -- Access

	frozen get_item (index: INTEGER): WINFORMS_INPUT_LANGUAGE is
		external
			"IL signature (System.Int32): System.Windows.Forms.InputLanguage use System.Windows.Forms.InputLanguageCollection"
		alias
			"get_Item"
		end

feature -- Basic Operations

	frozen contains (value: WINFORMS_INPUT_LANGUAGE): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.InputLanguage): System.Boolean use System.Windows.Forms.InputLanguageCollection"
		alias
			"Contains"
		end

	frozen index_of (value: WINFORMS_INPUT_LANGUAGE): INTEGER is
		external
			"IL signature (System.Windows.Forms.InputLanguage): System.Int32 use System.Windows.Forms.InputLanguageCollection"
		alias
			"IndexOf"
		end

	frozen copy_to (array: NATIVE_ARRAY [WINFORMS_INPUT_LANGUAGE]; index: INTEGER) is
		external
			"IL signature (System.Windows.Forms.InputLanguage[], System.Int32): System.Void use System.Windows.Forms.InputLanguageCollection"
		alias
			"CopyTo"
		end

end -- class WINFORMS_INPUT_LANGUAGE_COLLECTION
