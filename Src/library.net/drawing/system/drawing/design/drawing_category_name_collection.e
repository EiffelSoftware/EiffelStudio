indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Design.CategoryNameCollection"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	DRAWING_CATEGORY_NAME_COLLECTION

inherit
	READ_ONLY_COLLECTION_BASE
	ICOLLECTION
		rename
			copy_to as system_collections_icollection_copy_to,
			get_sync_root as system_collections_icollection_get_sync_root,
			get_is_synchronized as system_collections_icollection_get_is_synchronized
		end
	IENUMERABLE

create
	make_drawing_category_name_collection_1,
	make_drawing_category_name_collection

feature {NONE} -- Initialization

	frozen make_drawing_category_name_collection_1 (value: NATIVE_ARRAY [SYSTEM_STRING]) is
		external
			"IL creator signature (System.String[]) use System.Drawing.Design.CategoryNameCollection"
		end

	frozen make_drawing_category_name_collection (value: DRAWING_CATEGORY_NAME_COLLECTION) is
		external
			"IL creator signature (System.Drawing.Design.CategoryNameCollection) use System.Drawing.Design.CategoryNameCollection"
		end

feature -- Access

	frozen get_item (index: INTEGER): SYSTEM_STRING is
		external
			"IL signature (System.Int32): System.String use System.Drawing.Design.CategoryNameCollection"
		alias
			"get_Item"
		end

feature -- Basic Operations

	frozen contains (value: SYSTEM_STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.Drawing.Design.CategoryNameCollection"
		alias
			"Contains"
		end

	frozen index_of (value: SYSTEM_STRING): INTEGER is
		external
			"IL signature (System.String): System.Int32 use System.Drawing.Design.CategoryNameCollection"
		alias
			"IndexOf"
		end

	frozen copy_to (array: NATIVE_ARRAY [SYSTEM_STRING]; index: INTEGER) is
		external
			"IL signature (System.String[], System.Int32): System.Void use System.Drawing.Design.CategoryNameCollection"
		alias
			"CopyTo"
		end

end -- class DRAWING_CATEGORY_NAME_COLLECTION
