indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Drawing.Design.IToolboxService"

deferred external class
	SYSTEM_DRAWING_DESIGN_ITOOLBOXSERVICE

inherit
	ANY
		undefine
			finalize,
			get_hash_code,
			is_equal,
			to_string
		end

feature -- Access

	get_category_names: SYSTEM_DRAWING_DESIGN_CATEGORYNAMECOLLECTION is
		external
			"IL deferred signature (): System.Drawing.Design.CategoryNameCollection use System.Drawing.Design.IToolboxService"
		alias
			"get_CategoryNames"
		end

	get_selected_category: STRING is
		external
			"IL deferred signature (): System.String use System.Drawing.Design.IToolboxService"
		alias
			"get_SelectedCategory"
		end

feature -- Element Change

	set_selected_category (value: STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Drawing.Design.IToolboxService"
		alias
			"set_SelectedCategory"
		end

feature -- Basic Operations

	set_selected_toolbox_item (toolbox_item: SYSTEM_DRAWING_DESIGN_TOOLBOXITEM) is
		external
			"IL deferred signature (System.Drawing.Design.ToolboxItem): System.Void use System.Drawing.Design.IToolboxService"
		alias
			"SetSelectedToolboxItem"
		end

	get_toolbox_items: SYSTEM_DRAWING_DESIGN_TOOLBOXITEMCOLLECTION is
		external
			"IL deferred signature (): System.Drawing.Design.ToolboxItemCollection use System.Drawing.Design.IToolboxService"
		alias
			"GetToolboxItems"
		end

	serialize_toolbox_item (toolbox_item: SYSTEM_DRAWING_DESIGN_TOOLBOXITEM): ANY is
		external
			"IL deferred signature (System.Drawing.Design.ToolboxItem): System.Object use System.Drawing.Design.IToolboxService"
		alias
			"SerializeToolboxItem"
		end

	is_toolbox_item_object_idesigner_host (serialized_object: ANY; host: SYSTEM_COMPONENTMODEL_DESIGN_IDESIGNERHOST): BOOLEAN is
		external
			"IL deferred signature (System.Object, System.ComponentModel.Design.IDesignerHost): System.Boolean use System.Drawing.Design.IToolboxService"
		alias
			"IsToolboxItem"
		end

	get_toolbox_items_string_idesigner_host (category: STRING; host: SYSTEM_COMPONENTMODEL_DESIGN_IDESIGNERHOST): SYSTEM_DRAWING_DESIGN_TOOLBOXITEMCOLLECTION is
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

	add_linked_toolbox_item (toolbox_item: SYSTEM_DRAWING_DESIGN_TOOLBOXITEM; host: SYSTEM_COMPONENTMODEL_DESIGN_IDESIGNERHOST) is
		external
			"IL deferred signature (System.Drawing.Design.ToolboxItem, System.ComponentModel.Design.IDesignerHost): System.Void use System.Drawing.Design.IToolboxService"
		alias
			"AddLinkedToolboxItem"
		end

	remove_toolbox_item_toolbox_item_string (toolbox_item: SYSTEM_DRAWING_DESIGN_TOOLBOXITEM; category: STRING) is
		external
			"IL deferred signature (System.Drawing.Design.ToolboxItem, System.String): System.Void use System.Drawing.Design.IToolboxService"
		alias
			"RemoveToolboxItem"
		end

	get_toolbox_items_string (category: STRING): SYSTEM_DRAWING_DESIGN_TOOLBOXITEMCOLLECTION is
		external
			"IL deferred signature (System.String): System.Drawing.Design.ToolboxItemCollection use System.Drawing.Design.IToolboxService"
		alias
			"GetToolboxItems"
		end

	add_toolbox_item (toolbox_item: SYSTEM_DRAWING_DESIGN_TOOLBOXITEM) is
		external
			"IL deferred signature (System.Drawing.Design.ToolboxItem): System.Void use System.Drawing.Design.IToolboxService"
		alias
			"AddToolboxItem"
		end

	remove_toolbox_item (toolbox_item: SYSTEM_DRAWING_DESIGN_TOOLBOXITEM) is
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

	add_toolbox_item_toolbox_item_string (toolbox_item: SYSTEM_DRAWING_DESIGN_TOOLBOXITEM; category: STRING) is
		external
			"IL deferred signature (System.Drawing.Design.ToolboxItem, System.String): System.Void use System.Drawing.Design.IToolboxService"
		alias
			"AddToolboxItem"
		end

	get_selected_toolbox_item: SYSTEM_DRAWING_DESIGN_TOOLBOXITEM is
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

	deserialize_toolbox_item_object_idesigner_host (serialized_object: ANY; host: SYSTEM_COMPONENTMODEL_DESIGN_IDESIGNERHOST): SYSTEM_DRAWING_DESIGN_TOOLBOXITEM is
		external
			"IL deferred signature (System.Object, System.ComponentModel.Design.IDesignerHost): System.Drawing.Design.ToolboxItem use System.Drawing.Design.IToolboxService"
		alias
			"DeserializeToolboxItem"
		end

	add_creator_toolbox_item_creator_callback_string_idesigner_host (creator: SYSTEM_DRAWING_DESIGN_TOOLBOXITEMCREATORCALLBACK; format: STRING; host: SYSTEM_COMPONENTMODEL_DESIGN_IDESIGNERHOST) is
		external
			"IL deferred signature (System.Drawing.Design.ToolboxItemCreatorCallback, System.String, System.ComponentModel.Design.IDesignerHost): System.Void use System.Drawing.Design.IToolboxService"
		alias
			"AddCreator"
		end

	is_toolbox_item (serialized_object: ANY): BOOLEAN is
		external
			"IL deferred signature (System.Object): System.Boolean use System.Drawing.Design.IToolboxService"
		alias
			"IsToolboxItem"
		end

	deserialize_toolbox_item (serialized_object: ANY): SYSTEM_DRAWING_DESIGN_TOOLBOXITEM is
		external
			"IL deferred signature (System.Object): System.Drawing.Design.ToolboxItem use System.Drawing.Design.IToolboxService"
		alias
			"DeserializeToolboxItem"
		end

	add_creator (creator: SYSTEM_DRAWING_DESIGN_TOOLBOXITEMCREATORCALLBACK; format: STRING) is
		external
			"IL deferred signature (System.Drawing.Design.ToolboxItemCreatorCallback, System.String): System.Void use System.Drawing.Design.IToolboxService"
		alias
			"AddCreator"
		end

	is_supported (serialized_object: ANY; host: SYSTEM_COMPONENTMODEL_DESIGN_IDESIGNERHOST): BOOLEAN is
		external
			"IL deferred signature (System.Object, System.ComponentModel.Design.IDesignerHost): System.Boolean use System.Drawing.Design.IToolboxService"
		alias
			"IsSupported"
		end

	get_selected_toolbox_item_idesigner_host (host: SYSTEM_COMPONENTMODEL_DESIGN_IDESIGNERHOST): SYSTEM_DRAWING_DESIGN_TOOLBOXITEM is
		external
			"IL deferred signature (System.ComponentModel.Design.IDesignerHost): System.Drawing.Design.ToolboxItem use System.Drawing.Design.IToolboxService"
		alias
			"GetSelectedToolboxItem"
		end

	remove_creator_string_idesigner_host (format: STRING; host: SYSTEM_COMPONENTMODEL_DESIGN_IDESIGNERHOST) is
		external
			"IL deferred signature (System.String, System.ComponentModel.Design.IDesignerHost): System.Void use System.Drawing.Design.IToolboxService"
		alias
			"RemoveCreator"
		end

	add_linked_toolbox_item_toolbox_item_string (toolbox_item: SYSTEM_DRAWING_DESIGN_TOOLBOXITEM; category: STRING; host: SYSTEM_COMPONENTMODEL_DESIGN_IDESIGNERHOST) is
		external
			"IL deferred signature (System.Drawing.Design.ToolboxItem, System.String, System.ComponentModel.Design.IDesignerHost): System.Void use System.Drawing.Design.IToolboxService"
		alias
			"AddLinkedToolboxItem"
		end

	is_supported_object_icollection (serialized_object: ANY; filter_attributes: SYSTEM_COLLECTIONS_ICOLLECTION): BOOLEAN is
		external
			"IL deferred signature (System.Object, System.Collections.ICollection): System.Boolean use System.Drawing.Design.IToolboxService"
		alias
			"IsSupported"
		end

	remove_creator (format: STRING) is
		external
			"IL deferred signature (System.String): System.Void use System.Drawing.Design.IToolboxService"
		alias
			"RemoveCreator"
		end

	get_toolbox_items_idesigner_host (host: SYSTEM_COMPONENTMODEL_DESIGN_IDESIGNERHOST): SYSTEM_DRAWING_DESIGN_TOOLBOXITEMCOLLECTION is
		external
			"IL deferred signature (System.ComponentModel.Design.IDesignerHost): System.Drawing.Design.ToolboxItemCollection use System.Drawing.Design.IToolboxService"
		alias
			"GetToolboxItems"
		end

end -- class SYSTEM_DRAWING_DESIGN_ITOOLBOXSERVICE
