indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.TreeNode"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_TREE_NODE

inherit
	MARSHAL_BY_REF_OBJECT
		redefine
			to_string
		end
	ICLONEABLE
	ISERIALIZABLE
		rename
			get_object_data as system_runtime_serialization_iserializable_get_object_data
		end

create
	make_winforms_tree_node,
	make_winforms_tree_node_3,
	make_winforms_tree_node_2,
	make_winforms_tree_node_1,
	make_winforms_tree_node_4

feature {NONE} -- Initialization

	frozen make_winforms_tree_node is
		external
			"IL creator use System.Windows.Forms.TreeNode"
		end

	frozen make_winforms_tree_node_3 (text: SYSTEM_STRING; image_index: INTEGER; selected_image_index: INTEGER) is
		external
			"IL creator signature (System.String, System.Int32, System.Int32) use System.Windows.Forms.TreeNode"
		end

	frozen make_winforms_tree_node_2 (text: SYSTEM_STRING; children: NATIVE_ARRAY [WINFORMS_TREE_NODE]) is
		external
			"IL creator signature (System.String, System.Windows.Forms.TreeNode[]) use System.Windows.Forms.TreeNode"
		end

	frozen make_winforms_tree_node_1 (text: SYSTEM_STRING) is
		external
			"IL creator signature (System.String) use System.Windows.Forms.TreeNode"
		end

	frozen make_winforms_tree_node_4 (text: SYSTEM_STRING; image_index: INTEGER; selected_image_index: INTEGER; children: NATIVE_ARRAY [WINFORMS_TREE_NODE]) is
		external
			"IL creator signature (System.String, System.Int32, System.Int32, System.Windows.Forms.TreeNode[]) use System.Windows.Forms.TreeNode"
		end

feature -- Access

	frozen get_tree_view: WINFORMS_TREE_VIEW is
		external
			"IL signature (): System.Windows.Forms.TreeView use System.Windows.Forms.TreeNode"
		alias
			"get_TreeView"
		end

	frozen get_first_node: WINFORMS_TREE_NODE is
		external
			"IL signature (): System.Windows.Forms.TreeNode use System.Windows.Forms.TreeNode"
		alias
			"get_FirstNode"
		end

	frozen get_next_visible_node: WINFORMS_TREE_NODE is
		external
			"IL signature (): System.Windows.Forms.TreeNode use System.Windows.Forms.TreeNode"
		alias
			"get_NextVisibleNode"
		end

	frozen get_selected_image_index: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.TreeNode"
		alias
			"get_SelectedImageIndex"
		end

	frozen get_full_path: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.TreeNode"
		alias
			"get_FullPath"
		end

	frozen get_text: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.TreeNode"
		alias
			"get_Text"
		end

	frozen get_next_node: WINFORMS_TREE_NODE is
		external
			"IL signature (): System.Windows.Forms.TreeNode use System.Windows.Forms.TreeNode"
		alias
			"get_NextNode"
		end

	frozen get_is_visible: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.TreeNode"
		alias
			"get_IsVisible"
		end

	frozen get_prev_node: WINFORMS_TREE_NODE is
		external
			"IL signature (): System.Windows.Forms.TreeNode use System.Windows.Forms.TreeNode"
		alias
			"get_PrevNode"
		end

	frozen get_image_index: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.TreeNode"
		alias
			"get_ImageIndex"
		end

	frozen get_nodes: WINFORMS_TREE_NODE_COLLECTION is
		external
			"IL signature (): System.Windows.Forms.TreeNodeCollection use System.Windows.Forms.TreeNode"
		alias
			"get_Nodes"
		end

	frozen get_checked: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.TreeNode"
		alias
			"get_Checked"
		end

	frozen get_fore_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.TreeNode"
		alias
			"get_ForeColor"
		end

	frozen get_back_color: DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.TreeNode"
		alias
			"get_BackColor"
		end

	frozen get_is_selected: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.TreeNode"
		alias
			"get_IsSelected"
		end

	frozen get_is_editing: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.TreeNode"
		alias
			"get_IsEditing"
		end

	frozen get_parent: WINFORMS_TREE_NODE is
		external
			"IL signature (): System.Windows.Forms.TreeNode use System.Windows.Forms.TreeNode"
		alias
			"get_Parent"
		end

	frozen get_index: INTEGER is
		external
			"IL signature (): System.Int32 use System.Windows.Forms.TreeNode"
		alias
			"get_Index"
		end

	frozen get_bounds: DRAWING_RECTANGLE is
		external
			"IL signature (): System.Drawing.Rectangle use System.Windows.Forms.TreeNode"
		alias
			"get_Bounds"
		end

	frozen get_last_node: WINFORMS_TREE_NODE is
		external
			"IL signature (): System.Windows.Forms.TreeNode use System.Windows.Forms.TreeNode"
		alias
			"get_LastNode"
		end

	frozen get_node_font: DRAWING_FONT is
		external
			"IL signature (): System.Drawing.Font use System.Windows.Forms.TreeNode"
		alias
			"get_NodeFont"
		end

	frozen get_tag: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Windows.Forms.TreeNode"
		alias
			"get_Tag"
		end

	frozen get_handle: POINTER is
		external
			"IL signature (): System.IntPtr use System.Windows.Forms.TreeNode"
		alias
			"get_Handle"
		end

	frozen get_is_expanded: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.TreeNode"
		alias
			"get_IsExpanded"
		end

	frozen get_prev_visible_node: WINFORMS_TREE_NODE is
		external
			"IL signature (): System.Windows.Forms.TreeNode use System.Windows.Forms.TreeNode"
		alias
			"get_PrevVisibleNode"
		end

