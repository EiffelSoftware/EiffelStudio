indexing
	description: "Objects that ..."
	author: ""

class
	TREE_COMPONENT

creation
	make

feature -- Init

	make(vw: VIEWER_WINDOW) is
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
		require
			selected: tree.selected
		local
			elem: TOPIC_TREE_ITEM
		do
			elem ?= tree.selected_item
			viewer.set_selected_topic(elem.topic)
		end

feature -- Implementation

	tree: EV_TREE
	
	viewer: VIEWER_WINDOW

invariant
	TREE_COMPONENT_possible: tree /= Void and viewer /= VOid
end -- class TREE_COMPONENT
