indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.TreeViewEventArgs"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_TREE_VIEW_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_winforms_tree_view_event_args,
	make_winforms_tree_view_event_args_1

feature {NONE} -- Initialization

	frozen make_winforms_tree_view_event_args (node: WINFORMS_TREE_NODE) is
		external
			"IL creator signature (System.Windows.Forms.TreeNode) use System.Windows.Forms.TreeViewEventArgs"
		end

	frozen make_winforms_tree_view_event_args_1 (node: WINFORMS_TREE_NODE; action: WINFORMS_TREE_VIEW_ACTION) is
		external
			"IL creator signature (System.Windows.Forms.TreeNode, System.Windows.Forms.TreeViewAction) use System.Windows.Forms.TreeViewEventArgs"
		end

feature -- Access

	frozen get_node: WINFORMS_TREE_NODE is
		external
			"IL signature (): System.Windows.Forms.TreeNode use System.Windows.Forms.TreeViewEventArgs"
		alias
			"get_Node"
		end

	frozen get_action: WINFORMS_TREE_VIEW_ACTION is
		external
			"IL signature (): System.Windows.Forms.TreeViewAction use System.Windows.Forms.TreeViewEventArgs"
		alias
			"get_Action"
		end

end -- class WINFORMS_TREE_VIEW_EVENT_ARGS
