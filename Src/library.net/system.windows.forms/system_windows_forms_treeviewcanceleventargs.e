indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.TreeViewCancelEventArgs"

external class
	SYSTEM_WINDOWS_FORMS_TREEVIEWCANCELEVENTARGS

inherit
	SYSTEM_COMPONENTMODEL_CANCELEVENTARGS

create
	make_treeviewcanceleventargs_1,
	make_treeviewcanceleventargs

feature {NONE} -- Initialization

	frozen make_treeviewcanceleventargs_1 (node: SYSTEM_WINDOWS_FORMS_TREENODE; cancel: BOOLEAN) is
		external
			"IL creator signature (System.Windows.Forms.TreeNode, System.Boolean) use System.Windows.Forms.TreeViewCancelEventArgs"
		end

	frozen make_treeviewcanceleventargs (node: SYSTEM_WINDOWS_FORMS_TREENODE; cancel: BOOLEAN; action: SYSTEM_WINDOWS_FORMS_TREEVIEWACTION) is
		external
			"IL creator signature (System.Windows.Forms.TreeNode, System.Boolean, System.Windows.Forms.TreeViewAction) use System.Windows.Forms.TreeViewCancelEventArgs"
		end

feature -- Access

	frozen get_node: SYSTEM_WINDOWS_FORMS_TREENODE is
		external
			"IL signature (): System.Windows.Forms.TreeNode use System.Windows.Forms.TreeViewCancelEventArgs"
		alias
			"get_Node"
		end

	frozen get_action: SYSTEM_WINDOWS_FORMS_TREEVIEWACTION is
		external
			"IL signature (): System.Windows.Forms.TreeViewAction use System.Windows.Forms.TreeViewCancelEventArgs"
		alias
			"get_Action"
		end

end -- class SYSTEM_WINDOWS_FORMS_TREEVIEWCANCELEVENTARGS
