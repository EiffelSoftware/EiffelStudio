indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Web.UI.ValidatorCollection"

frozen external class
	SYSTEM_WEB_UI_VALIDATORCOLLECTION

inherit
	ANY
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	SYSTEM_COLLECTIONS_ICOLLECTION
	SYSTEM_COLLECTIONS_IENUMERABLE

create
	make

feature {NONE} -- Initialization

	frozen make is
		external
			"IL creator use System.Web.UI.ValidatorCollection"
		end

feature -- Access

	frozen get_is_synchronized: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.ValidatorCollection"
		alias
			"get_IsSynchronized"
		end

	frozen get_item (index: INTEGER): SYSTEM_WEB_UI_IVALIDATOR is
		external
			"IL signature (System.Int32): System.Web.UI.IValidator use System.Web.UI.ValidatorCollection"
		alias
			"get_Item"
		end

	frozen get_sync_root: ANY is
		external
			"IL signature (): System.Object use System.Web.UI.ValidatorCollection"
		alias
			"get_SyncRoot"
		end

	frozen get_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.ValidatorCollection"
		alias
			"get_Count"
		end

	frozen get_is_read_only: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Web.UI.ValidatorCollection"
		alias
			"get_IsReadOnly"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Web.UI.ValidatorCollection"
		alias
			"ToString"
		end

	frozen add (validator: SYSTEM_WEB_UI_IVALIDATOR) is
		external
			"IL signature (System.Web.UI.IValidator): System.Void use System.Web.UI.ValidatorCollection"
		alias
			"Add"
		end

	frozen copy_to (array: SYSTEM_ARRAY; index: INTEGER) is
		external
			"IL signature (System.Array, System.Int32): System.Void use System.Web.UI.ValidatorCollection"
		alias
			"CopyTo"
		end

	frozen get_enumerator: SYSTEM_COLLECTIONS_IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Web.UI.ValidatorCollection"
		alias
			"GetEnumerator"
		end

	frozen remove (validator: SYSTEM_WEB_UI_IVALIDATOR) is
		external
			"IL signature (System.Web.UI.IValidator): System.Void use System.Web.UI.ValidatorCollection"
		alias
			"Remove"
		end

	frozen contains (validator: SYSTEM_WEB_UI_IVALIDATOR): BOOLEAN is
		external
			"IL signature (System.Web.UI.IValidator): System.Boolean use System.Web.UI.ValidatorCollection"
		alias
			"Contains"
		end

	equals (obj: ANY): BOOLEAN is
		external
			"IL signature (System.Object): System.Boolean use System.Web.UI.ValidatorCollection"
		alias
			"Equals"
		end

	get_hash_code: INTEGER is
		external
			"IL signature (): System.Int32 use System.Web.UI.ValidatorCollection"
		alias
			"GetHashCode"
		end

feature {NONE} -- Implementation

	finalize is
		external
			"IL signature (): System.Void use System.Web.UI.ValidatorCollection"
		alias
			"Finalize"
		end

end -- class SYSTEM_WEB_UI_VALIDATORCOLLECTION
