indexing
	generator: "Eiffel Emitter 3.1rc1"
	external_name: "System.Windows.Forms.NodeLabelEditEventArgs"
	assembly: "System.Windows.Forms", "1.0.3300.0", "neutral", "b77a5c561934e089"

external class
	WINFORMS_NODE_LABEL_EDIT_EVENT_ARGS

inherit
	EVENT_ARGS

create
	make_winforms_node_label_edit_event_args_1,
	make_winforms_node_label_edit_event_args

feature {NONE} -- Initialization

	frozen make_winforms_node_label_edit_event_args_1 (node: WINFORMS_TREE_NODE; label: SYSTEM_STRING) is
		external
			"IL creator signature (System.Windows.Forms.TreeNode, System.String) use System.Windows.Forms.NodeLabelEditEventArgs"
		end

	frozen make_winforms_node_label_edit_event_args (node: WINFORMS_TREE_NODE) is
		external
			"IL creator signature (System.Windows.Forms.TreeNode) use System.Windows.Forms.NodeLabelEditEventArgs"
		end

feature -- Access

	frozen get_cancel_edit: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.NodeLabelEditEventArgs"
		alias
			"get_CancelEdit"
		end

	frozen get_node: WINFORMS_TREE_NODE is
		external
			"IL signature (): System.Windows.Forms.TreeNode use System.Windows.Forms.NodeLabelEditEventArgs"
		alias
			"get_Node"
		end

	frozen get_label: SYSTEM_STRING is
		external
			"IL signature (): System.String use System.Windows.Forms.NodeLabelEditEventArgs"
		alias
			"get_Label"
		end

feature -- Element Change

	frozen set_cancel_edit (value: BOOLEAN) is
		external
			"IL signature (System.Boolean): System.Void use System.Windows.Forms.NodeLabelEditEventArgs"
		alias
			"set_CancelEdit"
		end

end -- class WINFORMS_NODE_LABEL_EDIT_EVENT_ARGS
