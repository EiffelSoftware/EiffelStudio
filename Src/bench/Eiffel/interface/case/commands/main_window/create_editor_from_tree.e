indexing

	description: 
		"Command to create a window editor.";
	date: "$Date$";
	revision: "$Revision $"

class CREATE_EDITOR_FROM_TREE
inherit
	
	EV_COMMAND;
	ONCES

creation
	make

feature -- Creation

	make (w: like tree; p: like parent_window) is
		do
			tree := w
			parent_window := p
		end

feature -- Properties

	tree: EV_TREE
	parent_window: EV_WINDOW

feature -- Execution

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		local
			create_editor_window: CREATE_EDITOR_WINDOW_COM

			linkable_item: LINKABLE_TREE_ITEM
		do
			if tree /= Void then
				linkable_item ?= tree.selected_item
				if linkable_item /= Void then
					!! create_editor_window.make (parent_window)
					create_editor_window.execute (linkable_item.linkable)
				end
			end
		end;

end -- class CREATE_EDITOR_WINDOW_COM