feature -- Element Change

	frozen set_text (value: SYSTEM_STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.TreeNode"
		alias
			"set_Text"
		end

	frozen set_back_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.TreeNode"
		alias
			"set_BackColor"
		end

	frozen set_tag (value: SYSTEM_OBJECT) is
		external
			"IL signature (System.Object): System.Void use System.Windows.Forms.TreeNode"
		alias
			"set_Tag"
		end

	frozen set_selected_image_index (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.TreeNode"
		alias
			"set_SelectedImageIndex"
		end

	frozen set_node_font (value: DRAWING_FONT) is
		external
			"IL signature (System.Drawing.Font): System.Void use System.Windows.Forms.TreeNode"
		alias
			"set_NodeFont"
		end

	frozen set_image_index (value: INTEGER) is
		external
			"IL signature (System.Int32): System.Void use System.Windows.Forms.TreeNode"
		alias
			"set_ImageIndex"
		end

	frozen set_fore_color (value: DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.TreeNode"
		alias
			"set_ForeColor"
		end

	frozen set_checked (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.TreeNode"
		alias
			"set_Checked"
		end

feature -- Basic Operations

	to_string: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.TreeNode"
		alias
			"ToString"
		end

	frozen collapse is
		external
			"IL signature (): System.Void use System.Windows.Forms.TreeNode"
		alias
			"Collapse"
		end

	frozen ensure_visible is
		external
			"IL signature (): System.Void use System.Windows.Forms.TreeNode"
		alias
			"EnsureVisible"
		end

	frozen toggle is
		external
			"IL signature (): System.Void use System.Windows.Forms.TreeNode"
		alias
			"Toggle"
		end

	frozen expand is
		external
			"IL signature (): System.Void use System.Windows.Forms.TreeNode"
		alias
			"Expand"
		end

	clone_: SYSTEM_OBJECT is
		external
			"IL signature (): System.Object use System.Windows.Forms.TreeNode"
		alias
			"Clone"
		end

	frozen remove is
		external
			"IL signature (): System.Void use System.Windows.Forms.TreeNode"
		alias
			"Remove"
		end

	frozen expand_all is
		external
			"IL signature (): System.Void use System.Windows.Forms.TreeNode"
		alias
			"ExpandAll"
		end

	frozen begin_edit is
		external
			"IL signature (): System.Void use System.Windows.Forms.TreeNode"
		alias
			"BeginEdit"
		end

	frozen end_edit (cancel: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.TreeNode"
		alias
			"EndEdit"
		end

	frozen from_handle (tree: WINFORMS_TREE_VIEW; handle: POINTER): WINFORMS_TREE_NODE is
		external
			"IL static signature (System.Windows.Forms.TreeView, System.IntPtr): System.Windows.Forms.TreeNode use System.Windows.Forms.TreeNode"
		alias
			"FromHandle"
		end

	frozen get_node_count (include_sub_trees: BOOLEAN): INTEGER is
		external
			"IL signature (System.Boolean): System.Int32 use System.Windows.Forms.TreeNode"
		alias
			"GetNodeCount"
		end

feature {NONE} -- Implementation

	frozen system_runtime_serialization_iserializable_get_object_data (si: SERIALIZATION_INFO; context: STREAMING_CONTEXT) is
		external
			"IL signature (System.Runtime.Serialization.SerializationInfo, System.Runtime.Serialization.StreamingContext): System.Void use System.Windows.Forms.TreeNode"
		alias
			"System.Runtime.Serialization.ISerializable.GetObjectData"
		end

end -- class WINFORMS_TREE_NODE
