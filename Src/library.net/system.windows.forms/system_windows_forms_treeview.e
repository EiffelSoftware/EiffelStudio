indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.TreeView"

external class
	SYSTEM_WINDOWS_FORMS_TREEVIEW

inherit
	SYSTEM_COMPONENTMODEL_ICOMPONENT
	SYSTEM_COMPONENTMODEL_ISYNCHRONIZEINVOKE
		rename
			invoke as invoke_delegate_array_object,
			begin_invoke as begin_invoke_delegate_array_object
		end
	SYSTEM_IDISPOSABLE
	SYSTEM_WINDOWS_FORMS_CONTROL
		redefine
			wnd_proc,
			on_key_up,
			on_key_press,
			on_key_down,
			on_handle_destroyed,
			on_handle_created,
			is_input_key,
			create_handle,
			set_text,
			get_text,
			set_fore_color,
			get_fore_color,
			get_default_size,
			get_create_params,
			set_background_image,
			get_background_image,
			set_back_color,
			get_back_color,
			dispose_boolean,
			to_string
		end
	SYSTEM_WINDOWS_FORMS_IWIN32WINDOW

create
	make_treeview

feature {NONE} -- Initialization

	frozen make_treeview is
		external
			"IL creator use System.Windows.Forms.TreeView"
		end

feature -- Access

	frozen get_hot_tracking: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.TreeView"
		alias
			"get_HotTracking"
		end

	frozen get_sorted: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.TreeView"
		alias
			"get_Sorted"
		end

	frozen get_item_height: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.TreeView"
		alias
			"get_ItemHeight"
		end

	get_text: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.TreeView"
		alias
			"get_Text"
		end

	frozen get_scrollable: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.TreeView"
		alias
			"get_Scrollable"
		end

	frozen get_label_edit: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.TreeView"
		alias
			"get_LabelEdit"
		end

	frozen get_top_node: SYSTEM_WINDOWS_FORMS_TREENODE is
		external
			"IL signature (): System.Windows.Forms.TreeNode use System.Windows.Forms.TreeView"
		alias
			"get_TopNode"
		end

	frozen get_indent: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.TreeView"
		alias
			"get_Indent"
		end

	frozen get_border_style: SYSTEM_WINDOWS_FORMS_BORDERSTYLE is
		external
			"IL signature (): System.Windows.Forms.BorderStyle use System.Windows.Forms.TreeView"
		alias
			"get_BorderStyle"
		end

	frozen get_image_list: SYSTEM_WINDOWS_FORMS_IMAGELIST is
		external
			"IL signature (): System.Windows.Forms.ImageList use System.Windows.Forms.TreeView"
		alias
			"get_ImageList"
		end

	frozen get_full_row_select: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.TreeView"
		alias
			"get_FullRowSelect"
		end

	frozen get_image_index: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.TreeView"
		alias
			"get_ImageIndex"
		end

	frozen get_nodes: SYSTEM_WINDOWS_FORMS_TREENODECOLLECTION is
		external
			"IL signature (): System.Windows.Forms.TreeNodeCollection use System.Windows.Forms.TreeView"
		alias
			"get_Nodes"
		end

	frozen get_show_plus_minus: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.TreeView"
		alias
			"get_ShowPlusMinus"
		end

	get_fore_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.TreeView"
		alias
			"get_ForeColor"
		end

	frozen get_hide_selection: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.TreeView"
		alias
			"get_HideSelection"
		end

	get_back_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.TreeView"
		alias
			"get_BackColor"
		end

	frozen get_path_separator: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.TreeView"
		alias
			"get_PathSeparator"
		end

	get_background_image: SYSTEM_DRAWING_IMAGE is
		external
			"IL signature (): System.Drawing.Image use System.Windows.Forms.TreeView"
		alias
			"get_BackgroundImage"
		end

	frozen get_selected_image_index: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.TreeView"
		alias
			"get_SelectedImageIndex"
		end

	frozen get_show_lines: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.TreeView"
		alias
			"get_ShowLines"
		end

	frozen get_visible_count: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.TreeView"
		alias
			"get_VisibleCount"
		end

	frozen get_selected_node: SYSTEM_WINDOWS_FORMS_TREENODE is
		external
			"IL signature (): System.Windows.Forms.TreeNode use System.Windows.Forms.TreeView"
		alias
			"get_SelectedNode"
		end

	frozen get_show_root_lines: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.TreeView"
		alias
			"get_ShowRootLines"
		end

	frozen get_check_boxes: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.TreeView"
		alias
			"get_CheckBoxes"
		end

