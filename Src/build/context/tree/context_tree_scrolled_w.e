indexing
	description: "A SCROLLED_W that is able to change the size of its %
				% child so that the child always fits on the SCROLLED_T %
				% even if it is resized. Used with a CONTEXT_TREE."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class
	
	CONTEXT_TREE_SCROLLED_W

inherit

	SCROLLED_W
		redefine
			set_size,
			working_area
		end

creation

	make

feature

	set_size (new_width: INTEGER; new_height: INTEGER) is
			-- Set width and height to `new_width'
			-- and `new_height' and resize `child_context_tree'.
		do
			Precursor (new_width, new_height)
		end

	working_area: CONTEXT_TREE is
		local
			a_scrolled_w: CONTEXT_TREE
		do
			a_scrolled_w ?= Precursor
			Result := a_scrolled_w
		end

end -- class CONTEXT_TREE_SCROLLED_W
