indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Design.CategoryNameCollection"

frozen external class
	SYSTEM_DRAWING_DESIGN_CATEGORYNAMECOLLECTION

inherit
	SYSTEM_COLLECTIONS_ICOLLECTION
		rename
			copy_to as system_collections_icollection_copy_to,
			get_sync_root as system_collections_icollection_get_sync_root,
			get_is_synchronized as system_collections_icollection_get_is_synchronized
		end
	SYSTEM_COLLECTIONS_IENUMERABLE
	SYSTEM_COLLECTIONS_READONLYCOLLECTIONBASE

create
	make_categorynamecollection_1,
	make_categorynamecollection

feature {NONE} -- Initialization

	frozen make_categorynamecollection_1 (value: ARRAY [STRING]) is
		external
			"IL creator signature (System.String[]) use System.Drawing.Design.CategoryNameCollection"
		end

	frozen make_categorynamecollection (value: SYSTEM_DRAWING_DESIGN_CATEGORYNAMECOLLECTION) is
		external
			"IL creator signature (System.Drawing.Design.CategoryNameCollection) use System.Drawing.Design.CategoryNameCollection"
		end

feature -- Access

	frozen get_item (index: INTEGER): STRING is
		external
			"IL signature (System.Int32): System.String use System.Drawing.Design.CategoryNameCollection"
		alias
			"get_Item"
		end

feature -- Basic Operations

	frozen contains (value: STRING): BOOLEAN is
		external
			"IL signature (System.String): System.Boolean use System.Drawing.Design.CategoryNameCollection"
		alias
			"Contains"
		end

	frozen index_of (value: STRING): INTEGER is
		external
			"IL signature (System.String): System.Int32 use System.Drawing.Design.CategoryNameCollection"
		alias
			"IndexOf"
		end

	frozen copy_to (array: ARRAY [STRING]; index: INTEGER) is
		external
			"IL signature (System.String[], System.Int32): System.Void use System.Drawing.Design.CategoryNameCollection"
		alias
			"CopyTo"
		end

end -- class SYSTEM_DRAWING_DESIGN_CATEGORYNAMECOLLECTION