feature -- Element Change

	set_text (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.TreeView"
		alias
			"set_Text"
		end

	frozen add_after_expand (value: SYSTEM_WINDOWS_FORMS_TREEVIEWEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.TreeViewEventHandler): System.Void use System.Windows.Forms.TreeView"
		alias
			"add_AfterExpand"
		end

	frozen set_show_root_lines (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.TreeView"
		alias
			"set_ShowRootLines"
		end

	frozen remove_after_expand (value: SYSTEM_WINDOWS_FORMS_TREEVIEWEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.TreeViewEventHandler): System.Void use System.Windows.Forms.TreeView"
		alias
			"remove_AfterExpand"
		end

	frozen set_indent (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.TreeView"
		alias
			"set_Indent"
		end

	frozen remove_after_collapse (value: SYSTEM_WINDOWS_FORMS_TREEVIEWEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.TreeViewEventHandler): System.Void use System.Windows.Forms.TreeView"
		alias
			"remove_AfterCollapse"
		end

	frozen set_show_plus_minus (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.TreeView"
		alias
			"set_ShowPlusMinus"
		end

	frozen add_before_select (value: SYSTEM_WINDOWS_FORMS_TREEVIEWCANCELEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.TreeViewCancelEventHandler): System.Void use System.Windows.Forms.TreeView"
		alias
			"add_BeforeSelect"
		end

	frozen set_path_separator (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.TreeView"
		alias
			"set_PathSeparator"
		end

	frozen remove_item_drag (value: SYSTEM_WINDOWS_FORMS_ITEMDRAGEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.ItemDragEventHandler): System.Void use System.Windows.Forms.TreeView"
		alias
			"remove_ItemDrag"
		end

	frozen set_show_lines (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.TreeView"
		alias
			"set_ShowLines"
		end

	set_back_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.TreeView"
		alias
			"set_BackColor"
		end

	frozen add_after_select (value: SYSTEM_WINDOWS_FORMS_TREEVIEWEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.TreeViewEventHandler): System.Void use System.Windows.Forms.TreeView"
		alias
			"add_AfterSelect"
		end

	frozen set_sorted (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.TreeView"
		alias
			"set_Sorted"
		end

	frozen set_label_edit (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.TreeView"
		alias
			"set_LabelEdit"
		end

	frozen remove_after_select (value: SYSTEM_WINDOWS_FORMS_TREEVIEWEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.TreeViewEventHandler): System.Void use System.Windows.Forms.TreeView"
		alias
			"remove_AfterSelect"
		end

	frozen remove_after_check (value: SYSTEM_WINDOWS_FORMS_TREEVIEWEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.TreeViewEventHandler): System.Void use System.Windows.Forms.TreeView"
		alias
			"remove_AfterCheck"
		end

	frozen add_after_check (value: SYSTEM_WINDOWS_FORMS_TREEVIEWEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.TreeViewEventHandler): System.Void use System.Windows.Forms.TreeView"
		alias
			"add_AfterCheck"
		end

	frozen set_hide_selection (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.TreeView"
		alias
			"set_HideSelection"
		end

	frozen remove_before_label_edit (value: SYSTEM_WINDOWS_FORMS_NODELABELEDITEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.NodeLabelEditEventHandler): System.Void use System.Windows.Forms.TreeView"
		alias
			"remove_BeforeLabelEdit"
		end

	frozen set_selected_node (value: SYSTEM_WINDOWS_FORMS_TREENODE) is
		external
			"IL signature (System.Windows.Forms.TreeNode): System.Void use System.Windows.Forms.TreeView"
		alias
			"set_SelectedNode"
		end

	frozen set_selected_image_index (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.TreeView"
		alias
			"set_SelectedImageIndex"
		end

	set_background_image (value: SYSTEM_DRAWING_IMAGE) is
		external
			"IL signature (System.Drawing.Image): System.Void use System.Windows.Forms.TreeView"
		alias
			"set_BackgroundImage"
		end

	frozen remove_after_label_edit (value: SYSTEM_WINDOWS_FORMS_NODELABELEDITEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.NodeLabelEditEventHandler): System.Void use System.Windows.Forms.TreeView"
		alias
			"remove_AfterLabelEdit"
		end

	frozen add_before_label_edit (value: SYSTEM_WINDOWS_FORMS_NODELABELEDITEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.NodeLabelEditEventHandler): System.Void use System.Windows.Forms.TreeView"
		alias
			"add_BeforeLabelEdit"
		end

	frozen set_check_boxes (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.TreeView"
		alias
			"set_CheckBoxes"
		end

	frozen remove_before_expand (value: SYSTEM_WINDOWS_FORMS_TREEVIEWCANCELEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.TreeViewCancelEventHandler): System.Void use System.Windows.Forms.TreeView"
		alias
			"remove_BeforeExpand"
		end

	frozen set_item_height (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.TreeView"
		alias
			"set_ItemHeight"
		end

	frozen set_scrollable (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.TreeView"
		alias
			"set_Scrollable"
		end

	frozen remove_before_select (value: SYSTEM_WINDOWS_FORMS_TREEVIEWCANCELEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.TreeViewCancelEventHandler): System.Void use System.Windows.Forms.TreeView"
		alias
			"remove_BeforeSelect"
		end

	frozen remove_before_check (value: SYSTEM_WINDOWS_FORMS_TREEVIEWCANCELEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.TreeViewCancelEventHandler): System.Void use System.Windows.Forms.TreeView"
		alias
			"remove_BeforeCheck"
		end

	frozen set_border_style (value: SYSTEM_WINDOWS_FORMS_BORDERSTYLE) is
		external
			"IL signature (System.Windows.Forms.BorderStyle): System.Void use System.Windows.Forms.TreeView"
		alias
			"set_BorderStyle"
		end

	set_fore_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.TreeView"
		alias
			"set_ForeColor"
		end

	frozen add_before_expand (value: SYSTEM_WINDOWS_FORMS_TREEVIEWCANCELEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.TreeViewCancelEventHandler): System.Void use System.Windows.Forms.TreeView"
		alias
			"add_BeforeExpand"
		end

	frozen set_full_row_select (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.TreeView"
		alias
			"set_FullRowSelect"
		end

	frozen add_after_label_edit (value: SYSTEM_WINDOWS_FORMS_NODELABELEDITEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.NodeLabelEditEventHandler): System.Void use System.Windows.Forms.TreeView"
		alias
			"add_AfterLabelEdit"
		end

	frozen remove_before_collapse (value: SYSTEM_WINDOWS_FORMS_TREEVIEWCANCELEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.TreeViewCancelEventHandler): System.Void use System.Windows.Forms.TreeView"
		alias
			"remove_BeforeCollapse"
		end

	frozen set_image_list (value: SYSTEM_WINDOWS_FORMS_IMAGELIST) is
		external
			"IL signature (System.Windows.Forms.ImageList): System.Void use System.Windows.Forms.TreeView"
		alias
			"set_ImageList"
		end

	frozen add_item_drag (value: SYSTEM_WINDOWS_FORMS_ITEMDRAGEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.ItemDragEventHandler): System.Void use System.Windows.Forms.TreeView"
		alias
			"add_ItemDrag"
		end

	frozen set_image_index (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.TreeView"
		alias
			"set_ImageIndex"
		end

	frozen add_before_check (value: SYSTEM_WINDOWS_FORMS_TREEVIEWCANCELEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.TreeViewCancelEventHandler): System.Void use System.Windows.Forms.TreeView"
		alias
			"add_BeforeCheck"
		end

	frozen add_after_collapse (value: SYSTEM_WINDOWS_FORMS_TREEVIEWEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.TreeViewEventHandler): System.Void use System.Windows.Forms.TreeView"
		alias
			"add_AfterCollapse"
		end

	frozen add_before_collapse (value: SYSTEM_WINDOWS_FORMS_TREEVIEWCANCELEVENTHANDLER) is
		external
			"IL signature (System.Windows.Forms.TreeViewCancelEventHandler): System.Void use System.Windows.Forms.TreeView"
		alias
			"add_BeforeCollapse"
		end

	frozen set_hot_tracking (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.TreeView"
		alias
			"set_HotTracking"
		end

feature -- Basic Operations

	to_string: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.TreeView"
		alias
			"ToString"
		end

	frozen end_update is
		external
			"IL signature (): System.Void use System.Windows.Forms.TreeView"
		alias
			"EndUpdate"
		end

	frozen expand_all is
		external
			"IL signature (): System.Void use System.Windows.Forms.TreeView"
		alias
			"ExpandAll"
		end

	frozen get_node_at (pt: SYSTEM_DRAWING_POINT): SYSTEM_WINDOWS_FORMS_TREENODE is
		external
			"IL signature (System.Drawing.Point): System.Windows.Forms.TreeNode use System.Windows.Forms.TreeView"
		alias
			"GetNodeAt"
		end

	frozen collapse_all is
		external
			"IL signature (): System.Void use System.Windows.Forms.TreeView"
		alias
			"CollapseAll"
		end

	frozen begin_update is
		external
			"IL signature (): System.Void use System.Windows.Forms.TreeView"
		alias
			"BeginUpdate"
		end

	frozen get_node_at_int32 (x: INTEGER; y: INTEGER): SYSTEM_WINDOWS_FORMS_TREENODE is
		external
			"IL signature (System.Int32, System.Int32): System.Windows.Forms.TreeNode use System.Windows.Forms.TreeView"
		alias
			"GetNodeAt"
		end

	frozen get_node_count (include_sub_trees: BOOLEAN): INTEGER is
		external
			"IL signature (System.Boolean): System.Int32 use System.Windows.Forms.TreeView"
		alias
			"GetNodeCount"
		end

feature {NONE} -- Implementation

	on_before_select (e: SYSTEM_WINDOWS_FORMS_TREEVIEWCANCELEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.TreeViewCancelEventArgs): System.Void use System.Windows.Forms.TreeView"
		alias
			"OnBeforeSelect"
		end

	create_handle is
		external
			"IL signature (): System.Void use System.Windows.Forms.TreeView"
		alias
			"CreateHandle"
		end

	get_create_params: SYSTEM_WINDOWS_FORMS_CREATEPARAMS is
		external
			"IL signature (): System.Windows.Forms.CreateParams use System.Windows.Forms.TreeView"
		alias
			"get_CreateParams"
		end

	is_input_key (key_data: SYSTEM_WINDOWS_FORMS_KEYS): BOOLEAN is
		external
			"IL signature (System.Windows.Forms.Keys): System.Boolean use System.Windows.Forms.TreeView"
		alias
			"IsInputKey"
		end

	frozen get_item_render_styles (node: SYSTEM_WINDOWS_FORMS_TREENODE; state: INTEGER): SYSTEM_WINDOWS_FORMS_OWNERDRAWPROPERTYBAG is
		external
			"IL signature (System.Windows.Forms.TreeNode, System.Int32): System.Windows.Forms.OwnerDrawPropertyBag use System.Windows.Forms.TreeView"
		alias
			"GetItemRenderStyles"
		end

	wnd_proc (m: SYSTEM_WINDOWS_FORMS_MESSAGE) is
		external
			"IL signature (System.Windows.Forms.Message&): System.Void use System.Windows.Forms.TreeView"
		alias
			"WndProc"
		end

	on_before_label_edit (e: SYSTEM_WINDOWS_FORMS_NODELABELEDITEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.NodeLabelEditEventArgs): System.Void use System.Windows.Forms.TreeView"
		alias
			"OnBeforeLabelEdit"
		end

	on_before_check (e: SYSTEM_WINDOWS_FORMS_TREEVIEWCANCELEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.TreeViewCancelEventArgs): System.Void use System.Windows.Forms.TreeView"
		alias
			"OnBeforeCheck"
		end

	dispose_boolean (disposing: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.TreeView"
		alias
			"Dispose"
		end

	on_key_down (e: SYSTEM_WINDOWS_FORMS_KEYEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.KeyEventArgs): System.Void use System.Windows.Forms.TreeView"
		alias
			"OnKeyDown"
		end

	get_default_size: SYSTEM_DRAWING_SIZE is
		external
			"IL signature (): System.Drawing.Size use System.Windows.Forms.TreeView"
		alias
			"get_DefaultSize"
		end

	on_after_label_edit (e: SYSTEM_WINDOWS_FORMS_NODELABELEDITEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.NodeLabelEditEventArgs): System.Void use System.Windows.Forms.TreeView"
		alias
			"OnAfterLabelEdit"
		end

	on_after_select (e: SYSTEM_WINDOWS_FORMS_TREEVIEWEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.TreeViewEventArgs): System.Void use System.Windows.Forms.TreeView"
		alias
			"OnAfterSelect"
		end

	on_after_expand (e: SYSTEM_WINDOWS_FORMS_TREEVIEWEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.TreeViewEventArgs): System.Void use System.Windows.Forms.TreeView"
		alias
			"OnAfterExpand"
		end

	on_before_expand (e: SYSTEM_WINDOWS_FORMS_TREEVIEWCANCELEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.TreeViewCancelEventArgs): System.Void use System.Windows.Forms.TreeView"
		alias
			"OnBeforeExpand"
		end

	on_key_up (e: SYSTEM_WINDOWS_FORMS_KEYEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.KeyEventArgs): System.Void use System.Windows.Forms.TreeView"
		alias
			"OnKeyUp"
		end

	on_key_press (e: SYSTEM_WINDOWS_FORMS_KEYPRESSEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.KeyPressEventArgs): System.Void use System.Windows.Forms.TreeView"
		alias
			"OnKeyPress"
		end

	on_before_collapse (e: SYSTEM_WINDOWS_FORMS_TREEVIEWCANCELEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.TreeViewCancelEventArgs): System.Void use System.Windows.Forms.TreeView"
		alias
			"OnBeforeCollapse"
		end

	on_handle_destroyed (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.TreeView"
		alias
			"OnHandleDestroyed"
		end

	on_handle_created (e: SYSTEM_EVENTARGS) is
		external
			"IL signature (System.EventArgs): System.Void use System.Windows.Forms.TreeView"
		alias
			"OnHandleCreated"
		end

	on_after_check (e: SYSTEM_WINDOWS_FORMS_TREEVIEWEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.TreeViewEventArgs): System.Void use System.Windows.Forms.TreeView"
		alias
			"OnAfterCheck"
		end

	on_item_drag (e: SYSTEM_WINDOWS_FORMS_ITEMDRAGEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.ItemDragEventArgs): System.Void use System.Windows.Forms.TreeView"
		alias
			"OnItemDrag"
		end

	on_after_collapse (e: SYSTEM_WINDOWS_FORMS_TREEVIEWEVENTARGS) is
		external
			"IL signature (System.Windows.Forms.TreeViewEventArgs): System.Void use System.Windows.Forms.TreeView"
		alias
			"OnAfterCollapse"
		end

end -- class SYSTEM_WINDOWS_FORMS_TREEVIEW
