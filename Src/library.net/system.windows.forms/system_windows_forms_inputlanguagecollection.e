indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.InputLanguageCollection"

external class
	SYSTEM_WINDOWS_FORMS_INPUTLANGUAGECOLLECTION

inherit
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			copy_to as system_collections_icollection_copy_to,
			get_sync_root as system_collections_icollection_get_sync_root,
			get_is_synchronized as system_collections_icollection_get_is_synchronized
		end
	SYSTEM_COLLECTIONS_IENUMERABLE
	SYSTEM_COLLECTIONS_READONLYCOLLECTIONBASE
		rename
			icollection_copy_to as system_collections_icollection_copy_to,
			icollection_get_sync_root as system_collections_icollection_get_sync_root,
			icollection_get_is_synchronized as system_collections_icollection_get_is_synchronized
		end

create {NONE}

feature -- Access

	frozen get_item (index: INTEGER): SYSTEM_WINDOWS_FORMS_INPUTLANGUAGE is
		external
			"IL signature (System.Int32): System.Windows.Forms.InputLanguage use System.Windows.Forms.InputLanguageCollection"
		alias
			"get_Item"
		end

feature -- Basic Operations

	frozen has (value: SYSTEM_WINDOWS_FORMS_INPUTLANGUAGE): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.InputLanguage): System.Boolean use System.Windows.Forms.InputLanguageCollection"
		alias
			"Contains"
		end

	frozen index_of (value: SYSTEM_WINDOWS_FORMS_INPUTLANGUAGE): INTEGER is
		external
			"IL signature (System.Windows.Forms.InputLanguage): System.Int32 use System.Windows.Forms.InputLanguageCollection"
		alias
			"IndexOf"
		end

	frozen copy_to (array: ARRAY [SYSTEM_WINDOWS_FORMS_INPUTLANGUAGE]; index: INTEGER) is
		external
			"IL signature (System.Windows.Forms.InputLanguage[], System.Int32): System.Void use System.Windows.Forms.InputLanguageCollection"
		alias
			"CopyTo"
		end

end -- class SYSTEM_WINDOWS_FORMS_INPUTLANGUAGECOLLECTION
