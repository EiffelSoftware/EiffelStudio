indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.TreeNode"

external class
	SYSTEM_WINDOWS_FORMS_TREENODE

inherit
	SYSTEM_MARSHALBYREFOBJECT
		redefine
			to_string
		end
	SYSTEM_ICLONEABLE

create
	make_treenode_1,
	make_treenode_3,
	make_treenode_4,
	make_treenode_2,
	make_treenode

feature {NONE} -- Initialization

	frozen make_treenode_1 (text: STRING) is
		external
			"IL creator signature (System.String) use System.Windows.Forms.TreeNode"
		end

	frozen make_treenode_3 (text: STRING; image_index: INTEGER; selected_image_index: INTEGER) is
		external
			"IL creator signature (System.String, System.Int32, System.Int32) use System.Windows.Forms.TreeNode"
		end

	frozen make_treenode_4 (text: STRING; image_index: INTEGER; selected_image_index: INTEGER; children: ARRAY [SYSTEM_WINDOWS_FORMS_TREENODE]) is
		external
			"IL creator signature (System.String, System.Int32, System.Int32, System.Windows.Forms.TreeNode[]) use System.Windows.Forms.TreeNode"
		end

	frozen make_treenode_2 (text: STRING; children: ARRAY [SYSTEM_WINDOWS_FORMS_TREENODE]) is
		external
			"IL creator signature (System.String, System.Windows.Forms.TreeNode[]) use System.Windows.Forms.TreeNode"
		end

	frozen make_treenode is
		external
			"IL creator use System.Windows.Forms.TreeNode"
		end

feature -- Access

	frozen get_tree_view: SYSTEM_WINDOWS_FORMS_TREEVIEW is
		external
			"IL signature (): System.Windows.Forms.TreeView use System.Windows.Forms.TreeNode"
		alias
			"get_TreeView"
		end

	frozen get_first_node: SYSTEM_WINDOWS_FORMS_TREENODE is
		external
			"IL signature (): System.Windows.Forms.TreeNode use System.Windows.Forms.TreeNode"
		alias
			"get_FirstNode"
		end

	frozen get_next_visible_node: SYSTEM_WINDOWS_FORMS_TREENODE is
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

	frozen get_full_path: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.TreeNode"
		alias
			"get_FullPath"
		end

	frozen get_text: STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.TreeNode"
		alias
			"get_Text"
		end

	frozen get_next_node: SYSTEM_WINDOWS_FORMS_TREENODE is
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

	frozen get_prev_node: SYSTEM_WINDOWS_FORMS_TREENODE is
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

	frozen get_nodes: SYSTEM_WINDOWS_FORMS_TREENODECOLLECTION is
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

	frozen get_fore_color: SYSTEM_DRAWING_COLOR is
		external
			"IL signature (): System.Drawing.Color use System.Windows.Forms.TreeNode"
		alias
			"get_ForeColor"
		end

	frozen get_back_color: SYSTEM_DRAWING_COLOR is
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

	frozen get_parent: SYSTEM_WINDOWS_FORMS_TREENODE is
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

	frozen get_bounds: SYSTEM_DRAWING_RECTANGLE is
		external
			"IL signature (): System.Drawing.Rectangle use System.Windows.Forms.TreeNode"
		alias
			"get_Bounds"
		end

	frozen get_last_node: SYSTEM_WINDOWS_FORMS_TREENODE is
		external
			"IL signature (): System.Windows.Forms.TreeNode use System.Windows.Forms.TreeNode"
		alias
			"get_LastNode"
		end

	frozen get_node_font: SYSTEM_DRAWING_FONT is
		external
			"IL signature (): System.Drawing.Font use System.Windows.Forms.TreeNode"
		alias
			"get_NodeFont"
		end

	frozen get_tag: ANY is
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

	frozen get_prev_visible_node: SYSTEM_WINDOWS_FORMS_TREENODE is
		external
			"IL signature (): System.Windows.Forms.TreeNode use System.Windows.Forms.TreeNode"
		alias
			"get_PrevVisibleNode"
		end

feature -- Element Change

	frozen set_text (value: STRING) is
		external
			"IL signature (System.String): System.Void use System.Windows.Forms.TreeNode"
		alias
			"set_Text"
		end

	frozen set_back_color (value: SYSTEM_DRAWING_COLOR) is
		external
			"IL signature (System.Drawing.Color): System.Void use System.Windows.Forms.TreeNode"
		alias
			"set_BackColor"
		end

	frozen set_tag (value: ANY) is
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

	frozen set_node_font (value: SYSTEM_DRAWING_FONT) is
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

	frozen set_fore_color (value: SYSTEM_DRAWING_COLOR) is
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

	to_string: STRING is
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

	clone: ANY is
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

	frozen from_handle (tree: SYSTEM_WINDOWS_FORMS_TREEVIEW; handle: POINTER): SYSTEM_WINDOWS_FORMS_TREENODE is
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

end -- class SYSTEM_WINDOWS_FORMS_TREENODE
