indexing
	description: "The list tab."
	author: "Vincent Brendel"

class
	LIST_COMPONENT

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
			v.set_homogeneous(false)
			create list_edit.make(v)
			v.set_child_expandable(list_edit, false)
			create list.make(v)
			viewer.tabs.append_page(v,"Index")
			create com.make(~item_selected)
			list.add_select_command(com, Void)
			create com.make(~edit_changed)
			list_edit.add_change_command(com, Void)
		end

feature -- Actions

	item_selected(args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		require
			selected: list.selected
		local
			elem: TOPIC_LIST_ITEM
		do
			elem ?= list.selected_item
			viewer.set_selected_topic(elem.topic)
		end

	edit_changed(args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		do
			viewer.list_jump_to_topic(list_edit.text)
		end

feature -- Implementation

	list: EV_LIST

	list_edit: EV_TEXT_FIELD
	
	viewer: VIEWER_WINDOW

invariant
	LIST_COMPONENT_exist: list /= Void and list_edit /= Void and viewer /= Void

end -- class LIST_COMPONENT
