indexing
	description: "Entry in a menu used to hide or show %
				% the context tree."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	CONTEXT_TREE_ENTRY

inherit

	MAIN_PANEL_TOGGLE

creation

	make
	
feature {NONE}

	toggle_pressed is
			-- Display or hide the context tree.
		do
			if armed then
				main_panel.show_context_tree
			else
				main_panel.hide_context_tree
			end
		end

end -- class CONTEXT_TREE_ENTRY
