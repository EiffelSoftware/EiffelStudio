indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.DirectoryServices.ResultPropertyValueCollection"

external class
	SYSTEM_DIRECTORYSERVICES_RESULTPROPERTYVALUECOLLECTION

inherit
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			copy_to as icollection_copy_to,
			get_sync_root as icollection_get_sync_root,
			get_is_synchronized as icollection_get_is_synchronized
		end
	SYSTEM_COLLECTIONS_IENUMERABLE
	SYSTEM_COLLECTIONS_READONLYCOLLECTIONBASE

create {NONE}

feature -- Access

	frozen get_item (index: INTEGER): ANY is
		external
			"IL signature (System.Int32): System.Object use System.DirectoryServices.ResultPropertyValueCollection"
		alias
			"get_Item"
		end

feature -- Basic Operations

	frozen has (value: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.DirectoryServices.ResultPropertyValueCollection"
		alias
			"Contains"
		end

	frozen index_of (value: ANY): INTEGER is
		external
			"IL signature (System.Object): System.Int32 use System.DirectoryServices.ResultPropertyValueCollection"
		alias
			"IndexOf"
		end

	frozen copy_to (values: ARRAY [ANY]; index: INTEGER) is
		external
			"IL signature (System.Object[], System.Int32): System.Void use System.DirectoryServices.ResultPropertyValueCollection"
		alias
			"CopyTo"
		end

end -- class SYSTEM_DIRECTORYSERVICES_RESULTPROPERTYVALUECOLLECTION
