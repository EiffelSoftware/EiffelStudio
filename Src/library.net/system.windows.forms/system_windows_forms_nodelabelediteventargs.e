indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.Windows.Forms.NodeLabelEditEventArgs"

external class
	SYSTEM_WINDOWS_FORMS_NODELABELEDITEVENTARGS

inherit
	SYSTEM_EVENTARGS

create
	make_nodelabelediteventargs,
	make_nodelabelediteventargs_1

feature {NONE} -- Initialization

	frozen make_nodelabelediteventargs (node: SYSTEM_WINDOWS_FORMS_TREENODE) is
		external
			"IL creator signature (System.Windows.Forms.TreeNode) use System.Windows.Forms.NodeLabelEditEventArgs"
		end

	frozen make_nodelabelediteventargs_1 (node: SYSTEM_WINDOWS_FORMS_TREENODE; label: STRING) is
		external
			"IL creator signature (System.Windows.Forms.TreeNode, System.String) use System.Windows.Forms.NodeLabelEditEventArgs"
		end

feature -- Access

	frozen get_cancel_edit: BOOLEAN is
		external
			"IL signature (): System.Boolean use System.Windows.Forms.NodeLabelEditEventArgs"
		alias
			"get_CancelEdit"
		end

	frozen get_node: SYSTEM_WINDOWS_FORMS_TREENODE is
		external
			"IL signature (): System.Windows.Forms.TreeNode use System.Windows.Forms.NodeLabelEditEventArgs"
		alias
			"get_Node"
		end

	frozen get_label: STRING is
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

end -- class SYSTEM_WINDOWS_FORMS_NODELABELEDITEVENTARGS
