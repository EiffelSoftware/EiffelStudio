indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Web.UI.ValidatorCollection"
	assembly: "System.Web", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	WEB_VALIDATOR_COLLECTION

inherit
	SYSTEM_OBJECT
		redefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end
	ICOLLECTION
	IENUMERABLE

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

	frozen get_item (index: INTEGER): WEB_IVALIDATOR is
		external
			"IL signature (System.Int32): System.Web.UI.IValidator use System.Web.UI.ValidatorCollection"
		alias
			"get_Item"
		end

	frozen get_sync_root: SYSTEM_OBJECT is
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

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Web.UI.ValidatorCollection"
		alias
			"ToString"
		end

	frozen add (validator: WEB_IVALIDATOR) is
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

	frozen get_enumerator: IENUMERATOR is
		external
			"IL signature (): System.Collections.IEnumerator use System.Web.UI.ValidatorCollection"
		alias
			"GetEnumerator"
		end

	frozen remove (validator: WEB_IVALIDATOR) is
		external
			"IL signature (System.Web.UI.IValidator): System.Void use System.Web.UI.ValidatorCollection"
		alias
			"Remove"
		end

	frozen contains (validator: WEB_IVALIDATOR): BOOLEAN is
		external
			"IL signature (System.Web.UI.IValidator): System.Boolean use System.Web.UI.ValidatorCollection"
		alias
			"Contains"
		end

	equals (obj: SYSTEM_OBJECT): BOOLEAN is
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

end -- class WEB_VALIDATOR_COLLECTION
