indexing
	description: "The 'Tree' tab in the notebook."
	author: "Vincent Brendel"

class
	TREE_COMPONENT

creation
	make

feature -- Initialization

	make(vw: VIEWER_WINDOW) is
			-- Initialize on 'vw'.
		require
			not_void: vw /= Void
		local
			v: EV_VERTICAL_BOX
			com: EV_ROUTINE_COMMAND
		do
			viewer := vw
			create v.make(viewer.tabs)
			create tree.make(v)
			viewer.tabs.append_page(v,"Tree")
			!! com.make(~item_selected)
			tree.add_select_command(com, Void)
		end

feature -- Actions

	item_selected (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Called when the selected item changes in the tree.
		require
			selected: tree.selected
		local
			elem: TOPIC_TREE_ITEM
		do
			elem ?= tree.selected_item
			viewer.set_selected_topic(elem.topic)
		end

feature -- Access

	tree: EV_TREE
			-- The topic structure display component.

feature -- Implementation
	
	viewer: VIEWER_WINDOW
			-- The main window.

invariant
	TREE_COMPONENT_possible: tree /= Void and viewer /= Void

end -- class TREE_COMPONENT
