indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Design.ToolboxItemCollection"

frozen external class
	SYSTEM_DRAWING_DESIGN_TOOLBOXITEMCOLLECTION

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
	make_toolboxitemcollection_1,
	make_toolboxitemcollection

feature {NONE} -- Initialization

	frozen make_toolboxitemcollection_1 (value: ARRAY [SYSTEM_DRAWING_DESIGN_TOOLBOXITEM]) is
		external
			"IL creator signature (System.Drawing.Design.ToolboxItem[]) use System.Drawing.Design.ToolboxItemCollection"
		end

	frozen make_toolboxitemcollection (value: SYSTEM_DRAWING_DESIGN_TOOLBOXITEMCOLLECTION) is
		external
			"IL creator signature (System.Drawing.Design.ToolboxItemCollection) use System.Drawing.Design.ToolboxItemCollection"
		end

feature -- Access

	frozen get_item (index: INTEGER): SYSTEM_DRAWING_DESIGN_TOOLBOXITEM is
		external
			"IL signature (System.Int32): System.Drawing.Design.ToolboxItem use System.Drawing.Design.ToolboxItemCollection"
		alias
			"get_Item"
		end

feature -- Basic Operations

	frozen contains (value: SYSTEM_DRAWING_DESIGN_TOOLBOXITEM): BOOLEAN is
		external
			"IL signature (System.Drawing.Design.ToolboxItem): System.Boolean use System.Drawing.Design.ToolboxItemCollection"
		alias
			"Contains"
		end

	frozen index_of (value: SYSTEM_DRAWING_DESIGN_TOOLBOXITEM): INTEGER is
		external
			"IL signature (System.Drawing.Design.ToolboxItem): System.Int32 use System.Drawing.Design.ToolboxItemCollection"
		alias
			"IndexOf"
		end

	frozen copy_to (array: ARRAY [SYSTEM_DRAWING_DESIGN_TOOLBOXITEM]; index: INTEGER) is
		external
			"IL signature (System.Drawing.Design.ToolboxItem[], System.Int32): System.Void use System.Drawing.Design.ToolboxItemCollection"
		alias
			"CopyTo"
		end

end -- class SYSTEM_DRAWING_DESIGN_TOOLBOXITEMCOLLECTION
