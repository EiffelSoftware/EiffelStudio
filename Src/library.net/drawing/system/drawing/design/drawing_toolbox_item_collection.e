indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Design.ToolboxItemCollection"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

frozen external class
	DRAWING_TOOLBOX_ITEM_COLLECTION

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
	make_drawing_toolbox_item_collection_1,
	make_drawing_toolbox_item_collection

feature {NONE} -- Initialization

	frozen make_drawing_toolbox_item_collection_1 (value: NATIVE_ARRAY [DRAWING_TOOLBOX_ITEM]) is
		external
			"IL creator signature (System.Drawing.Design.ToolboxItem[]) use System.Drawing.Design.ToolboxItemCollection"
		end

	frozen make_drawing_toolbox_item_collection (value: DRAWING_TOOLBOX_ITEM_COLLECTION) is
		external
			"IL creator signature (System.Drawing.Design.ToolboxItemCollection) use System.Drawing.Design.ToolboxItemCollection"
		end

feature -- Access

	frozen get_item (index: INTEGER): DRAWING_TOOLBOX_ITEM is
		external
			"IL signature (System.Int32): System.Drawing.Design.ToolboxItem use System.Drawing.Design.ToolboxItemCollection"
		alias
			"get_Item"
		end

feature -- Basic Operations

	frozen contains (value: DRAWING_TOOLBOX_ITEM): BOOLEAN is
		external
			"IL signature (System.Drawing.Design.ToolboxItem): System.Boolean use System.Drawing.Design.ToolboxItemCollection"
		alias
			"Contains"
		end

	frozen index_of (value: DRAWING_TOOLBOX_ITEM): INTEGER is
		external
			"IL signature (System.Drawing.Design.ToolboxItem): System.Int32 use System.Drawing.Design.ToolboxItemCollection"
		alias
			"IndexOf"
		end

	frozen copy_to (array: NATIVE_ARRAY [DRAWING_TOOLBOX_ITEM]; index: INTEGER) is
		external
			"IL signature (System.Drawing.Design.ToolboxItem[], System.Int32): System.Void use System.Drawing.Design.ToolboxItemCollection"
		alias
			"CopyTo"
		end

end -- class DRAWING_TOOLBOX_ITEM_COLLECTION
