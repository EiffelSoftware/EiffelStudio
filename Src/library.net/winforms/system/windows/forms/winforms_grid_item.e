indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.GridItem"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

deferred external class
	WINFORMS_GRID_ITEM

inherit
	SYSTEM_OBJECT

feature -- Access

	get_value: SYSTEM_OBJECT is
		external
			"IL deferred signature (): System.Object use System.Windows.Forms.GridItem"
		alias
			"get_Value"
		end

	get_property_descriptor: SYSTEM_DLL_PROPERTY_DESCRIPTOR is
		external
			"IL deferred signature (): System.ComponentModel.PropertyDescriptor use System.Windows.Forms.GridItem"
		alias
			"get_PropertyDescriptor"
		end

	get_grid_items: WINFORMS_GRID_ITEM_COLLECTION is
		external
			"IL deferred signature (): System.Windows.Forms.GridItemCollection use System.Windows.Forms.GridItem"
		alias
			"get_GridItems"
		end

	get_expanded: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.GridItem"
		alias
			"get_Expanded"
		end

	get_parent: WINFORMS_GRID_ITEM is
		external
			"IL deferred signature (): System.Windows.Forms.GridItem use System.Windows.Forms.GridItem"
		alias
			"get_Parent"
		end

	get_label: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.Windows.Forms.GridItem"
		alias
			"get_Label"
		end

	get_grid_item_type: WINFORMS_GRID_ITEM_TYPE is
		external
			"IL deferred signature (): System.Windows.Forms.GridItemType use System.Windows.Forms.GridItem"
		alias
			"get_GridItemType"
		end

	get_expandable: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.GridItem"
		alias
			"get_Expandable"
		end

feature -- Element Change

	set_expanded (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.GridItem"
		alias
			"set_Expanded"
		end

feature -- Basic Operations

	select_: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Windows.Forms.GridItem"
		alias
			"Select"
		end

end -- class WINFORMS_GRID_ITEM
