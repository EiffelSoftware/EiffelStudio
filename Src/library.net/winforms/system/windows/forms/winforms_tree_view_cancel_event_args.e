indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.TreeViewCancelEventArgs"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_TREE_VIEW_CANCEL_EVENT_ARGS

inherit
	SYSTEM_DLL_CANCEL_EVENT_ARGS

create
	make_winforms_tree_view_cancel_event_args

feature {NONE} -- Initialization

	frozen make_winforms_tree_view_cancel_event_args (node: WINFORMS_TREE_NODE; cancel: BOOLEAN; action: WINFORMS_TREE_VIEW_ACTION) is
		external
			"IL creator signature (System.Windows.Forms.TreeNode, System.Boolean, System.Windows.Forms.TreeViewAction) use System.Windows.Forms.TreeViewCancelEventArgs"
		end

feature -- Access

	frozen get_node: WINFORMS_TREE_NODE is
		external
			"IL signature (): System.Windows.Forms.TreeNode use System.Windows.Forms.TreeViewCancelEventArgs"
		alias
			"get_Node"
		end

	frozen get_action: WINFORMS_TREE_VIEW_ACTION is
		external
			"IL signature (): System.Windows.Forms.TreeViewAction use System.Windows.Forms.TreeViewCancelEventArgs"
		alias
			"get_Action"
		end

end -- class WINFORMS_TREE_VIEW_CANCEL_EVENT_ARGS
