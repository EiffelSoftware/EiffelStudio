indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.TreeViewEventArgs"

external class
	SYSTEM_WINDOWS_FORMS_TREEVIEWEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_treevieweventargs_1,
	make_treevieweventargs

feature {NONE} -- Initialization

	frozen make_treevieweventargs_1 (node: SYSTEM_WINDOWS_FORMS_TREENODE; action: SYSTEM_WINDOWS_FORMS_TREEVIEWACTION) is
		external
			"IL creator signature (System.Windows.Forms.TreeNode, System.Windows.Forms.TreeViewAction) use System.Windows.Forms.TreeViewEventArgs"
		end

	frozen make_treevieweventargs (node: SYSTEM_WINDOWS_FORMS_TREENODE) is
		external
			"IL creator signature (System.Windows.Forms.TreeNode) use System.Windows.Forms.TreeViewEventArgs"
		end

feature -- Access

	frozen get_node: SYSTEM_WINDOWS_FORMS_TREENODE is
		external
			"IL signature (): System.Windows.Forms.TreeNode use System.Windows.Forms.TreeViewEventArgs"
		alias
			"get_Node"
		end

	frozen get_action: SYSTEM_WINDOWS_FORMS_TREEVIEWACTION is
		external
			"IL signature (): System.Windows.Forms.TreeViewAction use System.Windows.Forms.TreeViewEventArgs"
		alias
			"get_Action"
		end

end -- class SYSTEM_WINDOWS_FORMS_TREEVIEWEVENTARGS
