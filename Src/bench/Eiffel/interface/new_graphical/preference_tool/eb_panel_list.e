indexing
	description: "List of panels with its tree representation"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_PANEL_LIST

inherit LINKED_LIST [EB_ENTRY_PANEL]
		rename
			make as make_list
		end

feature {NONE} -- Initialization

	make (a_tool: like tool) is
		do
			make_list
			tool := a_tool
		end

feature -- Constants

	number_of_tree_items: INTEGER is
		deferred
		end

	tree_parent : ARRAY [INTEGER] is 
		deferred
		end

	tree_names : ARRAY [STRING] is
		deferred
		end

	tool: EB_PREFERENCE_TOOL
 
feature -- Adding a panel

	add_preference_panel (a_panel: EB_ENTRY_PANEL) is
			-- Add `a_panel' to the list of all panels.
		require
			a_panel_not_void: a_panel /= Void
			not_created: a_panel.destroyed
		do
			extend (a_panel)
		ensure
			panel_in_list: has (a_panel)
		end

invariant
	right_parents_number: tree_parent.upper = number_of_tree_items
	right_names_number: tree_names.upper = number_of_tree_items
	more_leaves_than_panels : count <= number_of_tree_items

end -- class EB_PANEL_LIST
