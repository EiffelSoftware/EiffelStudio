indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Drawing.Design.IToolboxService"
	assembly: "System.Drawing", "1.0.3300.0", "neutral", "b03f5f7f11d5a3a"

deferred external class
	DRAWING_ITOOLBOX_SERVICE

inherit
	SYSTEM_OBJECT
		undefine
			finalize,
			get_hash_code,
			equals,
			to_string
		end

feature -- Access

	get_category_names: DRAWING_CATEGORY_NAME_COLLECTION is
		external
			"IL deferred signature (): System.Drawing.Design.CategoryNameCollection use System.Drawing.Design.IToolboxService"
		alias
			"get_CategoryNames"
		end

	get_selected_category: SYSTEM_STRING is
		external
			"IL deferred signature (): System.String use System.Drawing.Design.IToolboxService"
		alias
			"get_SelectedCategory"
		end

feature -- Element Change

	set_selected_category (value: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Drawing.Design.IToolboxService"
		alias
			"set_SelectedCategory"
		end

feature -- Basic Operations

	set_selected_toolbox_item (toolbox_item: DRAWING_TOOLBOX_ITEM) is
		external
			"IL deferred signature (System.Drawing.Design.ToolboxItem): System.Void use System.Drawing.Design.IToolboxService"
		alias
			"SetSelectedToolboxItem"
		end

	get_toolbox_items: DRAWING_TOOLBOX_ITEM_COLLECTION is
		external
			"IL deferred signature (): System.Drawing.Design.ToolboxItemCollection use System.Drawing.Design.IToolboxService"
		alias
			"GetToolboxItems"
		end

	serialize_toolbox_item (toolbox_item: DRAWING_TOOLBOX_ITEM): SYSTEM_OBJECT is
		external
			"IL deferred signature (System.Drawing.Design.ToolboxItem): System.Object use System.Drawing.Design.IToolboxService"
		alias
			"SerializeToolboxItem"
		end

	is_toolbox_item_object_idesigner_host (serialized_object: SYSTEM_OBJECT; host: SYSTEM_DLL_IDESIGNER_HOST): BOOLEAN is
		external
			"IL deferred signature (System.Object, System.ComponentModel.Design.IDesignerHost): System.Boolean use System.Drawing.Design.IToolboxService"
		alias
			"IsToolboxItem"
		end

	get_toolbox_items_string_idesigner_host (category: SYSTEM_STRING; host: SYSTEM_DLL_IDESIGNER_HOST): DRAWING_TOOLBOX_ITEM_COLLECTION is
		external
			"IL deferred signature (System.String, System.ComponentModel.Design.IDesignerHost): System.Drawing.Design.ToolboxItemCollection use System.Drawing.Design.IToolboxService"
		alias
			"GetToolboxItems"
		end

	selected_toolbox_item_used is
		external
			"IL deferred signature (): System.Void use System.Drawing.Design.IToolboxService"
		alias
			"SelectedToolboxItemUsed"
		end

	add_linked_toolbox_item (toolbox_item: DRAWING_TOOLBOX_ITEM; host: SYSTEM_DLL_IDESIGNER_HOST) is
		external
			"IL deferred signature (System.Drawing.Design.ToolboxItem, System.ComponentModel.Design.IDesignerHost): System.Void use System.Drawing.Design.IToolboxService"
		alias
			"AddLinkedToolboxItem"
		end

	remove_toolbox_item_toolbox_item_string (toolbox_item: DRAWING_TOOLBOX_ITEM; category: SYSTEM_STRING) is
		external
			"IL deferred signature (System.Drawing.Design.ToolboxItem, System.String): System.Void use System.Drawing.Design.IToolboxService"
		alias
			"RemoveToolboxItem"
		end

	get_toolbox_items_string (category: SYSTEM_STRING): DRAWING_TOOLBOX_ITEM_COLLECTION is
		external
			"IL deferred signature (System.String): System.Drawing.Design.ToolboxItemCollection use System.Drawing.Design.IToolboxService"
		alias
			"GetToolboxItems"
		end

	add_toolbox_item (toolbox_item: DRAWING_TOOLBOX_ITEM) is
		external
			"IL deferred signature (System.Drawing.Design.ToolboxItem): System.Void use System.Drawing.Design.IToolboxService"
		alias
			"AddToolboxItem"
		end

	remove_toolbox_item (toolbox_item: DRAWING_TOOLBOX_ITEM) is
		external
			"IL deferred signature (System.Drawing.Design.ToolboxItem): System.Void use System.Drawing.Design.IToolboxService"
		alias
			"RemoveToolboxItem"
		end

	set_cursor: BOOLEAN is
		external
			"IL deferred signature (): System.Boolean use System.Drawing.Design.IToolboxService"
		alias
			"SetCursor"
		end

	add_toolbox_item_toolbox_item_string (toolbox_item: DRAWING_TOOLBOX_ITEM; category: SYSTEM_STRING) is
		external
			"IL deferred signature (System.Drawing.Design.ToolboxItem, System.String): System.Void use System.Drawing.Design.IToolboxService"
		alias
			"AddToolboxItem"
		end

	get_selected_toolbox_item: DRAWING_TOOLBOX_ITEM is
		external
			"IL deferred signature (): System.Drawing.Design.ToolboxItem use System.Drawing.Design.IToolboxService"
		alias
			"GetSelectedToolboxItem"
		end

	refresh is
		external
			"IL deferred signature (): System.Void use System.Drawing.Design.IToolboxService"
		alias
			"Refresh"
		end

	deserialize_toolbox_item_object_idesigner_host (serialized_object: SYSTEM_OBJECT; host: SYSTEM_DLL_IDESIGNER_HOST): DRAWING_TOOLBOX_ITEM is
		external
			"IL deferred signature (System.Object, System.ComponentModel.Design.IDesignerHost): System.Drawing.Design.ToolboxItem use System.Drawing.Design.IToolboxService"
		alias
			"DeserializeToolboxItem"
		end

	add_creator_toolbox_item_creator_callback_string_idesigner_host (creator: DRAWING_TOOLBOX_ITEM_CREATOR_CALLBACK; format: SYSTEM_STRING; host: SYSTEM_DLL_IDESIGNER_HOST) is
		external
			"IL deferred signature (System.Drawing.Design.ToolboxItemCreatorCallback, System.String, System.ComponentModel.Design.IDesignerHost): System.Void use System.Drawing.Design.IToolboxService"
		alias
			"AddCreator"
		end

	is_toolbox_item (serialized_object: SYSTEM_OBJECT): BOOLEAN is
		external
			"IL deferred signature (System.Object): System.Boolean use System.Drawing.Design.IToolboxService"
		alias
			"IsToolboxItem"
		end

	deserialize_toolbox_item (serialized_object: SYSTEM_OBJECT): DRAWING_TOOLBOX_ITEM is
		external
			"IL deferred signature (System.Object): System.Drawing.Design.ToolboxItem use System.Drawing.Design.IToolboxService"
		alias
			"DeserializeToolboxItem"
		end

	add_creator (creator: DRAWING_TOOLBOX_ITEM_CREATOR_CALLBACK; format: SYSTEM_STRING) is
		external
			"IL deferred signature (System.Drawing.Design.ToolboxItemCreatorCallback, System.String): System.Void use System.Drawing.Design.IToolboxService"
		alias
			"AddCreator"
		end

	is_supported (serialized_object: SYSTEM_OBJECT; host: SYSTEM_DLL_IDESIGNER_HOST): BOOLEAN is
		external
			"IL deferred signature (System.Object, System.ComponentModel.Design.IDesignerHost): System.Boolean use System.Drawing.Design.IToolboxService"
		alias
			"IsSupported"
		end

	get_selected_toolbox_item_idesigner_host (host: SYSTEM_DLL_IDESIGNER_HOST): DRAWING_TOOLBOX_ITEM is
		external
			"IL deferred signature (System.ComponentModel.Design.IDesignerHost): System.Drawing.Design.ToolboxItem use System.Drawing.Design.IToolboxService"
		alias
			"GetSelectedToolboxItem"
		end

	remove_creator_string_idesigner_host (format: SYSTEM_STRING; host: SYSTEM_DLL_IDESIGNER_HOST) is
		external
			"IL deferred signature (System.String, System.ComponentModel.Design.IDesignerHost): System.Void use System.Drawing.Design.IToolboxService"
		alias
			"RemoveCreator"
		end

	add_linked_toolbox_item_toolbox_item_string (toolbox_item: DRAWING_TOOLBOX_ITEM; category: SYSTEM_STRING; host: SYSTEM_DLL_IDESIGNER_HOST) is
		external
			"IL deferred signature (System.Drawing.Design.ToolboxItem, System.String, System.ComponentModel.Design.IDesignerHost): System.Void use System.Drawing.Design.IToolboxService"
		alias
			"AddLinkedToolboxItem"
		end

	is_supported_object_icollection (serialized_object: SYSTEM_OBJECT; filter_attributes: ICOLLECTION): BOOLEAN is
		external
			"IL deferred signature (System.Object, System.Collections.ICollection): System.Boolean use System.Drawing.Design.IToolboxService"
		alias
			"IsSupported"
		end

	remove_creator (format: SYSTEM_STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Drawing.Design.IToolboxService"
		alias
			"RemoveCreator"
		end

	get_toolbox_items_idesigner_host (host: SYSTEM_DLL_IDESIGNER_HOST): DRAWING_TOOLBOX_ITEM_COLLECTION is
		external
			"IL deferred signature (System.ComponentModel.Design.IDesignerHost): System.Drawing.Design.ToolboxItemCollection use System.Drawing.Design.IToolboxService"
		alias
			"GetToolboxItems"
		end

end -- class DRAWING_ITOOLBOX_SERVICE
